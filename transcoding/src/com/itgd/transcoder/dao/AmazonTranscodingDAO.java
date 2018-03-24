/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.dao;

import java.util.*;
import com.amazonaws.services.elastictranscoder.model.Job;
import com.amazonaws.services.elastictranscoder.model.JobOutput;
import com.itgd.transcoder.bean.AmazobAwsJobOutputDesc;
import com.itgd.transcoder.bean.AmazonAwsJobDesc;
import com.itgd.transcoder.bean.AmazonWebsiteDetails;
import com.itgd.transcoder.bean.AmazonTranscoding;
import com.itgd.transcoder.bean.TranscodingProcessLog;
import com.itgd.transcoder.util.CommonUtil;
import com.itgd.transcoder.util.HibernateUtil;
import java.util.List;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author Honey
 */
public class AmazonTranscodingDAO {
    public void saveTranscoderJob(AmazonTranscoding amazonTranscoding) throws Exception {
        Session session=null;
      try {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();
            session.saveOrUpdate(amazonTranscoding);
            transaction.commit();
            session.flush();
            session.close();
        } 
       catch(Exception ex) {
    	   System.out.println("Exception at---->>>>> saveTranscoderJob--->>>");
           ex.printStackTrace();            
       }finally 
       { //session.close();
    	   }
       
    }
    public boolean saveTranscodingProcessLog(TranscodingProcessLog transcodingProcessLog) throws Exception {
        Session session=null;
        boolean result=true;
     try {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();
            session.save(transcodingProcessLog);
            transaction.commit();
            result=false;          
      } 
       catch(Exception ex) {
           ex.printStackTrace();            
       }finally {  session.flush();
       session.close();}
      return result;
    }
    public void saveOutPutJob(com.itgd.transcoder.bean.Joboutput outputjob) throws Exception {
        Session session=null;
//        try {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();
            session.saveOrUpdate(outputjob);
            transaction.commit();
            session.flush();
            session.close();
//        } 
//        catch(Exception ex) {
//            ex.printStackTrace();            
//        }finally { session.close();}
    }
    
