/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.service;

import com.itgd.transcoder.confg.AppConfig;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CopyObjectResult;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.itgd.transcoder.provider.AmazonS3BucketProvider;
import java.util.List;

/**
 *
 * @author Honey
 */
public class AWSCopyService {
    
    private AppConfig appConfig;
    private AWSS3BucketService awsS3BucketService = new AWSS3BucketService();
    
    public static void main(String...args) throws Exception {
        new AWSCopyService().copyFromUploadToProcessing();
    }
    
    public void copyFromUploadToProcessing() throws Exception  {        
        System.out.println("####################################################################");        
        System.out.println("copyFromUploadToProcessing Called........ Start"); 

        appConfig = new AppConfig();
        String uploadedRootLocationName = appConfig.getUploadedRootLocationName();
        String processingRootLocationName = appConfig.getProcessingRootLocationName();
        String uploadBucketName = appConfig.getUploadBucketName();
        java.util.Date curDate = new java.util.Date();
        
       //Getting Amazon S3 client 
        AmazonS3 S3 = new AmazonS3BucketProvider().getS3Bucket(); 
       
        ObjectListing objectListring =S3.listObjects(uploadBucketName);
        List<S3ObjectSummary> objectSummaryList = objectListring.getObjectSummaries();                        
        for(S3ObjectSummary objectSummary: objectSummaryList) {
            if(objectSummary.getKey().startsWith(uploadedRootLocationName) 
                    && objectSummary.getKey().length()>uploadedRootLocationName.trim().length()) 
            {      
                
                String mediaFileName = objectSummary.getKey().replace(uploadedRootLocationName, "");                                
                CopyObjectResult copyObjectResult = awsS3BucketService.copyItem(
                        objectSummary.getKey(), 
                        processingRootLocationName+mediaFileName);
                
                //On successfull copy, deleting object form upload folder.
                if(curDate.before(copyObjectResult.getLastModifiedDate())) {
                    S3.deleteObject(objectSummary.getBucketName(), objectSummary.getKey());
                }                
            }
        }
        System.out.println("copyFromUploadToProcessing Called........ ENDs"); 
        System.out.println("####################################################################");
    }
    

}
