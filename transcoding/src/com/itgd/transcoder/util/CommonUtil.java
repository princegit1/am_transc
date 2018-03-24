package com.itgd.transcoder.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ListObjectsRequest;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.S3ObjectSummary;

public class CommonUtil {
	
	 public static boolean isInteger(String bitRate) {
	        try { 
	             Integer.parseInt(bitRate); 
	           } catch(NumberFormatException e) { 
	            return false; 
	        }
	        // only got here if we didn't return false
	        return true;
	    }
	    public static String getProfileIdFromConfiguration(String key) {
	        Properties configProp = new Properties();
	       
	        
	        String region="";
	       
	        InputStream in=CommonUtil.class.getClassLoader().getResourceAsStream("appConfig.properties");
	        try {
	            configProp.load(in);
	            if(key!=null && key.length()>0)
	            region = configProp.getProperty(key);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        return region;
	    }

	    public static void main(String[] args) {
	    	
	    	try
	    	{
	    	System.out.println(getProfileIdFromConfiguration("profileId"));
	    	}
	    	catch (Exception exception) {
	    		
				// TODO: handle exception
			}
			
		}
	    
	    public static List<S3ObjectSummary> getItemListFromProcessingFolder(AmazonS3 S3,String UploadedRootLocationName,String inputBucket) throws Exception{
	    	List<S3ObjectSummary> objectSummaryListTemp=null;
	    	List<S3ObjectSummary> objectSummaryList=new ArrayList<S3ObjectSummary>();
	    	 ListObjectsRequest listObjectsRequest = new ListObjectsRequest();
	    	 System.out.println("----Getting Video from Upload folder is Called........"); 
			Calendar calendar=Calendar.getInstance();
	    	int year=calendar.get(Calendar.YEAR);
	    	int month=calendar.get(Calendar.MONTH);
	    	String currentFolder=null;
	    	int count=1;
	    	try
	    	{
	    		String maxKeys=getProfileIdFromConfiguration("videoLoad");
	    	while(count<=2)
	    	{
	    	  	if(month <10 && count==1)
	           	{
	           		currentFolder=year+"_"+"0"+month;	
	           	}
	    	  	else if(month<10 && count==2)
	           	{
	           	  currentFolder=year+"_"+"0"+(month+1);	
	           	}
	           	else if(month==12 && count==1)
	           	{
	           		currentFolder=(year)+"_"+month;
	           	}
	        	else if(month==12 && count==2)
	           	{
	           		currentFolder=year+1+"_"+("01");
	           	}
	        	else if(month>9 &&  month<12 && count==1)
	        	{
	        		currentFolder=year+"_"+month;	
	        	}
	        	else if(month>9 &&  month<12 && count==2)
	        	{
	        		currentFolder=year+"_"+(month+1);	
	        	}
	        		listObjectsRequest.setBucketName(inputBucket);
	    	        listObjectsRequest.setPrefix(UploadedRootLocationName+currentFolder+"/"); 
	    	        if(isInteger(maxKeys.trim()))
	    	        listObjectsRequest.setMaxKeys(Integer.parseInt(maxKeys.trim()));
	    	        ObjectListing objectListring =S3.listObjects(listObjectsRequest);         
	    	        objectSummaryListTemp = objectListring.getObjectSummaries();
	    	        count++;
	    	        for(S3ObjectSummary s3ObjectSummary: objectSummaryListTemp)
	    	        {
	    	        	objectSummaryList.add(s3ObjectSummary);
	    	        }
	    	        objectSummaryListTemp=null;
	    	}
	    	}
	    	catch (Exception e) {
	    		e.printStackTrace();
				// TODO: handle exception
			}
	        System.out.println("loaded video Size......."+objectSummaryList.size());
	        return objectSummaryList;
	    } 
	    
	    
	    public static List<S3ObjectSummary> getItemListFromProcessingFolder1(AmazonS3 S3,String UploadedRootLocationName,String inputBucket) throws Exception{
	    	
	    	List<S3ObjectSummary> objectSummaryList=new ArrayList<S3ObjectSummary>();
	    	 ListObjectsRequest listObjectsRequest = new ListObjectsRequest();
	    	 try
	    	 {
	    	        System.out.println("getItemListFromProcessingFolder Called........"); 
	        		listObjectsRequest.setBucketName(inputBucket);
	    	        listObjectsRequest.setPrefix(UploadedRootLocationName); 
	    	       
	    	      //  listObjectsRequest.setMaxKeys(5);
	    	        ObjectListing objectListring =S3.listObjects(listObjectsRequest);       
	    	        objectSummaryList = objectListring.getObjectSummaries();
	    	        
	    	}
	    	
	    	catch (Exception e) {
	    		e.printStackTrace();
				// TODO: handle exception
			}
	        System.out.println("getItemListFromProcessingFolder1 root locate name........"+objectSummaryList.size());
	        return objectSummaryList;
	    } 
	    
	    
	    public void sendMail(String msg) {

	     try{   
	      // Recipient's email ID needs to be mentioned.aman.kumar@intoday.com
	      String to = getProfileIdFromConfiguration("emailTo");
	      // Sender's email ID needs to be mentioned
	      String from = getProfileIdFromConfiguration("emailFrom");
	      // Assuming you are sending email from localhost
	      String host = getProfileIdFromConfiguration("host");
	      // Get system properties
	      Properties properties = System.getProperties();
	      // Setup mail server
	      properties.setProperty("mail.smtp.host", host);
//	      properties.setProperty("mail.smtp.port", "25");
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
	         message.setSubject("AWS Transcoding");
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
