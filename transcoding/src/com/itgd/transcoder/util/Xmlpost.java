package com.itgd.transcoder.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;


public class Xmlpost {

	/**
	 * @param args
	 */
	public String xmlPost(String url,String xmlData)
	{
		    String message="";
		    HttpClient client = new HttpClient();
			client.getParams().setParameter("http.useragent", "Test Client");
			BufferedReader br = null;
			PostMethod method = new PostMethod(url);
			method.addParameter("xml", xmlData);
			try{
			  int returnCode = client.executeMethod(method);
			  if(returnCode == HttpStatus.SC_NOT_IMPLEMENTED) {
				  message="The Post method is not implemented by this URI";
					method.getResponseBodyAsString();
				} else {
				 message=method.getStatusCode()+"</br>"+method.getStatusText();
		  }
			}
		catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return message;
	
	}
	
	public String redXml(String path)
	{
		String xmlRecords="";
		try {
    		StringBuffer xmlRecordsbuffer=new StringBuffer();
    	 /*  ------ read xml from url code start------------  */ 
    		URL url = new URL(path);
    		HttpURLConnection request1 = (HttpURLConnection) url.openConnection();
    		request1.setRequestMethod("GET");
    		request1.connect();
    		InputStream iss = request1.getInputStream();
    		 BufferedReader bufferedReader =new BufferedReader(new InputStreamReader(request1.getInputStream()));
    		        String line1;
    		        while ((line1 = bufferedReader.readLine()) != null) {
    		          xmlRecordsbuffer.append(line1);
    		}
    		        xmlRecords=xmlRecordsbuffer.toString();
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return xmlRecords;
	}
	public static void main(String[] args) {
		System.out.println(new Xmlpost().redXml("http://localhost:8080/transcoding/trans/videoXmlStatus.jsp?profileId=6&videoName=/2015_04/VID-20141017-WA0004_268.mp4"));
		// TODO Auto-generated method stub

	}

}
