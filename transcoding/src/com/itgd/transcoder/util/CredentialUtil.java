/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.util;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.ClasspathPropertiesFileCredentialsProvider;

/**
 *
 * @author Honey
 */
public class CredentialUtil {
    
    private static AWSCredentials credentials;
    
    public static AWSCredentials getITGDS3Credential() throws Exception {
        if(credentials!=null) {
            return credentials;
        } else {
            credentials = new ClasspathPropertiesFileCredentialsProvider().getCredentials();
            return credentials;
        }
    }
}
