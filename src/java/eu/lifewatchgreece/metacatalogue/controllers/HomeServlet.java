package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Loads the Home Page. 
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class HomeServlet extends MyHttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        Map<String,String> tooltips = new HashMap<String,String>();
        tooltips.put("owner","Demo text sample for a label tooltip.");
        
        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue");        

        request.setAttribute("canManage",canManage);
        request.setAttribute("canAdministrate",canAdministrate);
        request.setAttribute("tooltips", tooltips);
        request.setAttribute("baseUrl",baseUrl);
        request.getRequestDispatcher("index.jsp").forward(request, response);   
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
        
    }

}