    public void createAndPopulateJobDetail(Job job,String job_marker) throws Exception {
    	AmazonTranscodingDAO atdao  = new AmazonTranscodingDAO();
    	try
    	{
    	String profileId="";
    	if(job_marker!=null)
    	{
    		profileId=job_marker.split("_")[0];	
    	}
    	List<AmazonAwsJobDesc> amazonAwsJobDescsList =atdao.listAmazonAwsJobDesc(profileId);
        AmazonTranscoding transcodeDetail = new AmazonTranscoding();
        AmazonAwsJobDesc amazonJob= new AmazonAwsJobDesc();
        AmazobAwsJobOutputDesc amanjobOutput=new AmazobAwsJobOutputDesc();
        transcodeDetail.setSourceFileName(job.getInput().getKey().substring(job.getInput().getKey().lastIndexOf("/")));
        String duration="0";
        int profileIdLog=0;
        String uploadPath=CommonUtil.getProfileIdFromConfiguration("uploadPath");
   	   TranscodingProcessLog transcodingProcessLog=null;
        for(JobOutput output: job.getOutputs()) {
        	System.out.println("Transcoding Input and ouput detail inserstion in database start .... ");
            com.itgd.transcoder.bean.Joboutput joboutputbean = new com.itgd.transcoder.bean.Joboutput();
                joboutputbean.setFileDuration(""+output.getDuration());
                duration=""+output.getDuration();
                joboutputbean.setJobId(""+output.getId()+job.getId());
                System.out.println("Prefixed id--------------->"+job.getOutputKeyPrefix());
                System.out.println("Output File NAme---->"+""+job.getOutputKeyPrefix()+output.getKey());
                joboutputbean.setOutputPresetId(""+output.getPresetId());
                System.out.println("output.getSegmentDuration()------>"+output.getSegmentDuration());
                joboutputbean.setOutputStatus(output.getStatus());
                joboutputbean.setOutputStatusDetail(output.getStatusDetail());
               // joboutputbean.setBitrateId(bitrateId)
                if(output.getSegmentDuration()!=null)
                {
                	 joboutputbean.setVedioType("m3u8");
                	 joboutputbean.setOutputPath(""+job.getOutputKeyPrefix()+output.getKey()+".m3u8");
                }
                else
                {
                	 joboutputbean.setOutputPath(""+job.getOutputKeyPrefix()+output.getKey());
                	 joboutputbean.setVedioType("mp4");
                }
                 //joboutputbean.setOutputSegmentDuration(""+output.getSegmentDuration());
                System.out.println(job.getOutputKeyPrefix());
                joboutputbean.setBitrateId(amanjobOutput.getBitrateId()); 
                joboutputbean.setFileCreationTime(new java.util.Date());
                joboutputbean.setFileCompletionTime(new java.util.Date());
                saveOutPutJob(joboutputbean);
        }  
        for(AmazonAwsJobDesc amazonAwsJobDesc:amazonAwsJobDescsList) 
        {
		          if(job.getPipelineId().trim().equals("1376397006061-6eif0h".trim()))
		   		  {
		   		    	System.out.println("indiatoday"+amazonAwsJobDesc.getWebsiteId());
		   		    	System.out.println("indiatoday"+amazonAwsJobDesc.getProfileId());
	  		    	    transcodeDetail.setWebsiteId(1);
		   		    	transcodeDetail.setProfileId(1);
		   		    	break;
		   		  }else if(job.getPipelineId().trim().equals("1376397212432-d2x0lr".trim()))
		   		  {
		   			 System.out.println("indiatoday-breaking"+amazonAwsJobDesc.getWebsiteId());
		   	      	 System.out.println("indiatoday-breaking"+amazonAwsJobDesc.getProfileId());
		   	      	 transcodeDetail.setWebsiteId(1);
		   	      	 transcodeDetail.setProfileId(2);
		   	      	 break;
		   		  }else if(job.getPipelineId().trim().equals("1376396899269-p46od7".trim()))
		   		  {
		   			    	System.out.println("aajtak"+amazonAwsJobDesc.getWebsiteId());
		      	    		System.out.println("aajtak"+amazonAwsJobDesc.getProfileId());
		      	    		transcodeDetail.setWebsiteId(2);
		      	    		transcodeDetail.setProfileId(3);
		      	    		break;
		   		  }else if(job.getPipelineId().trim().equals("1376396957605-r65ya6".trim()))
		   		  {
		   			  System.out.println("aajtak-breaking"+amazonAwsJobDesc.getWebsiteId());
		      	    	  System.out.println("aajtak-breaking"+amazonAwsJobDesc.getProfileId());
		      	    	  transcodeDetail.setWebsiteId(2);
		      		 	  transcodeDetail.setProfileId(4);
		      		 	  break;
		   		  }
		   		  else if(job.getPipelineId().trim().equals("1370851816859-m5mnmi".trim()))
		   		  {
		   			  System.out.println("learntoday"+amazonAwsJobDesc.getWebsiteId());
		      	          System.out.println("learntoday"+amazonAwsJobDesc.getProfileId());
		      	          transcodeDetail.setWebsiteId(3);
		      		 	  transcodeDetail.setProfileId(5);
		      		 	  break;
		   		  }else
		   		  {
		   			      System.out.println("else"+amazonAwsJobDesc.getWebsiteId());
		      	    	  System.out.println("else"+amazonAwsJobDesc.getProfileId());
		      	    	  transcodeDetail.setWebsiteId(amazonAwsJobDesc.getWebsiteId());
		      		 	  transcodeDetail.setProfileId(amazonAwsJobDesc.getProfileId());
		      		 	  profileIdLog=amazonAwsJobDesc.getProfileId();
		      			  break; 
		   		  }
        }
        transcodeDetail.setPipelineId(job.getPipelineId());        
        transcodeDetail.setJobStatus(job.getStatus());
        transcodeDetail.setFileDuration(duration);
        transcodeDetail.setJobId(job.getId());
        transcodeDetail.setInputPath(job.getInput().getKey());
        transcodeDetail.setJobMarker(job_marker);
        transcodeDetail.setJobCompletionTime(new java.util.Date());
         saveTranscoderJob(transcodeDetail);
         transcodingProcessLog=new TranscodingProcessLog();
	     transcodingProcessLog.setSourcePath(job.getInput().getKey().replace("processing", uploadPath));
	     transcodingProcessLog.setDestinationPath(job.getInput().getKey());
	     transcodingProcessLog.setProfileId(profileIdLog);
	     transcodingProcessLog.setOutputStatus(job.getStatus());
         saveTranscodingProcessLog(transcodingProcessLog);
    }
    	catch (Exception e) {
    	System.out.println("exception at createAndPopulateJobDetail--->>>"+e);
		}
    }
    
