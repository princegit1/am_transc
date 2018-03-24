package com.itgd.transcoder.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.CopyObjectRequest;
import com.amazonaws.services.s3.model.CopyObjectResult;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.itgd.transcoder.confg.AppConfig;
import com.itgd.transcoder.provider.AmazonS3BucketProvider;
import java.util.List;

public class AWSS3BucketService {
    
    static AmazonS3 S3 = AmazonS3BucketProvider.getS3Bucket();
    static final String bucketName = getBucketName();
    
    public List<Bucket> listS3Bucket() throws Exception {
        List<Bucket> bucketList;
        bucketList = S3.listBuckets();        
        return bucketList;
    }
    
    public List<S3ObjectSummary> listBucketContentBucketName(String bucketName) throws Exception {
        ObjectListing objectListring =S3.listObjects(bucketName);
        List<S3ObjectSummary> objectSummaryList = objectListring.getObjectSummaries();
        for(S3ObjectSummary o: objectSummaryList) {
            System.out.println(o.getKey());
        }        
        return objectSummaryList;
    }        
    
    public CopyObjectResult copyItem(String inpLoc, String outLoc) throws Exception {              
       CopyObjectRequest copyObjectRequest = new CopyObjectRequest(bucketName, inpLoc, bucketName, outLoc);
       CopyObjectResult copyObjectResult =  S3.copyObject(copyObjectRequest);
                System.out.println("----------------------------------------------------------------------");
                System.out.println("ETag ...."+copyObjectResult.getETag());        
                System.out.println("ExpirationTimeRuleId ...."+copyObjectResult.getExpirationTimeRuleId());        
                System.out.println("LastModifiedDate ...."+copyObjectResult.getLastModifiedDate());    
       return copyObjectResult;
    }    
    
    public CopyObjectResult copyItem1(String inB,String outB,String inpLoc, String outLoc) {
        CopyObjectResult copyObjectResult = null;
        
        try {
            CopyObjectRequest copyObjectRequest = new CopyObjectRequest(inB, inpLoc, outB, outLoc);
            copyObjectResult =  S3.copyObject(copyObjectRequest);
                     System.out.println("----------------------------------------------------------------------");
                     System.out.println("ETag ...."+copyObjectResult.getETag());        
                     System.out.println("ExpirationTimeRuleId ...."+copyObjectResult.getExpirationTimeRuleId());        
                     System.out.println("LastModifiedDate ...."+copyObjectResult.getLastModifiedDate());                
        }catch(Exception ex) {ex.printStackTrace();}
        return copyObjectResult;
    }    
    
    public void deleteObject(String key) throws Exception {              
        try {
            S3.deleteObject(bucketName, key);
            System.out.println("FileDeleted -> "+key);
        }catch(Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }
    }   
    public void deleteObject1(String key,String bucket) throws Exception {              
        try {
            S3.deleteObject(bucket, key);
            System.out.println("FileDeleted -> "+key);
        }catch(Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }
    }   
    
    
         
    
    private static String getBucketName() {
        try {    
            AppConfig ac = new AppConfig();
            String bucketName = ac.getUploadBucketName();
            return bucketName;
        }catch(Exception ex) {
            System.err.println("Initial AmazonS3 creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }   
    }    
}
