package com.itgd.transcoder.util;

import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;

import com.itgd.transcoder.bean.AmazonAwsJobDesc;
import com.itgd.transcoder.bean.Joboutput;

public class TranscodingVideoXml {
	/**
	 * @param args
	 */
	public List<Joboutput> videoXml(String videoPath,int profileId,String status)
	{
		Session session=null;
		 List<Joboutput> joboutputs=null;
     try {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();       
            session = sessionFactory.openSession();
            String Query="SELECT p.profile_id as profileId,wm.website_name as webSiteName, wm.website_id as webSiteId,i.trans_input_id AS transIntputId, i.job_status AS inputjobStatus, i.input_path AS inputPath, o.output_path AS outputPath," +
            		"bm.bitrate AS bitrateId,o.output_status AS outputStatus,o.file_duration AS fileDuration FROM transcoding_input i ,transcoding_output o , bitrate_master bm ,profile_master p,website_master " +
            		"wm WHERE  i.trans_input_id=o.trans_input_id AND o.bitrate_id=bm.bitrate_id AND p.profile_id=:pid AND p.website_id=wm.website_id  and i.profile_id=:profileId AND i.input_path=:videopath";
             joboutputs=session.createSQLQuery(Query.trim())
             .addScalar("transIntputId", Hibernate.INTEGER)
             .addScalar("inputjobStatus", Hibernate.STRING)
             .addScalar("inputPath", Hibernate.STRING)
              .addScalar("outputPath", Hibernate.STRING)
              .addScalar("bitrateId", Hibernate.INTEGER)
              .addScalar("outputStatus", Hibernate.STRING)
              .addScalar("fileDuration", Hibernate.STRING)
              .addScalar("webSiteName", Hibernate.STRING)
              .addScalar("webSiteId", Hibernate.INTEGER)
               .addScalar("profileId", Hibernate.INTEGER)
               .setInteger("pid", profileId)
              .setInteger("profileId", profileId)
			  .setString("videopath", videoPath)
             .setResultTransformer(Transformers.aliasToBean(Joboutput.class)).list();           
              System.out.println(joboutputs);
              System.out.println(videoPath);
          } 
       catch(Exception ex) {
           ex.printStackTrace();            
       }finally {  session.flush();
       session.close();}
		return joboutputs;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//new TranscodingVideoXml().videoXml("transcoding/processing/2015_03/09_paris_me_shoke_ki_032615045700_1584.mp4", 6);
		new TranscodingVideoXml().videoXml("transcoding/processing/2015_03/v7_512.mp4", 6,"complete");
	}

}
