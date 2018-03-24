/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.service;

import com.amazonaws.services.elastictranscoder.AmazonElasticTranscoderClient;
import com.amazonaws.services.elastictranscoder.model.ListPresetsResult;
import com.amazonaws.services.elastictranscoder.model.Preset;
import com.amazonaws.services.elastictranscoder.model.ReadPresetRequest;
import com.amazonaws.services.elastictranscoder.model.ReadPresetResult;
import com.itgd.transcoder.provider.AmazonClientProvider;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Honey
 */
public class PresetService {
    
    private static final AmazonElasticTranscoderClient client = AmazonClientProvider.getClient();
    
    public List<Preset> getPresetList() throws Exception {       
        ListPresetsResult listPresetsResult = client.listPresets();
        List<Preset> presetList = listPresetsResult.getPresets();
        return presetList;
    }
    
    public Map<String,Preset> getPresetMap() throws Exception {
        AmazonClientProvider.getClient();        
        ListPresetsResult listPresetsResult = client.listPresets();
        Map<String,Preset> presetMap = new HashMap<String,Preset>();
        
        for(Preset preset: listPresetsResult.getPresets()) {
            presetMap.put(preset.getId(), preset);
            System.out.println(preset.getId());
        }        
        return presetMap;
    }
    
    public Preset getPresetById(String presetId) throws Exception {
        ReadPresetRequest presetRequest = new ReadPresetRequest();
        presetRequest.setId(presetId);
        ReadPresetResult presetResult = client.readPreset(presetRequest);
        Preset preset = presetResult.getPreset();
        return preset;
    }
}
