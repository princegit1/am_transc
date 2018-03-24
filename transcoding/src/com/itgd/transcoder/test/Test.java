/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.test;

/**
 *
 * @author Honey
 */
public class Test {
    public static void main(String...args) {
        String oldFileKeyName = "testing/processing/vjtest/1234/AAAAAAA/UNIT_05-SUB_2_P_0504.mp4";
        String newFileKeyName = "";        
        
        System.out.println(oldFileKeyName);
        
        String fileloc = oldFileKeyName.substring(0,oldFileKeyName.lastIndexOf("/"));
        System.out.println(fileloc);        
        String filename = oldFileKeyName.substring(oldFileKeyName.lastIndexOf("/")+1, oldFileKeyName.lastIndexOf("."));
        System.out.println(filename);
        String filetype = oldFileKeyName.substring(oldFileKeyName.lastIndexOf("."));
        System.out.println(filetype);
        
//        System.out.println(tmp);
    }
}
