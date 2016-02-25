package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatch.core.impl.Transformations;
import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.service.impl.ContentStorageService;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.irods.jargon.core.exception.JargonException;
import org.irods.jargon.core.query.JargonQueryException;

/**
 * Handles the dataset recovery. 
 * 
 * @license MIT
 * @author Nikos Minadakis
 * @author Alexandros Gougousis
 */
public class RecoveryServlet extends MyHttpServlet {

    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue"); 

        if(canAdministrate.equals("no")){
            response.sendRedirect(this.baseUrl);
        } else {
            request.setAttribute("canManage",canManage);
            request.setAttribute("canAdministrate",canAdministrate);
            boolean success;
        
            success = recoverDirectory(request,response);
            if(success){                    
                response.sendRedirect(this.baseUrl+"/admin");
            } else {
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } 
        }               
        
    }
    
    private boolean recoverDirectory(HttpServletRequest request, HttpServletResponse response){
        
        try {

            ArrayList<String> datasets = new ArrayList<>();
            datasets = new ContentStorageService().search_directory_datasets_by_type(new ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc), "Directory Metadata","Directory_RCV");
            
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
            TreeSet<String> datasetsU = new TreeSet<>();

            for (String datasetURI : datasets) {
                datasetsU.add(datasetURI);
            }

            for (String datasetURI : datasetsU) {

                String filename = new ContentStorageService().get_dataset_by_type(new ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),
                        this.directoryRecoveryPath, datasetURI, "Directory Metadata"
                );

                ArrayList<String> queryList = new Transformations().transform_data_collection_csv(this.directoryRecoveryPath+filename, this.directoryGraph);
                Iterator itr = queryList.iterator();
                String queryString = "";
                while (itr.hasNext()) {
                    queryString = (String) itr.next();
                    directoryManager.query(queryString);
                }

            }            

        } catch (JargonException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "JargonException happened! "+ex.getMessage());
            return false;
        } catch (JargonQueryException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "JargonQueryException happened! "+ex.getMessage());
            return false;
        } catch (RepositoryConnectionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());
            return false;
        } catch (QueryExecutionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "QueryExecutionException happened! "+ex.getMessage());
            return false;
        } catch (ParseException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "ParseException happened! "+ex.getMessage());
            return false;
        } catch (IOException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "IOException happened! "+ex.getMessage());
            return false;
        } 
        
        return true;
    }

    private boolean recoverMetadata(HttpServletRequest request, HttpServletResponse response){
        return true;
    }
    
}