    public void updateTranscoderJob(AmazonTranscoding amazonTranscoding) throws Exception {
        Session session=null;
//        try {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();            
            System.out.println(getUpdateTranscoderJob(amazonTranscoding));
            AmazonTranscoding tmpObj = getUpdateTranscoderJob(amazonTranscoding);
            System.out.println(tmpObj);
            System.out.println("updateTranscoderJob---->"+tmpObj.getTransInputId());
            System.out.println("updateTranscoderJob---->"+tmpObj.getJobCreationTime());
            System.out.println("updateTranscoderJob---->"+tmpObj.getJobMarker());
            
            amazonTranscoding.setTransInputId(tmpObj.getTransInputId());
            amazonTranscoding.setJobCreationTime(tmpObj.getJobCreationTime());
            amazonTranscoding.setJobMarker(tmpObj.getJobMarker());  
            
            session.update(amazonTranscoding);
            transaction.commit();
            session.flush();
            session.close();
//        } 
//        catch(Exception ex) {
//            ex.printStackTrace();            
//        }finally { session.close();}
    }    
    public AmazonTranscoding getUpdateTranscoderJob(AmazonTranscoding amazonTranscoding) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();       
            System.out.println("getUpdateTranscoderJob---------------->"+amazonTranscoding.getJobId());
            AmazonTranscoding tmpObj = (AmazonTranscoding)session.createSQLQuery("select * from transcoding_input where job_id = '"+amazonTranscoding.getJobId().trim()+"'").addEntity(AmazonTranscoding.class).uniqueResult();
            if(tmpObj.equals(null) || tmpObj==null)
            {
            	System.out.println("Inside IF getUpdateTranscoderJob---------------->"+amazonTranscoding.getJobId());	
            	getUpdateTranscoderJob(amazonTranscoding);
            }
            session.flush();
            session.close();
            return tmpObj;
    }    
    
    public void updateOutPutJob(com.itgd.transcoder.bean.Joboutput outputjob) throws Exception {
        Session session=null;
//        try {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();
//            com.itgd.transcoder.bean.Joboutput tmpOject = getUpdateOutPutJob(outputjob);
//            outputjob.setAutoId(tmpOject.getAutoId());            
            session.update(outputjob);
            transaction.commit();
            session.flush();
            session.close();
//        } 
//        catch(Exception ex) {
//            ex.printStackTrace();            
//        }finally { session.close();}
    }    
    
    public com.itgd.transcoder.bean.Joboutput getUpdateOutPutJob(com.itgd.transcoder.bean.Joboutput outputjob) {
    	System.out.println("Call Method getUpdateOutPutJob in DAO");
         Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            
            Transaction transaction = session.beginTransaction();
            transaction.begin();
            		
                    com.itgd.transcoder.bean.Joboutput tmpOject = (com.itgd.transcoder.bean.Joboutput)
                    session.createSQLQuery("select * from transcoding_output where job_id = '"+outputjob.getJobId()+"' limit 1").addEntity(com.itgd.transcoder.bean.Joboutput.class).uniqueResult();
                    System.out.println(tmpOject.getTransOutputid());
            transaction.commit();
            session.flush();
            session.close(); 
            return tmpOject;
    }
    
    public String updateJob(Job job,String profileId) throws Exception 
    {
    	
    	AmazonTranscodingDAO atdao  = new AmazonTranscodingDAO();
    	List<AmazonAwsJobDesc> amazonAwsJobDescsList =atdao.listAmazonAwsJobDesc(profileId);
    	AmazonTranscoding transcodeDetail = new AmazonTranscoding();
        transcodeDetail.setSourceFileName(job.getInput().getKey().substring(job.getInput().getKey().lastIndexOf("/")));
        
        for(JobOutput output: job.getOutputs()) {
        	//System.out.println("dssd"+job.getInput().getKey());
                com.itgd.transcoder.bean.Joboutput joboutputbean = new com.itgd.transcoder.bean.Joboutput();
            	joboutputbean.setFileDuration(""+output.getDuration());
                joboutputbean.setJobId(""+output.getId()+job.getId());
                System.out.println("Get Key ID---->"+output.getId());
                joboutputbean.setOutputPath(""+job.getOutputKeyPrefix()+output.getKey());
                joboutputbean.setOutputPresetId(""+output.getPresetId());
                joboutputbean.setOutputStatus(output.getStatus());
                System.out.println("dssd"+output.getStatusDetail());
                System.out.println("output.getSegmentDuration()---------->"+output.getSegmentDuration());
                joboutputbean.setOutputStatusDetail(output.getStatusDetail());
                System.out.println(joboutputbean.getJobId());
                if(output.getSegmentDuration()!=null)
                {
                	 joboutputbean.setVedioType("m3u8");
                	 joboutputbean.setOutputPath(""+job.getOutputKeyPrefix()+output.getKey()+".m3u8");
                }
                else
                {
                	 joboutputbean.setOutputPath(""+job.getOutputKeyPrefix()+output.getKey());
                	 joboutputbean.setVedioType("mp4");
                }
                com.itgd.transcoder.bean.Joboutput tmpOject = getUpdateOutPutJob(joboutputbean);
                System.out.println("Reading output Object log ********************************");
                System.out.println("output Object  ID -> "+tmpOject.getTransIntputId());
                System.out.println("Reading output Object log 2 ********************************");
                if(!(tmpOject!=null && tmpOject.getOutputStatus()!=null 
                        && (tmpOject.getOutputStatus().equals("Complete") || tmpOject.getOutputStatus().equals("Error")) ))
                {
                	List<AmazonTranscoding> amazonTranscodings=atdao.listAmazonTranscodingData(job.getId()); 
                	for(AmazonTranscoding o: amazonTranscodings) 
                	{
                		System.out.println("Here is trans ID"+o.getTransInputId());
                		joboutputbean.setTransIntputId(o.getTransInputId());
                		break;
                	}
                	List<AmazobAwsJobOutputDesc> amazonAwsJobOutputList =atdao.listAmazobAwsJobOutput(output.getKey(),profileId);
                	for(AmazobAwsJobOutputDesc amazonAwsJobOutput: amazonAwsJobOutputList) 
                	{
                		System.out.println("Here is BitrateID ID"+amazonAwsJobOutput.getBitrateId());
                		joboutputbean.setBitrateId(amazonAwsJobOutput.getBitrateId());
                		break;
                	}
                	
                	System.out.println("Hello");
                    joboutputbean.setFileCompletionTime(new java.util.Date());
                    joboutputbean.setFileCreationTime(tmpOject.getFileCreationTime());
                    System.out.println("Transaction Out ID--->"+tmpOject.getTransOutputid());
                    joboutputbean.setTransOutputid(tmpOject.getTransOutputid());
                    updateOutPutJob(joboutputbean);
                  
                }    
      } 
        
	  for(AmazonAwsJobDesc amazonAwsJobDesc:amazonAwsJobDescsList) 
	  {
		  if(job.getPipelineId().trim().equals("1376397006061-6eif0h".trim()))
		  {
		    	System.out.println("indiatoday"+amazonAwsJobDesc.getWebsiteId());
		    	System.out.println("indiatoday"+amazonAwsJobDesc.getProfileId());
		    	transcodeDetail.setWebsiteId(1);
		    	transcodeDetail.setProfileId(1);
		    	break;
      		
		  }else if(job.getPipelineId().trim().equals("1376397212432-d2x0lr".trim()))
		  {
			 System.out.println("indiatoday-breaking"+amazonAwsJobDesc.getWebsiteId());
	      	 System.out.println("indiatoday-breaking"+amazonAwsJobDesc.getProfileId());
	      	 transcodeDetail.setWebsiteId(1);
	      	 transcodeDetail.setProfileId(2);
	      	 break;
	        
		  }else if(job.getPipelineId().trim().equals("1376396899269-p46od7".trim()))
		  {
			  	System.out.println("aajtak"+amazonAwsJobDesc.getWebsiteId());
   	    		System.out.println("aajtak"+amazonAwsJobDesc.getProfileId());
   	    		transcodeDetail.setWebsiteId(2);
   	    		transcodeDetail.setProfileId(3);
   	    		break;
		  }else if(job.getPipelineId().trim().equals("1376396957605-r65ya6".trim()))
		  {
			  System.out.println("aajtak-breaking"+amazonAwsJobDesc.getWebsiteId());
   	    	  System.out.println("aajtak-breaking"+amazonAwsJobDesc.getProfileId());
   	    	  transcodeDetail.setWebsiteId(2);
   		 	  transcodeDetail.setProfileId(4);
   		 	  break;
		  }
		  else if(job.getPipelineId().trim().equals("1370851816859-m5mnmi".trim()))
		  {
			  System.out.println("learntoday"+amazonAwsJobDesc.getWebsiteId());
   	          System.out.println("learntoday"+amazonAwsJobDesc.getProfileId());
   	          transcodeDetail.setWebsiteId(3);
   		 	  transcodeDetail.setProfileId(5);
   		 	  break;
		  }else
		  {
			  System.out.println("else"+amazonAwsJobDesc.getWebsiteId());
   	    	  System.out.println("else"+amazonAwsJobDesc.getProfileId());
   	    	  transcodeDetail.setWebsiteId(amazonAwsJobDesc.getWebsiteId());
   		 	  transcodeDetail.setProfileId(amazonAwsJobDesc.getProfileId());
   			  break; 
		  }
	   }
	   transcodeDetail.setPipelineId(job.getPipelineId());        
       transcodeDetail.setJobStatus(job.getStatus());
       transcodeDetail.setJobId(job.getId());
       transcodeDetail.setFileDuration(""+job.getOutput().getDuration());
       transcodeDetail.setInputPath(job.getInput().getKey());
	   transcodeDetail.setJobCompletionTime(new java.util.Date());
	   updateTranscoderJob(transcodeDetail);
	   return job.getStatus();
    }    
   
    public List<com.itgd.transcoder.bean.Joboutput> listOutput(String query) {
         Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();
            List<com.itgd.transcoder.bean.Joboutput> listOject = (List<com.itgd.transcoder.bean.Joboutput>)
                    session.createSQLQuery(query).addEntity(com.itgd.transcoder.bean.Joboutput.class).list();
            transaction.commit();
            session.flush();
            session.close(); 
            return listOject;
    }   
    
    public void saveOrUpdateAmazobAwsJobOutputDesc(AmazobAwsJobOutputDesc aajod) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();
            session.saveOrUpdate(aajod);
            transaction.commit();
            session.flush();
            session.close();
    }   
    public void saveOrUpdateAmazobAwsJobWebsiteDesc(AmazonWebsiteDetails aajod) throws Exception {
        Session session=null;
        System.out.println(aajod.getWebsiteName());
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();
            session.save(aajod);
            transaction.commit();
            session.flush();
            session.close();
    } 
    
    public void saveOrUpdateAmazonAwsJobDesc(AmazonAwsJobDesc aajod) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            transaction.begin();
            session.saveOrUpdate(aajod);
            transaction.commit();
            session.flush();
            session.close();
    }    
    
    public List<AmazonAwsJobDesc> listAmazonAwsJobDesc(String profileId) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession(); 
           // session=sessionFactory.getCurrentSession();
             List<AmazonAwsJobDesc> amazonAwsJobDescsList = (List<AmazonAwsJobDesc>)session.createSQLQuery("SELECT * FROM profile_master WHERE profile_id = "+profileId+" limit 1").addEntity(AmazonAwsJobDesc.class).list();                         
            // List<AmazonAwsJobDesc> amazonAwsJobDescsList = (List<AmazonAwsJobDesc>)session.createSQLQuery("SELECT * FROM profile_master WHERE profile_id =6 limit 1").addEntity(AmazonAwsJobDesc.class).list();                         
            
            session.flush();
            session.close();
            return amazonAwsJobDescsList;
    }    
    
    public AmazonAwsJobDesc getAmazonAwsJobDescById(String id) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            //AmazonAwsJobDesc amazonAwsJobDescs = (AmazonAwsJobDesc)session.createSQLQuery("SELECT * FROM profile_master WHERE profile_id = "+id+" limit 1").addEntity(AmazonAwsJobDesc.class).uniqueResult();
            AmazonAwsJobDesc amazonAwsJobDescs = (AmazonAwsJobDesc)session.createSQLQuery("SELECT * FROM profile_master WHERE profile_id = "+id+" limit 1").addEntity(AmazonAwsJobDesc.class).uniqueResult();
            session.flush();
            session.close();
            return amazonAwsJobDescs;
    }  
        Session session=null;
        public AmazonAwsJobDesc getAmazonAwsJobDescByid(int id) throws Exception {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
           // AmazonAwsJobDesc amazonAwsJobDescs = (AmazonAwsJobDesc)session.createSQLQuery("SELECT * FROM profile_master WHERE profile_id = "+id+" limit 1").addEntity(AmazonAwsJobDesc.class).uniqueResult();
            AmazonAwsJobDesc amazonAwsJobDescs = (AmazonAwsJobDesc)session.createSQLQuery("SELECT * FROM profile_master WHERE profile_id = "+id+" limit 1").addEntity(AmazonAwsJobDesc.class).uniqueResult();
            session.flush();
            session.close();
            System.out.println("--profile information is retrived--");
            return amazonAwsJobDescs;
    } 
    
    public List<AmazobAwsJobOutputDesc> listAmazobAwsJobOutputDesc() throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            List<AmazobAwsJobOutputDesc> amazobAwsJobOutputDescList = (List<AmazobAwsJobOutputDesc>)session.createSQLQuery("SELECT * FROM bitrate_master").addEntity(AmazobAwsJobOutputDesc.class).list();                         
            session.flush();
            session.close();
            return amazobAwsJobOutputDescList;
    }
    public List<AmazobAwsJobOutputDesc> listAmazobAwsJobOutput(String filename,String profileId) throws Exception {
    	System.out.println("listAmazobAwsJobOutput-------------->"+filename);
    	String bitrate=null;
    	
if(filename!=null)
{
	bitrate=filename.substring(filename.lastIndexOf("_")+1,filename.lastIndexOf("."));
}
    	
    	System.out.println("Token Number and details-----> "+bitrate);
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            List<AmazobAwsJobOutputDesc> amazobAwsJobOutputDescList = (List<AmazobAwsJobOutputDesc>)session.createSQLQuery("SELECT * FROM bitrate_master where profile_id='"+profileId+"' and bitrate="+bitrate).addEntity(AmazobAwsJobOutputDesc.class).list();                         
            session.flush();
            session.close();
            return amazobAwsJobOutputDescList;
    }  
    
     public List<AmazobAwsJobOutputDesc> listAmazobAwsJobOutputDescByJobDescId(String jobDescId) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            List<AmazobAwsJobOutputDesc> amazobAwsJobOutputDescList = (List<AmazobAwsJobOutputDesc>)session.createSQLQuery("SELECT * FROM bitrate_master where profile_id = "+jobDescId).addEntity(AmazobAwsJobOutputDesc.class).list();                         
            session.flush();
            session.close();
            return amazobAwsJobOutputDescList;
    }    
     
     
     public List<AmazobAwsJobOutputDesc> listAmazobAwsJobBitrateDescByJobDescId(String jobDescId,String inputBitrate) throws Exception {
         Session session=null;
             SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
             session = sessionFactory.openSession(); 
             int bitrate=0;
             if(CommonUtil.isInteger(inputBitrate))
             {
            	 bitrate=Integer.parseInt(inputBitrate);
            	 if(bitrate<=320)
            	 {
            		 bitrate=321;  
            	 }
            	            	 
             }
             List<AmazobAwsJobOutputDesc> amazobAwsJobOutputDescList = (List<AmazobAwsJobOutputDesc>)session.createSQLQuery("SELECT * FROM bitrate_master where bitrate < "+bitrate+" and profile_id = "+jobDescId).addEntity(AmazobAwsJobOutputDesc.class).list();                         
             session.flush();
             session.close();
             return amazobAwsJobOutputDescList;
     } 
    
    public AmazobAwsJobOutputDesc getAmazobAwsJobOutputDescById(String id) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            AmazobAwsJobOutputDesc amazobAwsJobOutputDesc = (AmazobAwsJobOutputDesc)session.createSQLQuery("SELECT * FROM bitrate_master WHERE bitrate_id = "+id).addEntity(AmazobAwsJobOutputDesc.class).uniqueResult();                         
            session.flush();
            session.close();
            return amazobAwsJobOutputDesc;
    }    
    public List<AmazonTranscoding> listAmazonTranscodingData(String jobId) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            List<AmazonTranscoding> amazonTranscodingsList = (List<AmazonTranscoding>)session.createSQLQuery("SELECT * FROM transcoding_input where job_id='"+jobId+"'").addEntity(AmazonTranscoding.class).list();                         
            session.flush();
            session.close();
            return amazonTranscodingsList;
    }  
    public List<AmazonTranscoding> listAmazonTranscoding() throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            List<AmazonTranscoding> amazonTranscodingsList = (List<AmazonTranscoding>)session.createSQLQuery("SELECT * FROM transcoding_input order by job_creation_datetime desc").addEntity(AmazonTranscoding.class).list();                         
            session.flush();
            session.close();
            return amazonTranscodingsList;
    }   
    public List<AmazonTranscoding> listAmazonTranscodingSearch(String status) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            List<AmazonTranscoding> amazonTranscodingsList = (List<AmazonTranscoding>)session.createSQLQuery("SELECT * FROM transcoding_input where job_status='"+status+"' order by job_creation_datetime desc").addEntity(AmazonTranscoding.class).list();                         
            session.flush();
            session.close();
            return amazonTranscodingsList;
    }  
    public List<AmazonTranscoding> listAmazonTranscodingBySqlQuery(String query) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            List<AmazonTranscoding> amazonTranscodingsList = (List<AmazonTranscoding>)session.createSQLQuery(query).addEntity(AmazonTranscoding.class).list();                         
            session.flush();
            session.close();
            return amazonTranscodingsList;
    }       
    
    public List<AmazobAwsJobOutputDesc> listAmazobAwsJobOutputDescByJobId(String output_jobid) throws Exception {
        Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            List<AmazobAwsJobOutputDesc> amazobAwsJobOutputDescList = (List<AmazobAwsJobOutputDesc>)session.createSQLQuery("SELECT * FROM transcoding_output where job_id = '"+output_jobid+"'").addEntity(AmazobAwsJobOutputDesc.class).list();                         
            session.flush();
            session.close();
            return amazobAwsJobOutputDescList;
    }   
    public AmazonWebsiteDetails AmazobAwsJobWebsiteDesc(String pName) throws Exception 
    {
        	Session session=null;
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();        
            session = sessionFactory.openSession();  
            AmazonWebsiteDetails amazobAwsJobWebsite = (AmazonWebsiteDetails) session.createSQLQuery("SELECT * FROM website_master where website_name like '%"+pName+"%'").addEntity(AmazonWebsiteDetails.class).uniqueResult();                         
            session.flush();
            session.close();
            return amazobAwsJobWebsite;
    }  
    
}
