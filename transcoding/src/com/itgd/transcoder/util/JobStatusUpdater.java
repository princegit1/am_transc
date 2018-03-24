/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.util;


import com.amazonaws.regions.Region;
import com.amazonaws.services.elastictranscoder.AmazonElasticTranscoderClient;
import com.amazonaws.services.elastictranscoder.model.Job;
import com.amazonaws.services.elastictranscoder.model.ReadJobRequest;
import com.amazonaws.services.elastictranscoder.model.ReadJobResult;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CopyObjectRequest;
import com.amazonaws.services.s3.model.CopyObjectResult;
import com.itgd.transcoder.bean.AmazonAwsJobDesc;
import com.itgd.transcoder.bean.AmazonTranscoding;
import com.itgd.transcoder.bean.TranscodingProcessLog;
import com.itgd.transcoder.confg.AppConfig;
import com.itgd.transcoder.dao.AmazonTranscodingDAO;
import com.itgd.transcoder.provider.RegionServiceProvider;
import java.util.List;

/**
 *
 * @author Honey
 */
public class JobStatusUpdater {
     
    AmazonTranscodingDAO amazonTranscodingDAO = new AmazonTranscodingDAO();     

    public static void main(String...args) {
        new JobStatusUpdater().updateJob(6);
        new JobStatusUpdater().updateJob(6);
        new JobStatusUpdater().updateJob(6);
        System.out.println("**********uplodate job finished*************");
    }

