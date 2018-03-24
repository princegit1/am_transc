/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.itgd.transcoder.bean;

import com.itgd.transcoder.util.TranscoderJobCron;
import com.itgd.transcoder.util.JobStatusUpdaterCron;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.protocol.HttpService;

/**
 *
 * @author Honey
 */
//@WebServlet(name = "RunAWSJobs", urlPatterns = {"/RunAWSJobs"})
public class RunAWSJobs extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            TranscoderJobCron cron = new TranscoderJobCron();
            System.out.println();
            System.out.println("***************************************************************************************");
            System.out.println("***************************************************************************************");
            System.out.println("******                    Start Cron                 ***********************************");
            System.out.println("***************************************************************************************");
            System.out.println("***************************************************************************************");
            cron.runCron();    
            new JobStatusUpdaterCron(1,5);
            System.out.println("***************************************************************************************");
            System.out.println("***************************************************************************************");
            System.out.println("******                    cron running successfully                 ***********************************");
            System.out.println("***************************************************************************************");
            System.out.println("***************************************************************************************");            
            
        } finally {            
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
