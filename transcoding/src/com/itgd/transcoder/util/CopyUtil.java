package com.itgd.transcoder.util;

import java.util.List;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CopyObjectResult;
import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.itgd.transcoder.bean.AmazonAwsJobDesc;
import com.itgd.transcoder.bean.TranscodingProcessLog;
import com.itgd.transcoder.dao.AmazonTranscodingDAO;
import com.itgd.transcoder.provider.AmazonS3BucketProvider;
import com.itgd.transcoder.service.AWSS3BucketService;
/**
 * A Zones exception class generalizing exceptions that typically occur as a
 * result of some system failure.  For example, unavailable servers, bad
 * configurations, or program assertion errors would all classify as a system
 * exception.  Such exceptions are not generally recoverable and so are
 * unchecked exceptions.
 * 
 * <p> This class supports JDK7-style suppressed exception chaining.  It is
 * implemented according to the pre-release Javadocs as they appeared on
 * 2011-05-09.  Unfortunately, without the ability to modify the source code
 * of the {@code Throwable} class, the implementation of the
 * {@code printStackTrace(...)} family of methods cannot be per the JDK7 spec.
 * The nearest possible implementation would only work if executed directly on
 * this exception.  If an exception of this type were wrapped inside another
 * exception of a different type, calling {@code printStackTrace(...)} on the
 * enclosing exception would not produce the stack traces of the suppressed
 * exceptions because the default implementation is not called recursively. The
 * next-best implementation, and the one implemented by this class, overrides
 * the {@link #toString()} method to reproduce the stack trace of suppressed
 * exceptions.  The result is sufficiently readable (though somewhat less
 * readable when suppressed exceptions have suppressed exceptions) although
 * nonstandard, and potentially unexpectedly verbose if exception messages are
 * ever displayed to end-users.
 *
 * @author lahmu
 * @version $Id: ZonesSystemException.java 10986 2012-03-01 00:33:01Z VGarner $
 * @since Nov 24, 2008
 */
public class CopyUtil {

	/**
	 * @param args
	 */
	