    public void updateJob(int profileId) {
    	System.out.println("**********uplodate job start*************");
            List<AmazonTranscoding> amazonTranscodingsList = null;
            try {
                amazonTranscodingsList = amazonTranscodingDAO.listAmazonTranscodingBySqlQuery("SELECT * FROM transcoding_input WHERE job_creation_datetime > DATE_SUB(NOW(), INTERVAL 24 HOUR) AND job_status IN ('Submitted','Progressing')");
            }catch(Exception ex) {
                ex.printStackTrace();
            }
            String tmpJobStatus = "";
            AppConfig appConfig = null;
            AmazonTranscodingDAO atdao  = new AmazonTranscodingDAO();
            String xmlData=null;
            AmazonS3 S3=null;
            String postJobStatus=null;
            Xmlpost xmlpost=new Xmlpost();
            String processingRootLocationName = null;
            String processedRootLocationName = null;
            String transcodingErrorLocationName = null;  
            AmazonElasticTranscoderClient client = null;
            TranscodingProcessLog transcodingProcessLog=null;
           // String ProfileId=CommonUtil.getProfileIdFromConfiguration("profileId");
            AmazonAwsJobDesc amazonAwsJobDesc=null;
			try {
				amazonAwsJobDesc = atdao.getAmazonAwsJobDescByid(profileId);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
            String readXmlPath=amazonAwsJobDesc.getXmlReadPath();
            String postXmlPath=amazonAwsJobDesc.getXmlPostPath();
            //String readXmlPath=CommonUtil.getProfileIdFromConfiguration("readXmlPath");
            //String postXmlPath=CommonUtil.getProfileIdFromConfiguration("postXmlPath");
            for(AmazonTranscoding o: amazonTranscodingsList) {
                    try {
                            appConfig = new AppConfig(o.getJobMarker().split("_")[0],"");
                            processingRootLocationName = appConfig.getProcessingRootLocationName();
                            processedRootLocationName = appConfig.getProcessedRootLocationName();
                            transcodingErrorLocationName = appConfig.getTranscodingErrorLocationName();
                            S3 = buildS3BucketClient();
                            client = createClient();
                    }catch(Exception ex) {
                        ex.printStackTrace();
                    }                
                Job job = getJobById(client,o.getJobId());
                System.out.println("log ...1 reading jobID - "+o.getJobId());
                try {
                        tmpJobStatus = amazonTranscodingDAO.updateJob(job,o.getJobMarker().split("_")[0]);
                        System.out.println("--------------Job--------------------------------");
                        System.out.println("JobID - "+job.getId());
                        System.out.println("PipelineId - "+job.getPipelineId());
                        System.out.println("JobStatus - "+job.getStatus());            
//                        System.out.println("Status - "+job.getOutput().getStatus());            
//                        System.out.println("JobStatusDetail - "+job.getOutput().getStatusDetail());
                        try {
                            if(job.getStatus().equals("Complete")) {
                                System.out.println("::Complete:: Copying file..;");
                                copyObject(S3,appConfig.getUploadBucketName(),
                                        appConfig.getUploadBucketName(),
                                        job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, processedRootLocationName));                            
                                System.out.println("::Complete:: Deleting file from upload folder alfer successfull copy...");
                                if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing")) {                                    
                                    deleteObject(S3,job.getInput().getKey(),appConfig.getUploadBucketName());                                                                        
                                }
                                //transcoding log table entry start 
                                transcodingProcessLog=new TranscodingProcessLog();
                       	        transcodingProcessLog.setSourcePath(job.getInput().getKey());
                       	        transcodingProcessLog.setDestinationPath(job.getInput().getKey().replace(processingRootLocationName, processedRootLocationName));
                       	        transcodingProcessLog.setProfileId(profileId);
                       	        transcodingProcessLog.setOutputStatus(job.getStatus());
                       	        atdao=new AmazonTranscodingDAO();
                       	        atdao.saveTranscodingProcessLog(transcodingProcessLog);
                       	        
                             //  transcoding log table entry start 
                       	        
                       	     /*--------------reading & posting Xml start-----------*/
                       	         
                       	          if(readXmlPath!=null && job.getInput().getKey()!=null)
                                   readXmlPath=readXmlPath.replace("profileId=?", "profileId="+profileId).replace("videoName=?", "videoName="+(job.getInput().getKey()!=null ? job.getInput().getKey().replaceAll(amazonAwsJobDesc.getProcessBasePath(),""): ""));
                         	      System.out.println("Xml Reading from "+readXmlPath);
                         	      xmlData=xmlpost.redXml(readXmlPath);
                         	      System.out.println("Xml Reading finished ");
                         	      System.out.println("posting xml on "+postXmlPath);
                         	      if(xmlData!=null && xmlData.length()>0)
                         	      {
                         	    	postJobStatus=xmlpost.xmlPost(postXmlPath, xmlData);
                         	    	System.out.println("xml post Status--->>>"+postJobStatus);
                         	      }
                         	      else
                         	      {
                         	    	  System.out.println("xml data is "+readXmlPath);
                         	      }
                         	      
                         	   /*--------------reading & posting Xml end-----------*/
                                System.out.println("::Complete:: Copy and delet finished...");
                              }else if(job.getStatus().equals("Error"))
                            {
                                System.out.println("::JobError:: Copying file..;");
                                copyObject(S3,appConfig.getUploadBucketName(),
                                        appConfig.getUploadBucketName(),
                                        job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, transcodingErrorLocationName));                            
                                System.out.println("::JobError:: Deleting file from upload folder alfer successfull copy...");
                                if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing")) {                                    
                                    deleteObject(S3,job.getInput().getKey(),appConfig.getUploadBucketName());                                    
                                }                                
                                System.out.println("::JobError:: Copy and delet finished...");
                                //transcoding log table entry start 
                                transcodingProcessLog=new TranscodingProcessLog();
                       	        transcodingProcessLog.setSourcePath(job.getInput().getKey());
                       	        transcodingProcessLog.setDestinationPath(job.getInput().getKey().replace(processingRootLocationName, transcodingErrorLocationName));
                       	        transcodingProcessLog.setProfileId(profileId);
                       	        transcodingProcessLog.setOutputStatus(job.getStatus());
                       	        atdao=new AmazonTranscodingDAO();
                       	        atdao.saveTranscodingProcessLog(transcodingProcessLog);
                       	        
                              //  transcoding log table entry start 
                       	       
                       	        
                            }
                        }catch(Exception ex) {
                            ex.printStackTrace();
                        } 
                        System.out.println("Log ....4.2 .....");
                }catch(Exception ex) {
                    ex.printStackTrace();
                    try {
                            System.out.println("::JobException:: Copying file..;");
                            copyObject(S3,appConfig.getUploadBucketName(),
                                    appConfig.getUploadBucketName(),
                                    job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, transcodingErrorLocationName));                            
                            System.out.println("::JobException:: Deleting file from upload folder alfer successfull copy...");
                            if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing")) {                                
                                deleteObject(S3,job.getInput().getKey(),appConfig.getUploadBucketName());                                
                            }
                            System.out.println("::JobException:: Copy and delet finished...");
                    }catch(Exception e2) {
                        e2.printStackTrace();
                    }
                }
            }
            System.out.println("**********uplodate job finished*************");
            System.out.println("log....END/cancel.....");
    }
     
    private AmazonElasticTranscoderClient createClient() {
        try {            
                AmazonElasticTranscoderClient client = new AmazonElasticTranscoderClient(CredentialUtil.getITGDS3Credential());
                client.setRegion(RegionServiceProvider.getRegion());
                return client;
        } catch (Throwable ex) {
            // Make sure you log the exception, as it might be swallowed
            System.err.println("Initial AmazonElasticTranscoderClient creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }          
    }    
    
    public AmazonS3 buildS3BucketClient() {
        try {            
                AmazonS3 S3 = new AmazonS3Client(CredentialUtil.getITGDS3Credential());
                Region maleshia = RegionServiceProvider.getRegion();
                S3.setRegion(maleshia);            
                return S3;

        } catch (Throwable ex) {
            // Make sure you log the exception, as it might be swallowed
            System.err.println("Initial AmazonS3 creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }  
    }     
    
    public CopyObjectResult copyObject(AmazonS3 S3,String inB,String outB,String inpLoc, String outLoc) {
        CopyObjectResult copyObjectResult = null;
        try {
            CopyObjectRequest copyObjectRequest = new CopyObjectRequest(inB, inpLoc, outB, outLoc);
            copyObjectResult =  S3.copyObject(copyObjectRequest);
                     System.out.println("-------------Coping file-----------");
                     System.out.println("In Loc ...."+inpLoc);
                     System.out.println("Out Loc ...."+outLoc);
                     System.out.println("ETag ...."+copyObjectResult.getETag());        
                     System.out.println("ExpirationTimeRuleId ...."+copyObjectResult.getExpirationTimeRuleId());        
                     System.out.println("LastModifiedDate ...."+copyObjectResult.getLastModifiedDate());                
        }catch(Exception ex) {ex.printStackTrace();}
        return copyObjectResult;
    }       
    
    public void deleteObject(AmazonS3 S3,String key,String bucket) throws Exception {              
        try {
            S3.deleteObject(bucket, key);
            System.out.println("FileDeleted -> "+key);
        }catch(Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }
    }       
    
    public Job getJobById(AmazonElasticTranscoderClient client, String jobId) 
    {
        ReadJobRequest jobRequest = new ReadJobRequest();
        jobRequest.setId(jobId);
        ReadJobResult jobResult = client.readJob(jobRequest);
        Job job = jobResult.getJob();
        return job;
    }    
    
}

