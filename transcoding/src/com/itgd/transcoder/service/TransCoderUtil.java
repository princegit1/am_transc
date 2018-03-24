/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.service;

import java.util.ArrayList;
import java.util.List;

import com.amazonaws.services.elastictranscoder.AmazonElasticTranscoderClient;
import com.amazonaws.services.elastictranscoder.model.CreateJobOutput;
import com.amazonaws.services.elastictranscoder.model.CreateJobPlaylist;
import com.amazonaws.services.elastictranscoder.model.CreateJobRequest;
import com.amazonaws.services.elastictranscoder.model.CreateJobResult;
import com.amazonaws.services.elastictranscoder.model.Job;
import com.amazonaws.services.elastictranscoder.model.JobInput;
import com.amazonaws.services.elastictranscoder.model.JobWatermark;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.CopyObjectResult;
import com.amazonaws.services.s3.model.ListObjectsRequest;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.itgd.transcoder.bean.AmazobAwsJobOutputDesc;
import com.itgd.transcoder.confg.AppConfig;
import com.itgd.transcoder.dao.AmazonTranscodingDAO;
import com.itgd.transcoder.provider.AmazonClientProvider;
import com.itgd.transcoder.provider.AmazonS3BucketProvider;


public class TransCoderUtil {

    public AppConfig appConfig;
    public String processingRootLocationName;
    public String processedRootLocationName;
    public String uploadBucketName;
    public String uploadedRootLocationName;
    public String transcodingOutputLocationName;
    public AmazonTranscodingDAO amazonTranscodingDAO = new AmazonTranscodingDAO();
    private AWSS3BucketService awsS3BucketService = new AWSS3BucketService();    
    
