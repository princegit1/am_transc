/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.provider;

import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 *
 * @author Honey
 */
public class RegionServiceProvider {
    
    public static Region getRegion() throws Exception {
        Region usWest2;
        RegionServiceProvider regionUtil = new RegionServiceProvider();
        if(regionUtil.getRegionConfiguration().equals("Asia-Pacific-Singapore-Region")) {
            usWest2 = Region.getRegion(Regions.AP_SOUTHEAST_1);
            return usWest2;
        }else {
            usWest2 = Region.getRegion(Regions.DEFAULT_REGION);
            return usWest2;            
        }
    }
    
    public String getRegionConfiguration() throws Exception {
        Properties configProp = new Properties();
        InputStream in;
        String region="";
        in = this.getClass().getClassLoader().getResourceAsStream("appConfig.properties");
        try {
            configProp.load(in);
            region = configProp.getProperty("regionsConfig");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return region;
    }
}
