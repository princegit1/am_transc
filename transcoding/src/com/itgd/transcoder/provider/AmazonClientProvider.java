
package com.itgd.transcoder.provider;

import com.itgd.transcoder.util.CredentialUtil;
import com.amazonaws.services.elastictranscoder.AmazonElasticTranscoderClient;


public class AmazonClientProvider {
    
    private static final AmazonElasticTranscoderClient client = createClient();
       
    private static AmazonElasticTranscoderClient createClient() {
        try {            
                AmazonElasticTranscoderClient client = new AmazonElasticTranscoderClient(CredentialUtil.getITGDS3Credential());
                client.setRegion(RegionServiceProvider.getRegion());
                return client;
        } catch (Throwable ex) {
            // Make sure you log the exception, as it might be swallowed
            System.err.println("Initial AmazonElasticTranscoderClient creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }          
    }
    
    public static AmazonElasticTranscoderClient getClient() {
        return client;
    }    
}
