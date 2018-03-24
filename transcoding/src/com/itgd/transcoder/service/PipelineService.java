/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.service;

import com.amazonaws.services.elastictranscoder.AmazonElasticTranscoderClient;
import com.amazonaws.services.elastictranscoder.model.ListPipelinesResult;
import com.amazonaws.services.elastictranscoder.model.Pipeline;
import com.amazonaws.services.elastictranscoder.model.ReadPipelineRequest;
import com.amazonaws.services.elastictranscoder.model.ReadPipelineResult;
import com.itgd.transcoder.provider.AmazonClientProvider;
import java.util.List;

/**
 *
 * @author Honey
 */
public class PipelineService {
    
    private static final AmazonElasticTranscoderClient client = AmazonClientProvider.getClient();    
        
    public List<Pipeline> listPipeline() {
        ListPipelinesResult listPipelinesResult = client.listPipelines();
        List<Pipeline> list = listPipelinesResult.getPipelines();
        return list;
    }

    public Pipeline getPipelineById(String pipelineID) {
    	
        ReadPipelineRequest pipelineRequest = new ReadPipelineRequest();
        pipelineRequest.setId(pipelineID);
        ReadPipelineResult pipelineResult = client.readPipeline(pipelineRequest);
        System.out.println("rs.getString(4)"+pipelineResult);
        Pipeline pipeline = pipelineResult.getPipeline();
        System.out.println("rs.getString(4)"+pipeline);
        return pipeline;
    }    
}
