package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.core.model.DirectoryStruct;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.service.impl.DirectoryService;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j;

/**
 * Implements the Basic Search functionality
 * 
 * @license MIT
 * @author Alexandros Gougousis
 * @author Nikos Minadakis
 */
@Log4j
public class DirectorySearch extends MyHttpServlet {
    
    @Override
    public void init(ServletConfig config ) throws ServletException{
        log.debug("Initializing DirectorySearch Servlet");
        super.init(config);   
        log.debug("Successfully initialized DirectorySearch Servlet");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
        log.debug("Received get request");

        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        request.setAttribute("canManage",canManage);
        String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue"); 
        request.setAttribute("canAdministrate",canAdministrate);
        
        String owner = getTextFormField(request,"owner");
        String dataset_uri = getTextFormField(request,"datasetURI");
        String dataset_name = getTextFormField(request,"datasetName");
        String dataset_type = getTextFormField(request,"datasetType");
        String dataset_location = getTextFormField(request,"location");
        String dataset_taxonomic_coverage = getTextFormField(request,"taxonomicCoverage");
        String dataset_date = getTextFormField(request,"dateCoverage");
        
        try
        {
            // Establish a connection to Virtuoso repository
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);   
            log.debug("Established connection with virtuoso repository");
            
            String pageString = request.getParameter("page");                       // Pagination-related
            int page;                                                               // Pagination-related
            if(pageString == null){                                                 // Pagination-related
                page = 1;                                                           // Pagination-related
            } else {                                                                // Pagination-related
                page = Integer.parseInt(pageString);                                // Pagination-related
            }                                                                       // Pagination-related           
                                                               
            int offset = -1;
            int limit = -1; 
            boolean leftArrow = true;                                               // Pagination-related
            boolean rightArrow = false;                                             // Pagination-related
            int lastPage;

            // Search and retrieve the results
            List<DirectoryStruct> results = new DirectoryService(directoryManager).searchDataset(dataset_name, owner, dataset_uri,dataset_type,dataset_location, dataset_date, dataset_taxonomic_coverage, limit,offset,directoryGraph);                                    
            
            int countResults = results.size();                                      // Pagination-related
            int startPage = ((int) Math.ceil(page/(double) this.ppm) - 1)*this.ppm + 1;   // Pagination-related
            int endPage = startPage + this.ppm - 1;                                 // Pagination-related            
            if(countResults > (endPage-page+1)*this.rpp){                           // Pagination-related                     
                lastPage = endPage+1; // This is fake last page number              // Pagination-related
            } else {
                lastPage = page + (countResults / this.rpp);
            }                                                                       // Pagination-related
            if(lastPage > page){
                rightArrow = true; 
            }
            if(page == 1){                                                          // Pagination-related        
                leftArrow = false;                                                  // Pagination-related
            }                                                                       // Pagination-related
            
            if(countResults >= this.rpp){
                request.setAttribute("results",results.subList(0,this.rpp));
            } else {
                request.setAttribute("results",results);
            }
            request.setAttribute("page",page);
            request.setAttribute("rpp",this.rpp);
            request.setAttribute("startPage",startPage);
            request.setAttribute("endPage",endPage);
            request.setAttribute("lastPage", lastPage);
            request.setAttribute("leftArrow",leftArrow);
            request.setAttribute("rightArrow",rightArrow);                        
            request.setAttribute("baseUrl",baseUrl);
            request.setAttribute("searchName",dataset_name);
            request.setAttribute("searchOwner",owner);
            request.setAttribute("searchUri",dataset_uri);
            request.setAttribute("searchType",dataset_type);
            
            request.getRequestDispatcher("/collection_query_results2.jsp").forward(request, response);
        }
        catch (RepositoryConnectionException ex)
        {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
        catch (QueryExecutionException ex)
        {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "QueryExecutionException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }

        
    }        

}
