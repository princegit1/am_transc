/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.util;


import com.amazonaws.services.elastictranscoder.model.Job;
import com.amazonaws.services.s3.AmazonS3;
import com.itgd.transcoder.confg.AppConfig;
import com.itgd.transcoder.dao.AmazonTranscodingDAO;
import com.itgd.transcoder.provider.AmazonS3BucketProvider;
import com.itgd.transcoder.service.AWSS3BucketService;
import com.itgd.transcoder.service.AmazonClientService;
import java.util.ArrayList;
import java.util.List;
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
public class JobStatusUpdateUtil {
     Timer timer;
     String jobDescId;
     List<String> outputjobIdList;
     AmazonTranscodingDAO amazonTranscodingDAO = new AmazonTranscodingDAO();
     AWSS3BucketService awsS3BucketService = new AWSS3BucketService();
     AmazonClientService clientService = new AmazonClientService();

    public JobStatusUpdateUtil(int seconds,String jobDescIdTmp, List<String> outputjobIdListTmp) {
        jobDescId = jobDescIdTmp;
        outputjobIdList=outputjobIdListTmp;
        timer = new Timer();  //At this line a new Thread will be created
        timer.schedule(new JobStatusUpdateUtil.UpdateJobStatus(), seconds*1000); //delay in milliseconds
    }

    class UpdateJobStatus extends TimerTask {

        @Override
        public void run() {
            List<String> remJobIdList = new ArrayList<String>();
            String jobStatus = "closeTimer";            
            String tmpJobStatus = "";
            AppConfig appConfig = null;
            String processingRootLocationName = null;
            String processedRootLocationName = null;
            String transcodingErrorLocationName = null;
            AmazonS3 S3=null;
            try {
                    appConfig = new AppConfig(jobDescId,"");
                    processingRootLocationName = appConfig.getProcessingRootLocationName();
                    processedRootLocationName = appConfig.getProcessedRootLocationName();
                    transcodingErrorLocationName = appConfig.getTranscodingErrorLocationName();
                    S3 = AmazonS3BucketProvider.getS3Bucket();
            }catch(Exception ex) {
                ex.printStackTrace();
            }
            
            //clientService
            
            for(String jobId: outputjobIdList) {
                Job job = clientService.getJobById(jobId);
                System.out.println(jobId);
                try {
                	
                	System.out.println("jobDescId--->>>"+jobDescId);
                        tmpJobStatus = amazonTranscodingDAO.updateJob(job,jobDescId);
                        if(!(tmpJobStatus.equals("Error") || tmpJobStatus.equals("Complete")))                                
                        {
                            jobStatus="timerNotClosed";
                        }
                        System.out.println("--------------Job--------------------------------");
                        System.out.println("JobID - "+job.getId());
                        System.out.println("PipelineId - "+job.getPipelineId());
                        System.out.println("JobStatus - "+job.getStatus());            
                        System.out.println("Status - "+job.getOutput().getStatus());            
                        System.out.println("JobStatusDetail - "+job.getOutput().getStatusDetail());
                        try {
                            if(job.getStatus().equals("Complete")) {
                                System.out.println("Log ....1");
                                awsS3BucketService.copyItem1(appConfig.getUploadBucketName(),
                                        appConfig.getUploadBucketName(),
                                        job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, processedRootLocationName));                            
                                System.out.println("Log ....2");                            
                                if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing/")) {
                                    System.out.println("Log ....3");
                                    awsS3BucketService.deleteObject1(job.getInput().getKey(),appConfig.getUploadBucketName());
                                    remJobIdList.add(jobId);
                                    System.out.println("Log ....4");
                                }
                                System.out.println("Log ....4.1 .....");
                            }else if(job.getStatus().equals("Errot")) {
                                System.out.println("Error ....1");
                                awsS3BucketService.copyItem1(appConfig.getUploadBucketName(),
                                        appConfig.getUploadBucketName(),
                                        job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, transcodingErrorLocationName));                            
                                System.out.println("Error ....2");                            
                                if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing/")) {
                                    System.out.println("Error ....3");
                                    awsS3BucketService.deleteObject1(job.getInput().getKey(),appConfig.getUploadBucketName());
                                    remJobIdList.add(jobId);
                                    System.out.println("Error ....4");
                                }                                
                                sendMail("JobID - "+job.getId());
                                System.out.println("Error ....4.1 .....");
                            }
                        }catch(Exception ex) {
                            ex.printStackTrace();
                        } 
                        System.out.println("Log ....4.2 .....");
                }catch(Exception ex) {
                    ex.printStackTrace();
                    try {
                            System.out.println("Error ....1");
                            awsS3BucketService.copyItem1(appConfig.getUploadBucketName(),
                                    appConfig.getUploadBucketName(),
                                    job.getInput().getKey(), job.getInput().getKey().replace(processingRootLocationName, transcodingErrorLocationName));                            
                            System.out.println("Error ....2");                            
                            if(job.getInput().getKey().contains(".") && job.getInput().getKey().contains("/processing/")) {
                                System.out.println("Error ....3");
                                awsS3BucketService.deleteObject1(job.getInput().getKey(),appConfig.getUploadBucketName());
                                remJobIdList.add(jobId);
                                System.out.println("Error ....4");
                            }
                            System.out.println("Error ....4.1 .....");
                            sendMail("JobID - "+job.getId());
                    }catch(Exception e2) {
                    }
//                    jobStatus = "closeTimer";
                }
            }   
            
            System.out.println("Log ....5 Timer cancel.....");
            
            if(remJobIdList.size()>0) {
                for(String tmpjId: remJobIdList) {
                    outputjobIdList.remove(tmpjId);
                }
            }
            timer.cancel();
            if(!jobStatus.equals("closeTimer")) {
                System.out.println("Log ....6 Timer cancel.....");
                 //Not necessary because we call System.exit
                new JobStatusUpdateUtil(15, jobDescId, outputjobIdList);
//                System.exit(0); //Stops the AWT thread (and everything else)
            }
            System.out.println("Log ....7 Timer cancel.....");
            
        }
    }
    
    public void sendMail(String msg) {

     try{   
      // Recipient's email ID needs to be mentioned.
      String to = "aman.kumar@intoday.com";

      // Sender's email ID needs to be mentioned
      String from = "awstranscode@intoday.in";

      // Assuming you are sending email from localhost
      String host = "220.226.193.41";

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
}