	public static boolean copyProcessingToUpload()
	{ 
		 boolean result=true;
		 AmazonAwsJobDesc amazonAwsJobDesc= null;
		 AmazonTranscodingDAO atdao  = null;
		 AWSS3BucketService awsS3BucketService =null;
		 CopyObjectResult copyObjectResult=null;
		 TranscodingProcessLog transcodingProcessLog=null;
		try
		{  	AmazonS3 S3 = AmazonS3BucketProvider.getS3Bucket();
			 String ProfileId=CommonUtil.getProfileIdFromConfiguration("profileId");
			 String uploadPath=CommonUtil.getProfileIdFromConfiguration("uploadPath");
			 String processingPath=CommonUtil.getProfileIdFromConfiguration("processingPath");
			 String status=CommonUtil.getProfileIdFromConfiguration("status");
			 atdao  = new AmazonTranscodingDAO();
			 if(ProfileId!=null && ProfileId.length()>0 && uploadPath!=null & uploadPath.length()>0 && processingPath!=null && processingPath.length()>0)
			 amazonAwsJobDesc= atdao.getAmazonAwsJobDescByid(Integer.parseInt(ProfileId));
			 if(amazonAwsJobDesc!=null)
			 {
				
		      List<S3ObjectSummary> objectSummaryList=CommonUtil.getItemListFromProcessingFolder(S3, amazonAwsJobDesc.getProcessBasePath(), amazonAwsJobDesc.getBucketInput());
		      awsS3BucketService = new AWSS3BucketService(); 
		      if(objectSummaryList!=null && objectSummaryList.size()>0) {
              for(S3ObjectSummary o: objectSummaryList) {
              if(o.getKey().contains(".")){
             
            	  
			  copyObjectResult = awsS3BucketService.copyItem1(amazonAwsJobDesc.getBucketInput(),amazonAwsJobDesc.getBucketInput(),o.getKey(), o.getKey().replace(processingPath, uploadPath));
		      awsS3BucketService.deleteObject1(o.getKey(),amazonAwsJobDesc.getBucketInput()); 
		      transcodingProcessLog=new TranscodingProcessLog();
		      transcodingProcessLog.setSourcePath(o.getKey());
		      transcodingProcessLog.setDestinationPath(o.getKey().replace(processingPath, uploadPath));
		      transcodingProcessLog.setProfileId(Integer.parseInt(ProfileId));
		      transcodingProcessLog.setOutputStatus(status);
		     // atdao.saveTranscodingProcessLog(transcodingProcessLog);
			}}
		   }}
		   }
		catch (Exception e) {
			// TODO: handle exception
			result=false;
			
			e.printStackTrace();
			
		}
		finally
		{
			
		}
		
		return result;
	}
	
	
	public static boolean copyErrorToUpload()
	{ 
		 boolean result=true;
		 AmazonAwsJobDesc amazonAwsJobDesc= null;
		 AmazonTranscodingDAO atdao  = null;
		 AWSS3BucketService awsS3BucketService =null;
		 CopyObjectResult copyObjectResult=null;
		 TranscodingProcessLog transcodingProcessLog=null;
		try
		{    AmazonS3 S3 = AmazonS3BucketProvider.getS3Bucket();
			 String ProfileId=CommonUtil.getProfileIdFromConfiguration("profileId");
			 String uploadPath=CommonUtil.getProfileIdFromConfiguration("uploadPath");
			 String errorPath=CommonUtil.getProfileIdFromConfiguration("errorPath");
			 String status=CommonUtil.getProfileIdFromConfiguration("status");
			 
			 atdao  = new AmazonTranscodingDAO();
			 if(ProfileId!=null && ProfileId.length()>0 && errorPath!=null & errorPath.length()>0 && uploadPath!=null && uploadPath.length()>0)
			 amazonAwsJobDesc= atdao.getAmazonAwsJobDescByid(Integer.parseInt(ProfileId));
			 if(amazonAwsJobDesc!=null)
			 {
		      List<S3ObjectSummary> objectSummaryList=CommonUtil.getItemListFromProcessingFolder(S3, amazonAwsJobDesc.getErrorBasePath(), amazonAwsJobDesc.getBucketInput());
		      awsS3BucketService = new AWSS3BucketService(); 
		      if(objectSummaryList!=null && objectSummaryList.size()>0) {
              for(S3ObjectSummary o: objectSummaryList) {
              if(o.getKey().contains(".")){
			  copyObjectResult = awsS3BucketService.copyItem1(amazonAwsJobDesc.getBucketInput(),amazonAwsJobDesc.getBucketInput(),o.getKey(), o.getKey().replace(errorPath.trim(), uploadPath.trim()));
		      awsS3BucketService.deleteObject1(o.getKey(),amazonAwsJobDesc.getBucketInput()); 
		      transcodingProcessLog=new TranscodingProcessLog();
		      transcodingProcessLog.setSourcePath(o.getKey());
		      transcodingProcessLog.setDestinationPath(o.getKey().replace(errorPath, uploadPath));
		      transcodingProcessLog.setProfileId(Integer.parseInt(ProfileId));
		      transcodingProcessLog.setOutputStatus(status);
		     // atdao.saveTranscodingProcessLog(transcodingProcessLog);
			}}
		   }}
		   }
		catch (Exception e) {
			// TODO: handle exception
			result=false;
			
			e.printStackTrace();
			
		}
		finally
		{
			
		}
		
		return result;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try
		{
			  AmazonS3 S3 = AmazonS3BucketProvider.getS3Bucket();
			  //amazonAwsJobDesc= atdao.getAmazonAwsJobDescByid(Integer.parseInt(ProfileId));
			 List<S3ObjectSummary> objectSummaryList=CommonUtil.getItemListFromProcessingFolder1(S3, "videos/streamz/2015_03/320/", "media.streamz.in");
			 AWSS3BucketService awsS3BucketService  = new AWSS3BucketService(); 
		      if(objectSummaryList!=null && objectSummaryList.size()>0) {
            for(S3ObjectSummary o: objectSummaryList) {
            if(o.getKey().contains(".")){
            //CopyObjectResult copyObjectResul = awsS3BucketService.copyItem1(amazonAwsJobDesc.getBucketInput(),amazonAwsJobDesc.getBucketInput(),o.getKey(), o.getKey().replace(errorPath.trim(), uploadPath.trim()));
		      //awsS3BucketService.deleteObject1("transcoding/uploadtest/2015_03","media.streamz.in"); 
            }
            }
		      }
		}
			
			//media.streamz.in/transcoding/error/2015_03
			  //copyProcessingToUpload();
				//copyErrorToUpload();
        
		catch (Exception e) {
			// TODO: handle exception
			
			e.printStackTrace();
		}
	

}
}
