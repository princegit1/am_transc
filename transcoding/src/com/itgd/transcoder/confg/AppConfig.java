/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.confg;

import com.itgd.transcoder.bean.AmazobAwsJobOutputDesc;
import com.itgd.transcoder.bean.AmazonAwsJobDesc;
import com.itgd.transcoder.dao.AmazonTranscodingDAO;
import java.util.List;

/**
 *
 * @author Honey
 */
public class AppConfig {

    private AmazonAwsJobDesc awsJobDesc;
    private List<AmazobAwsJobOutputDesc> listAWSJobOutputDescs;
    private String pipelindId;
    private String uploadBucketName;
    private String uploadedRootLocationName;
    private String processingRootLocationName;
    private String processedRootLocationName;
    private String transcodingOutputLocationName;
    private String transcodingErrorLocationName;
    private String watermark_1;
    private String watermark_place;
    public AppConfig() {
    }
    public AppConfig(String jobConfigID,String inputBitRate) throws Exception {
        AmazonTranscodingDAO atdao = new AmazonTranscodingDAO();
        this.awsJobDesc = atdao.getAmazonAwsJobDescById(jobConfigID);
        if(inputBitRate!=null && inputBitRate.length()>0)
        this.listAWSJobOutputDescs = atdao.listAmazobAwsJobBitrateDescByJobDescId(jobConfigID, inputBitRate);
        else
        this.listAWSJobOutputDescs = atdao.listAmazobAwsJobOutputDescByJobDescId(jobConfigID);	
        this.uploadBucketName = awsJobDesc.getBucketInput();
        this.uploadedRootLocationName = awsJobDesc.getInputBasePath();
        this.processingRootLocationName = awsJobDesc.getProcessBasePath();
        this.processedRootLocationName = awsJobDesc.getProcessedBasePath();
        this.transcodingOutputLocationName = awsJobDesc.getOutputBasePath();
        this.transcodingErrorLocationName=awsJobDesc.getErrorBasePath();
        this.pipelindId = awsJobDesc.getPipelineId();
        this.watermark_1=awsJobDesc.getWatermark();
        this.watermark_place=awsJobDesc.getWatermarkPlace();
     }
    
    public AmazonAwsJobDesc getAwsJobDesc() {
        return awsJobDesc;
    }

    public void setAwsJobDesc(AmazonAwsJobDesc awsJobDesc) {
        this.awsJobDesc = awsJobDesc;
    }

    public List<AmazobAwsJobOutputDesc> getListAWSJobOutputDescs() {
        return listAWSJobOutputDescs;
    }

    public void setListAWSJobOutputDescs(List<AmazobAwsJobOutputDesc> listAWSJobOutputDescs) {
        this.listAWSJobOutputDescs = listAWSJobOutputDescs;
    }

    public String getUploadBucketName() {
        return uploadBucketName;
    }

    public void setUploadBucketName(String uploadBucketName) {
        this.uploadBucketName = uploadBucketName;
    }

    public String getUploadedRootLocationName() {
        return uploadedRootLocationName;
    }

    public void setUploadedRootLocationName(String uploadedRootLocationName) {
        this.uploadedRootLocationName = uploadedRootLocationName;
    }

    public String getProcessingRootLocationName() {
        return processingRootLocationName;
    }

    public void setProcessingRootLocationName(String processingRootLocationName) {
        this.processingRootLocationName = processingRootLocationName;
    }

    public String getProcessedRootLocationName() {
        return processedRootLocationName;
    }

    public void setProcessedRootLocationName(String processedRootLocationName) {
        this.processedRootLocationName = processedRootLocationName;
    }

    public String getTranscodingOutputLocationName() {
        return transcodingOutputLocationName;
    }

    public void setTranscodingOutputLocationName(String transcodingOutputLocationName) {
        this.transcodingOutputLocationName = transcodingOutputLocationName;
    }

    public String getTranscodingErrorLocationName() {
        return transcodingErrorLocationName;
    }

    public void setTranscodingErrorLocationName(String transcodingErrorLocationName) {
        this.transcodingErrorLocationName = transcodingErrorLocationName;
    }    

    public String getPipelindId() {
        return pipelindId;
    }

    public void setPipelindId(String pipelindId) {
        this.pipelindId = pipelindId;
    }
	public String getWatermark() {
		return watermark_1;
	}
	public void setWatermark(String watermark_1) {
		this.watermark_1 = watermark_1;
	}
	public String getWatermark_place() {
		return watermark_place;
	}
	public void setWatermark_place(String watermark_place) {
		this.watermark_place = watermark_place;
	}
}
