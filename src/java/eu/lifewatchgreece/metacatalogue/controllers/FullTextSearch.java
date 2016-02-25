package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.service.impl.MetadataRepositoryService;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Implements the Full-text Search functionality
 * 
 * @license MIT
 * @author Nikos Minadakis
 * @author Alexandros Gougousis
 */
public class FullTextSearch extends MyHttpServlet {
    
    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {               
        
        String s_name = request.getParameter("scientificName");       
        
        ArrayList<String> results_taxon= new ArrayList<String>();
        ArrayList<String> results_data= new ArrayList<String>();                  
        
        try {
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
            String description = new MetadataRepositoryService(directoryManager).produceText(s_name, baseUrl+"/search/browse?uri=", this.metadataGraph);
             
            HttpSession session = request.getSession(true);
            String canManage = (String)session.getAttribute("can_manage_datasets");
            request.setAttribute("canManage",canManage);
            String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue");
            request.setAttribute("canAdministrate",canAdministrate);
                         
             request.setAttribute("baseUrl",baseUrl);
              request.setAttribute("description",description);
             request.getRequestDispatcher("/query_results/fulltext.jsp").forward(request,response);

        } catch (RepositoryConnectionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (QueryExecutionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "QueryExecutionException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } 
        
    }


}
