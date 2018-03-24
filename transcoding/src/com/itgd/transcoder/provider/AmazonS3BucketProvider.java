package com.itgd.transcoder.provider;

import com.itgd.transcoder.util.CredentialUtil;
import com.amazonaws.regions.Region;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;


public class AmazonS3BucketProvider {
    
    private static final AmazonS3 S3 = buildS3BucketClient();
    
    private static AmazonS3 buildS3BucketClient() {
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
    
    public static AmazonS3 getS3Bucket() {
        return S3;            
    }
    
}
