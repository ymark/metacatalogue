package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Displays a page with documents related to Data Services
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class DocumentServlet extends MyHttpServlet {

    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);      
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue");        

        request.setAttribute("canManage",canManage);
        request.setAttribute("canAdministrate",canAdministrate);
        request.setAttribute("baseUrl",baseUrl);
        request.getRequestDispatcher("documents.jsp").forward(request, response);   
        
    }


}
