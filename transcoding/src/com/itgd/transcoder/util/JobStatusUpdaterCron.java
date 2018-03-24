/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.util;


import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Honey
 */
public class JobStatusUpdaterCron {
     Timer timer;
     int profileId=0;
     public JobStatusUpdaterCron()
     {
    	 
     }
    public JobStatusUpdaterCron(int seconds,int profileId) {
    	this.profileId=profileId;
        timer = new Timer();  //At this line a new Thread will be created
        timer.schedule(new JobStatusUpdaterCron.UpdateJobStatus(), seconds*1000); //delay in milliseconds
    }

    class UpdateJobStatus extends TimerTask {

        @Override
        public void run() {
            new JobStatusUpdater().updateJob(profileId);
        }
//        public void run() {
//            List<AmazonTranscoding> amazonTranscodingsList = null;
//            try {
//                amazonTranscodingsList = amazonTranscodingDAO.listAmazonTranscodingBySqlQuery("SELECT * FROM amazon_transcoding WHERE job_creation_time > DATE_SUB(NOW(), INTERVAL 24 HOUR) AND job_status IN ('Submitted','Progressing')");
//            }catch(Exception ex) {
//                ex.printStackTrace();
//            }
//           
//            String tmpJobStatus = "";
//            AppConfig appConfig = null;
//
//            AmazonS3 S3=null;
//
//            
//            //clientService\
//            //             
////            for(String jobId: outputjobIdList) {
//            for(AmazonTranscoding o: amazonTranscodingsList) {
//                            String processingRootLocationName = null;
//                            String processedRootLocationName = null;
//                            String transcodingErrorLocationName = null;                
//                            try {
//                                    appConfig = new AppConfig(o.getJobMarker().split("_")[0]);
//                                    processingRootLocationName = appConfig.getProcessingRootLocationName();
//                                    processedRootLocationName = appConfig.getProcessedRootLocationName();
//                                    transcodingErrorLocationName = appConfig.getTranscodingErrorLocationName();
//                                    S3 = AmazonS3BucketProvider.getS3Bucket();
//                            }catch(Exception ex) {
//                                ex.printStackTrace();
//                            }                
//                Job job = clientService.getJobById(o.getJobId());
//                System.out.println(o.getJobId());
//                try {
//                        tmpJobStatus = amazonTranscodingDAO.updateJob(job);                        
//                        System.out.println("--------------Job--------------------------------");
//                        System.out.println("JobID - "+job.getId());
//                        System.out.println("PipelineId - "+job.getPipelineId());
//                        System.out.println("JobStatus - "+job.getStatus());            
//                        System.out.println("Status - "+job.getOutput().getStatus());            
//                        System.out.println("JobStatusDetail - "+job.getOutput().getStatusDetail());
//                        try {
//                            if(job.getStatus().equals("Complete")) {
//                                System.out.println("Log ....1");
//                                awsS3BucketService.copyItem1(appConfig.getUploadBucketName(),
//                                        appConfig.getUploadBucketName(),
//                                        job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, processedRootLocationName));                            
//                                System.out.println("Log ....2");                            
//                                if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing/")) {
//                                    System.out.println("Log ....3");
//                                    awsS3BucketService.deleteObject1(job.getInput().getKey(),appConfig.getUploadBucketName());                                    
//                                    System.out.println("Log ....4");
//                                }
//                                System.out.println("Log ....4.1 .....");
//                            }else if(job.getStatus().equals("Errot")) {
//                                System.out.println("Error ....1");
//                                awsS3BucketService.copyItem1(appConfig.getUploadBucketName(),
//                                        appConfig.getUploadBucketName(),
//                                        job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, transcodingErrorLocationName));                            
//                                System.out.println("Error ....2");                            
//                                if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing/")) {
//                                    System.out.println("Error ....3");
//                                    awsS3BucketService.deleteObject1(job.getInput().getKey(),appConfig.getUploadBucketName());
//                                    System.out.println("Error ....4");
//                                }                                
//                                sendMail("JobID - "+job.getId());
//                                System.out.println("Error ....4.1 .....");
//                            }
//                        }catch(Exception ex) {
//                            ex.printStackTrace();
//                        } 
//                        System.out.println("Log ....4.2 .....");
//                }catch(Exception ex) {
//                    ex.printStackTrace();
//                    try {
//                            System.out.println("Error ....1");
//                            awsS3BucketService.copyItem1(appConfig.getUploadBucketName(),
//                                    appConfig.getUploadBucketName(),
//                                    job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, transcodingErrorLocationName));                            
//                            System.out.println("Error ....2");                            
//                            if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing/")) {
//                                System.out.println("Error ....3");
//                                awsS3BucketService.deleteObject1(job.getInput().getKey(),appConfig.getUploadBucketName());
//                                System.out.println("Error ....4");
//                            }
//                            System.out.println("Error ....4.1 .....");
//                            sendMail("JobID - "+job.getId());
//                    }catch(Exception e2) {
//                    }
////                    jobStatus = "closeTimer";
//                }
//            }   
//            
//            System.out.println("Log ....5 Timer cancel.....");
//            
//
//            timer.cancel();
////            new JobStatusUpdaterCron(30);
//            
//        }
    }
    
    public void sendMail(String msg) {

     try{   
      // Recipient's email ID needs to be mentioned.aman.kumar@intoday.com
      String to = "Santosh.jena@intoday.com";

      // Sender's email ID needs to be mentioned
      String from = "awstranscode@intoday.in";

      // Assuming you are sending email from localhost
      String host = "220.226.193.53";

      // Get system properties
      Properties properties = System.getProperties();

      // Setup mail server
      properties.setProperty("mail.smtp.host", host);
//      properties.setProperty("mail.smtp.port", "25");

      // Get the default Session object.
      Session session = Session.getDefaultInstance(properties);

      
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(from));

         // Set To: header field of the header.
         message.addRecipient(Message.RecipientType.TO,
                                  new InternetAddress(to));

         // Set Subject: header field
         message.setSubject("Transcoding Error");

         // Now set the actual message
         message.setText(msg);

         // Send message
         Transport.send(message);
         System.out.println("Sent message successfully....");
      }catch (MessagingException mex) {
         mex.printStackTrace();
      }catch(Exception es) {
          es.printStackTrace();
      }
           
    }
    
     public static void main(String...args){
        new JobStatusUpdaterCron().sendMail("testing");
         
         //new JobStatusUpdaterCron(1);
     }    
}