    public static void main(String...args) throws Exception {
        new TransCoderUtil().transcodeObject("","");
        String ss="00123";
        for(int i=0; i<ss.length(); i++)
        {
        	ss.charAt(i);
        }
    }    
    public void transcodeObject(String profileId,String inputBitRate) throws Exception { 
        java.util.Calendar cal = java.util.Calendar.getInstance();
        String jobMarker = profileId+"_"+cal.getTimeInMillis();
        appConfig = new AppConfig(profileId,inputBitRate);
        List<String> outputjobIdList = new ArrayList<String>();
        AmazonElasticTranscoderClient client = AmazonClientProvider.getClient();
        processingRootLocationName = appConfig.getProcessingRootLocationName();
        uploadBucketName = appConfig.getUploadBucketName();
        processedRootLocationName = appConfig.getProcessedRootLocationName();
        uploadedRootLocationName = appConfig.getUploadedRootLocationName();
        transcodingOutputLocationName = appConfig.getTranscodingOutputLocationName();
        System.out.println("processingRootLocationName-->"+processingRootLocationName);
        System.out.println("uploadBucketName-->"+uploadBucketName);
        System.out.println("processedRootLocationName-->"+processedRootLocationName);
        System.out.println("uploadedRootLocationName-->"+uploadedRootLocationName);
        System.out.println("transcodingOutputLocationName-->"+transcodingOutputLocationName);
        System.out.println(appConfig.getUploadBucketName());
        List<S3ObjectSummary> objectSummaryList = getItemListFromProcessingFolder();
        java.util.Date curDate = new java.util.Date();   
        int ctt =0;
        for(S3ObjectSummary objectSummary: objectSummaryList) {
           if(!objectSummary.getKey().trim().contains(".") )  {
                continue;
            }  
            if(objectSummary.getKey().startsWith(uploadedRootLocationName) 
                    && objectSummary.getKey().length()>uploadedRootLocationName.trim().length()) 
            {
                if(++ctt > 1) break;
                String mediaFileName = objectSummary.getKey().replace(uploadedRootLocationName, "");
                CopyObjectResult copyObjectResult = awsS3BucketService.copyItem1( 
                        appConfig.getUploadBucketName(),
                        appConfig.getUploadBucketName(),
                        objectSummary.getKey(), 
                        processingRootLocationName+mediaFileName);
                       System.out.println("copy is success from "+  appConfig.getUploadBucketName()+objectSummary.getKey() +" To "+ processingRootLocationName+mediaFileName);
                if(true) {
                	//System.out.println("Singla"+copyObjectResult);
                    if(objectSummary.getKey().contains(".") &&(objectSummary.getKey().contains("/upload")|| objectSummary.getKey().contains("/uploadstg/") || objectSummary.getKey().contains("/upload/") || objectSummary.getKey().contains("/uploadtest/"))) {
                       awsS3BucketService.deleteObject1(objectSummary.getKey(),appConfig.getUploadBucketName());  
                      // System.out.println("deleted file "+  objectSummary.getKey());
                    }
                    try
                    {
                    System.out.println(objectSummary.getKey());
                    Job job = transCodeObject(client,objectSummary, jobMarker);
                    outputjobIdList.add(job.getId());
                    }
                    catch (Exception e) {
                    	System.out.println("Exception at  Job job = transCodeObject----> ");
                    	e.printStackTrace();
					}
                }                                
            }
        }        
    }
    public Job transCodeObject(AmazonElasticTranscoderClient client, S3ObjectSummary objectSummary,String jobMarker) throws Exception 
    {
        List<CreateJobOutput> outputList = new java.util.ArrayList<CreateJobOutput>();
        List<CreateJobPlaylist> outputplaylist = new java.util.ArrayList<CreateJobPlaylist>();
        List<JobWatermark> outputwatermark = new java.util.ArrayList<JobWatermark>();
        String filename="";
        int hlsBitrateCount=0;
        System.out.println("########################...showRunJob is on process ...########################");
        System.out.println("Creating JOB ....");        
        CreateJobRequest jobRequest = new CreateJobRequest();
        List<String> outplaylist = new java.util.ArrayList<String>(3);        
        System.out.println("Setting Preset ID ....");        
        jobRequest.setPipelineId(appConfig.getPipelindId());
        System.out.println("Setting Input ....");                
        JobInput input = new JobInput();
        		input.setContainer("auto");
                input.setFrameRate("auto");
                input.setAspectRatio("auto");
                input.setResolution("auto");
                input.setInterlaced("auto");
                String inputFile = objectSummary.getKey();
                System.out.println(uploadedRootLocationName+"--inputFile------------------------------------------>"+inputFile);
                inputFile = inputFile.replace(uploadedRootLocationName, processingRootLocationName);
                System.out.println(uploadedRootLocationName+"---inputFile------------------------------------------>"+inputFile);
                input.setKey(inputFile);
                jobRequest.setInput(input);
        //System.out.println("Setting CreateJobOutput  ...."); 
        if(appConfig.getWatermark_place()!=null || appConfig.getWatermark()!=null)
        {
        	JobWatermark jobWater=new JobWatermark();
        	jobWater.setPresetWatermarkId(appConfig.getWatermark_place().trim());
        	jobWater.setInputKey(appConfig.getWatermark().trim());
        	outputwatermark.add(jobWater);
        }
        else
        {
        }
        for(AmazobAwsJobOutputDesc awsJobOutput: appConfig.getListAWSJobOutputDescs()) {
            System.out.println("Setting CreateJobOutput  ...."+awsJobOutput.getPresetId()); 
                String oldFileKeyName = objectSummary.getKey();
                System.out.println(objectSummary.getKey());
                String fileloc = oldFileKeyName.substring(0,oldFileKeyName.lastIndexOf("/"));
                System.out.println(fileloc);        
                filename = oldFileKeyName.substring(oldFileKeyName.lastIndexOf("/")+1, oldFileKeyName.lastIndexOf("."));
                System.out.println(filename);
                String filetype = oldFileKeyName.substring(oldFileKeyName.lastIndexOf("."));
                System.out.println(filetype);
                filetype=".mp4";
                String outFileName="";
                String playlistfilepath="";
                String outputPrefix="";
                if(awsJobOutput.getFolderName().equals("512"))
                {	
                	if(awsJobOutput.getHlsFormat().equals(1))
                	{
                		playlistfilepath = awsJobOutput.getFolderName()+"/"+filename+"/"+filename+"_"+awsJobOutput.getFilenameSuffix();
                		hlsBitrateCount=1;
                	}else
                	{
                		outFileName = filename+filetype;
                	}
                }else
                {	
                	if(awsJobOutput.getHlsFormat().equals(1))
                	{
                		playlistfilepath = awsJobOutput.getFolderName()+"/"+filename+"/"+filename+"_"+awsJobOutput.getFilenameSuffix();
                		hlsBitrateCount=1;
                	}else
                	{
                		outFileName = awsJobOutput.getFolderName()+"/"+filename+"_"+awsJobOutput.getFilenameSuffix()+filetype;
                	}
                }
           // System.out.println("filename---------------------------->"+filename);
           // System.out.println("fileloc------------------>>>>>>>>>>>>>>>>>>>>"+fileloc);
           // System.out.println("uploadedRootLocationName----------------------->"+uploadedRootLocationName);
           // System.out.println("transcodingOutputLocationName----------------------->"+transcodingOutputLocationName);
            outputPrefix=fileloc.replace(uploadedRootLocationName, transcodingOutputLocationName);
          //  System.out.println("outputPrefix------------------>>>>>>>>>>>>>>>>>>>>"+outputPrefix);
            jobRequest.setOutputKeyPrefix(outputPrefix+"/");    
            outFileName = outFileName.replace(uploadedRootLocationName, transcodingOutputLocationName);
           // System.out.println("outFileName------->>>>>>>>>>"+outFileName);
            if(awsJobOutput.getHlsFormat().equals(1))
            {
            	CreateJobOutput jobOutput = new CreateJobOutput();
            	jobOutput.setKey(playlistfilepath);
            	jobOutput.setThumbnailPattern("");
                jobOutput.setPresetId(awsJobOutput.getPresetId()); 
                jobOutput.setSegmentDuration("10");
                jobOutput.setRotate("auto");
                outputList.add(jobOutput);
                outplaylist.add(playlistfilepath);
                for(int h=0;h<outplaylist.size();h++)
                {
                	System.out.println("Value in the Output Playlist--------> "+outplaylist.get(h));
                }
            }else
            {
            	CreateJobOutput jobOutput = new CreateJobOutput();
            	jobOutput.setKey(outFileName);
                jobOutput.setPresetId(awsJobOutput.getPresetId());  
                jobOutput.setRotate("auto");
                jobOutput.setThumbnailPattern("");
                System.out.println("jobOutput.setWatermarks(outputwatermark);"+outputwatermark.size());
                System.out.println("jobOutput.setWatermarks(outputwatermark);"+outputwatermark);
                jobOutput.setWatermarks(outputwatermark);
                outputList.add(jobOutput);
            }
        }
        if(hlsBitrateCount==1)
        {
        CreateJobPlaylist jobPlaylist=new CreateJobPlaylist();
        jobPlaylist.setName(filename);
        jobPlaylist.setFormat("HLSv3");
        jobPlaylist.setOutputKeys(outplaylist);
        outputplaylist.add(jobPlaylist);
        jobRequest.setPlaylists(outputplaylist);
        }
        jobRequest.setOutputs(outputList);
        System.out.println("Execute createJob ....");
        Job job=null;
        if(jobRequest!=null)
        {
        System.out.println("video transcode start....");
        CreateJobResult createJobResult = client.createJob(jobRequest);  
        System.out.println("video transcode finished.");
        job = createJobResult.getJob();
        System.out.println("insertion in database start...");
        amazonTranscodingDAO.createAndPopulateJobDetail(job, jobMarker);
        System.out.println("insertion in database finished."); 
        System.out.println("Job Id ... - "+job.getId());                        
        System.out.println("Job Status ... - "+job.getStatus()); 
        System.out.println("Job Status ... - "+job.getOutput().getStatusDetail());    
        }
        else
        {
        	System.out.println("jobRequest===="+jobRequest);
        }
        return job;
    }    
    public List<S3ObjectSummary> getItemListFromProcessingFolder() throws Exception{
       // System.out.println("getItemListFromProcessingFolder Called........"); 
        AmazonS3 S3 = AmazonS3BucketProvider.getS3Bucket();
        // S3.setObjectAcl(appConfig.getUploadBucketName(),appConfig.getProcessedRootLocationName(), CannedAccessControlList.PublicRead);
         ListObjectsRequest listObjectsRequest = new ListObjectsRequest();
        listObjectsRequest.setBucketName(appConfig.getUploadBucketName());
        listObjectsRequest.setPrefix(appConfig.getUploadedRootLocationName());            
        ObjectListing objectListring =S3.listObjects(listObjectsRequest);         
        List<S3ObjectSummary> objectSummaryList = objectListring.getObjectSummaries();   
        return objectSummaryList;
    }    
}

