/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.util;

import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.itgd.transcoder.bean.AmazonAwsJobDesc;
import com.itgd.transcoder.dao.AmazonTranscodingDAO;
import com.itgd.transcoder.provider.AmazonS3BucketProvider;
import com.itgd.transcoder.service.TransCoderUtil;

/**
 *
 * @author Honey
 */
public class TranscoderJobCron {
    Timer timer;
 	String inputBitRate=null;
 	int profileId=0;
         
    public TranscoderJobCron() {
    }       
    public TranscoderJobCron(int seconds,int profileId) {
    	this.profileId=profileId;
        timer = new Timer();  //At this line a new Thread will be created
        timer.schedule(new TranscoderJobCron.UpdateJobStatus(), seconds*1000); //delay in milliseconds
    }   

    
    class UpdateJobStatus extends TimerTask {
        @Override
        public void run() {
            trancCron();
        }
    }     
    
    
     public void trancCron() {
            System.out.println();
            System.out.println("***************************************************************************************");
            System.out.println("***************************************************************************************");
            System.out.println("******                    Start Cron  Executing cron for transcod submit                ***********************************");
            System.out.println("***************************************************************************************");
            System.out.println("***************************************************************************************");         
            System.out.println("Executing cron for transcod submit -");
            String inputBitRate=null;
         TranscoderJobCron cron = new TranscoderJobCron();
         AmazonTranscodingDAO atdao  = new AmazonTranscodingDAO();
         AmazonS3 S3 = AmazonS3BucketProvider.getS3Bucket();
         try 
         {
                //List<AmazonAwsJobDesc> amazonAwsJobDescsList = atdao.listAmazonAwsJobDesc();
        	   AmazonAwsJobDesc amazonAwsJobDesc= null;
        	  //String ProfileId=CommonUtil.getProfileIdFromConfiguration("profileId");
        	  String extension=CommonUtil.getProfileIdFromConfiguration("extension");
        	
        	 if(profileId!=0)
        	 {
        		 amazonAwsJobDesc= atdao.getAmazonAwsJobDescByid(profileId);
        	 }
        	 if(amazonAwsJobDesc!=null)
        	 {
                    List<S3ObjectSummary> objectSummaryList = CommonUtil.getItemListFromProcessingFolder(S3, amazonAwsJobDesc.getInputBasePath(),amazonAwsJobDesc.getBucketInput());
                    if(objectSummaryList!=null && objectSummaryList.size()>0) {
                            for(S3ObjectSummary o: objectSummaryList) {
                            	 if(o.getKey().contains(".") && extension!=null && extension.contains((o.getKey().substring(o.getKey().lastIndexOf(".")+1,o.getKey().length())).toLowerCase())){
                            	  inputBitRate=o.getKey().substring(o.getKey().lastIndexOf("_")+1,o.getKey().lastIndexOf("."));
                            	    if(CommonUtil.isInteger(inputBitRate))
                            	    {                            	    	
                            	      TransCoderUtil coderUtil = new TransCoderUtil();
                                      if(inputBitRate!=null && inputBitRate.length()>0)
                                    	  try
                                      {
                                      coderUtil.transcodeObject(""+amazonAwsJobDesc.getProfileId(),inputBitRate);
                                      }
                                      catch (Exception e) {
									}}
                            	    else
                            	    {
                                      System.out.println("invalid video name formate(videoname_bitrate.extension)-->"+o.getKey());  
                            	    }
                              }
                            	 else
                            	 {
                            		 System.out.println(" This video extension is not supported -->"+o.getKey());  	 
                            	 }
                        }
                    }
                }
                timer.cancel();
//                new TranscoderJobCron(300);
                
         }catch(Exception e) {
             e.printStackTrace();
         }
         
     }
     
    
   
    
     public void runCron() {
         new TranscoderJobCron(1,1);
     }    
     
     
     public static void main(String...args){
         new TranscoderJobCron(1,6);
     }
}
