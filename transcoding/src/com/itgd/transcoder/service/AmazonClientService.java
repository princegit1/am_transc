/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.service;

import com.amazonaws.services.elastictranscoder.AmazonElasticTranscoderClient;
import com.amazonaws.services.elastictranscoder.model.Job;
import com.amazonaws.services.elastictranscoder.model.Pipeline;
import com.amazonaws.services.elastictranscoder.model.Preset;
import com.amazonaws.services.elastictranscoder.model.ReadJobRequest;
import com.amazonaws.services.elastictranscoder.model.ReadJobResult;
import com.amazonaws.services.elastictranscoder.model.ReadPipelineRequest;
import com.amazonaws.services.elastictranscoder.model.ReadPipelineResult;
import com.amazonaws.services.elastictranscoder.model.ReadPresetRequest;
import com.amazonaws.services.elastictranscoder.model.ReadPresetResult;
import com.itgd.transcoder.confg.AppConfig;
import com.itgd.transcoder.provider.AmazonClientProvider;

/**
 *
 * @author Honey
 */
public class AmazonClientService {
    AmazonElasticTranscoderClient client = AmazonClientProvider.getClient(); 
    static final String bucketName = getBucketName();
         
    
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
    
    public Job getJobById(String jobId) {
        ReadJobRequest jobRequest = new ReadJobRequest();
        jobRequest.setId(jobId);
        ReadJobResult jobResult = client.readJob(jobRequest);
        Job job = jobResult.getJob();
        return job;
    }
    public Preset getPresetById(String presetId) {
        ReadPresetRequest presetRequest = new ReadPresetRequest();
        presetRequest.setId(presetId);
        ReadPresetResult presetResult = client.readPreset(presetRequest);
        Preset preset = presetResult.getPreset();
        return preset;
    }
    public Pipeline getPipelineById(String pipelineID) {
        ReadPipelineRequest pipelineRequest = new ReadPipelineRequest();
        pipelineRequest.setId(pipelineID);
        ReadPipelineResult pipelineResult = client.readPipeline(pipelineRequest);
        Pipeline pipeline = pipelineResult.getPipeline();
        return pipeline;
    }
}
