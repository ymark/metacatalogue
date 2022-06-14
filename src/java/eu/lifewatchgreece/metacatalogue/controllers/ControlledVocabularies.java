package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.service.impl.DirectoryService;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import lombok.extern.log4j.Log4j;

/**
 * Implements the Basic Search functionality
 * 
 * @license MIT
 * @author Alexandros Gougousis
 * @author Nikos Minadakis
 */
@Log4j
public class ControlledVocabularies extends MyHttpServlet {
    
    @Override
    public void init(ServletConfig config ) throws ServletException{
        log.debug("Initializing DirectorySearch Servlet");
        super.init(config);   
        log.debug("Successfully initialized DirectorySearch Servlet");
    }
    
    public Collection<String> getDatasetTypes() throws ServletException {
        try{
            VirtuosoRepositoryManager repoManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
            DirectoryService directoryService=new DirectoryService(repoManager);
            return directoryService.retrieveDatasetTypes(directoryGraph);
        }catch(RepositoryConnectionException | QueryExecutionException ex){
            log.error("An error occured while retrieving the available dataset types");
            return new ArrayList<>();
        }
    }

}
