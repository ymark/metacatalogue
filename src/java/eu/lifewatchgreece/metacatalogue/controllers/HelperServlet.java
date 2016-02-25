package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static org.apache.commons.lang3.StringUtils.stripStart;
import org.json.JSONObject;

/**
 * Provides assistance to UI though AJAX calls. 
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class HelperServlet extends MyHttpServlet {

    /**
    * Checks if a dataset name is taken. 
    * 
    * @return JSON
    */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String helpType = request.getPathInfo();      
        helpType = stripStart(helpType,"/");         
        String datasetName = request.getParameter("name");
        
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        if(datasetExists(datasetName)){
            json.put("found","yes"); 
        } else {
            json.put("found","no"); 
        }                                           
        out.print(json.toString());

        out.flush();
        out.close();
        
    }
    
}
