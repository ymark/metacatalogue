package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatch.core.impl.Transformations;
import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.service.impl.ContentStorageService;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import eu.lifewatchgreece.metacatalogue.helpers.MysqlLogRecord;
import eu.lifewatchgreece.metacatalogue.helpers.SystemSetting;
import eu.lifewatchgreece.metacatalogue.helpers.ToastMessage;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.TreeSet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.irods.jargon.core.exception.JargonException;
import org.irods.jargon.core.query.JargonQueryException;

/**
 * Handles administrative functionality
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class AdminServlet extends MyHttpServlet {
    
    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue");                         
        
        if(canAdministrate.equals("no")){       
            response.sendRedirect(this.baseUrl);            
        } else {   
            
            request.setAttribute("baseUrl",baseUrl);
            request.setAttribute("canManage",canManage);
            request.setAttribute("canAdministrate",canAdministrate);
            
            switch(servletPath){
                case "/admin/configure":
                    ArrayList<SystemSetting> settings = getSystemSettings();                        
                    request.setAttribute("settings",settings);
                    request.getRequestDispatcher("/admin/configure.jsp").forward(request, response);
                    break;
                case "/admin/logs":  
                    ArrayList<MysqlLogRecord> mysqlLogs = getMysqlLogs(30);   
                    LinkedList<String> textLogs = getLastLinesFromTextLog(10);
                    
                    request.setAttribute("mysqlLogs",mysqlLogs);
                    request.setAttribute("textLogs",textLogs);
                    request.getRequestDispatcher("/admin/logs.jsp").forward(request, response);
                    break;
                case "/admin/recovery":
                    request.getRequestDispatcher("/admin/recover.jsp").forward(request, response);
                    break;                
            }                        
        }                       
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String adminAction = request.getServletPath();         
        
        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue"); 

        if(canAdministrate.equals("no")){
            response.sendRedirect(this.baseUrl);
        } else {                        
            request.setAttribute("canManage",canManage);
            request.setAttribute("canAdministrate",canAdministrate);
                       
            boolean success;

            switch(adminAction){
                case "/admin/save_settings":
                    ArrayList<SystemSetting> settings = getSystemSettings();
                    for(SystemSetting systemSet: settings){
                        String settingName = systemSet.getSname();
                        String newValue = request.getParameter(settingName);
                        if(!((newValue == null)||(newValue.length() == 0)||(newValue.length() > 250))){
                            setSystemSetting(settingName,newValue);
                        }
                    }
                    response.sendRedirect(this.baseUrl+"/admin/configure");
                    break;
                case "/admin/recover_directory":
                    success = recoverDirectory(request,response);
                    if(success){                    
                        response.sendRedirect(this.baseUrl+"/admin/recovery");
                    } else {
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }                
                    break;
                case "/admin/recover_metadata":
                    success = recoverMetadata(request,response);
                    if(success){                    
                        response.sendRedirect(this.baseUrl+"/admin/recovery");
                    } else {
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }                
                    break;
                case "/admin/clear_mysql_datasets":
                    clearMyqlDatasets(request);
                    ToastMessage toast = new ToastMessage();
                    toast.setMessageType("success");
                    toast.setMessageString("Datasets cleared from MySQL!");
                    session.setAttribute("toast",toast);
                    response.sendRedirect(this.baseUrl+"/admin/configure");
                    break;
            }
        }                
        
    }
    
    /**  
    * Recovers the Directory graph
    * 
    * @param request  The servlet's request object
    * @param response  The servlet's response object
    * @return boolean
    */
    private boolean recoverDirectory(HttpServletRequest request, HttpServletResponse response){
        
        try {

            String homePath = "/root/recoveryTemp";
            String user = "nikos";

            ArrayList<String> datasets = new ArrayList<>();
            datasets = new ContentStorageService().search_directory_datasets_by_type(new ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc), "Directory Metadata","Directory_RCV");

            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
            TreeSet<String> datasetsU = new TreeSet<>();

            for (String datasetURI : datasets) {
                datasetsU.add(datasetURI);
            }

            for (String datasetURI : datasetsU) {

                String datasetType = "Directory Metadata";
                String filename = new ContentStorageService().get_dataset_by_type(new ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),
                        homePath, datasetURI, "Directory Metadata"
                );

                ArrayList<String> queryList = new Transformations().transform_data_collection_csv(homePath + filename, this.directoryGraph);
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

    /**  
    * Recovers the Metadata graph
    * 
    * @param request  The servlet's request object
    * @param response  The servlet's response object
    * @return boolean
    */
    private boolean recoverMetadata(HttpServletRequest request, HttpServletResponse response) {
        
        VirtuosoRepositoryManager directoryManager;
        boolean success = false;
        
        try {            
            directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
        } catch (RepositoryConnectionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());            
        }          
        
        return success;
    }
    
}
