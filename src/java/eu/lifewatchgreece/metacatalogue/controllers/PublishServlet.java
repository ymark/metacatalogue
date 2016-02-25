package eu.lifewatchgreece.metacatalogue.controllers;

import com.google.gson.Gson; 
import eu.lifewatch.core.impl.Transformations;
import eu.lifewatch.core.impl.Utils;
import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.core.model.DirectoryStruct;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.exception.URIValidationException;
import eu.lifewatch.service.impl.ContentStorageService;
import eu.lifewatch.service.impl.DirectoryService;
import eu.lifewatchgreece.metacatalogue.beans.forms.NewDescriptionForm;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import eu.lifewatchgreece.metacatalogue.helpers.FieldErrorInfo;
import eu.lifewatchgreece.metacatalogue.helpers.ToastMessage;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import net.gougousis.gvalidator.validators.FormValidator;
import org.apache.commons.lang3.StringUtils;
import static org.apache.commons.lang3.StringUtils.strip;
import static org.apache.commons.lang3.StringUtils.stripStart;
import org.irods.jargon.core.exception.JargonException;
import org.openrdf.query.BindingSet;


/**
 * Handles the publishing of a new dataset. 
 * 
 * @license MIT
 * @author Nikos Minadakis
 * @author Alexandros Gougousis
 */
@MultipartConfig  
public class PublishServlet extends MyHttpServlet {

    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);
    }
    
    /**
     * Displays the publishing page
     * 
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          
        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue"); 

        if(canManage.equals("no")){
            response.sendRedirect(this.baseUrl);
        } else {
            request.setAttribute("canManage",canManage);
            request.setAttribute("canAdministrate",canAdministrate);
            
            // Define the help information for each dataset description field
            Map<String,String> infoList = new HashMap<String,String>();
            infoList.put("dataset_id","dataset_id");
            infoList.put("datasetName","dataset_name");
            infoList.put("parent_dataset_name","parent_dataset_name");
            infoList.put("description","description");
            infoList.put("publication_date","publication_date");
            infoList.put("creation_date","creation_date");
            infoList.put("dataset_type","dataset_type");
            infoList.put("logo","logo");
            infoList.put("access_method","access_method");
            infoList.put("owner","owner");
            infoList.put("creator","creator");
            infoList.put("curator","curator");
            infoList.put("curator_email","curator_email");
            infoList.put("contributors","");
            infoList.put("keeper","");
            infoList.put("located_at","");
            infoList.put("rights","");
            infoList.put("rights_holder","");
            infoList.put("embargo_from","");
            infoList.put("embargo_to","");

            boolean success2 = load_publish_page_info(request,response);
            if(success2){                    
                request.setAttribute("baseUrl",baseUrl);
                Map<String,FieldErrorInfo> feedback = (Map<String,FieldErrorInfo>) session.getAttribute("newDescriptionFeedback");
                if(feedback != null){
                    request.setAttribute("newDescriptionFeedback",feedback);
                    session.removeAttribute("newDescriptionFeedback");
                } 
                request.getRequestDispatcher("publish.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        }                     
  
    }


    /**
     * Handles actions related to a new or existent dataset.
     * The action type comes as part of the URL
     * 
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        String canAdministrate = (String)session.getAttribute("can_administrate_metacatalogue"); 

        if(canManage.equals("no")){
            response.sendRedirect(this.baseUrl);
        } else {
            request.setAttribute("canManage",canManage);
            request.setAttribute("canAdministrate",canAdministrate);
            request.setAttribute("baseUrl",baseUrl);

            String publishType = request.getPathInfo();      
            publishType = stripStart(publishType,"/");  
            boolean success1, success2;

            switch(publishType){
                case "new_description":
                    success1 = addDescription(request,response);
                    success2 = load_publish_page_info(request,response);
                    if(success1&&success2){  
                        response.sendRedirect(this.baseUrl+"/publish");     
                    } else {
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }                                                 
                    break;
                case "new_description_file":
                    success1 = addDescriptionFromFile(request,response);
                    success2 = load_publish_page_info(request,response);
                    if(success1&&success2){                    
                        response.sendRedirect(this.baseUrl+"/publish");
                    } else {
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }                
                    break;
                case "edit_description":
                    success1 = editDescription(request,response);
                    success2 = load_publish_page_info(request,response);
                    if(success1&&success2){                    
                        request.getRequestDispatcher("/publish.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }                
                    break;
                case "add_dataset":
                    success1 = addDataset(request,response);
                    success2 = load_publish_page_info(request,response);
                    if(success1&&success2){                    
                        request.getRequestDispatcher("/publish.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }        
                    break;
                case "add_metadata":
                    success1 = addMetadata(request,response);
                    success2 = load_publish_page_info(request,response);
                    if(success1&&success2){                    
                        response.sendRedirect(this.baseUrl+"/publish");
                    } else {
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }                
                    break;
                default:
                    success2 = load_publish_page_info(request,response);
                    if(success2){                    
                        request.getRequestDispatcher("/publish.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }  
                    break;
            }
        }                
                
    }
    
    /**
     * Loads all the information needed to build the publishing page
     * 
     * @param request
     * @param response
     * @return A bolean value that indicates if the loading was successful
     * @throws ServletException
     * @throws IOException 
     */
    protected boolean load_publish_page_info(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        
        try {
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
        
            // Get the list of all the dataset names
            String query_string = "select ?dataset_name ?dataset_uri FROM <"+directoryGraph+"> where "
                                + "{?dataset_uri <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.ics.forth.gr/isl/ontology/MarineTLO/BC21_Dataset> ."
                                + " ?dataset_uri <http://www.w3.org/2000/01/rdf-schema#label> ?dataset_name}";

            List<BindingSet> results = directoryManager.query(query_string);
            Map<String,String> datasetList = new HashMap<String,String>();
            ArrayList<String> tempList1 = new ArrayList<String>();
            for(BindingSet item : results){
                String datasetName = item.getValue("dataset_name").toString().trim().replaceAll("\"","");
                String datasetUri = item.getValue("dataset_uri").toString().trim();
                datasetList.put(datasetName,datasetUri);   
                tempList1.add(datasetName);
            }            
            String datasetListString = StringUtils.join(tempList1,',');

            // Get the list of actors            
             query_string = "select distinct ?actor_name ?actor_uri "
             + " where {"
             +" { ?dataset_uri <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.ics.forth.gr/isl/ontology/MarineTLO/BC21_Dataset> ."
             +" ?dataset_uri <http://www.cidoc-crm.org/cidoc-crm/P52_has_current_owner> ?actor_uri ."
             +" ?actor_uri  <http://www.w3.org/2000/01/rdf-schema#label> ?actor_name.}"
             +"UNION { ?dataset_uri <http://www.cidoc-crm.org/cidoc-crm/P49_has_current_keeper> ?actor_uri  ."
             +" ?actor_uri  <http://www.w3.org/2000/01/rdf-schema#label> ?actor_name . }"
             +"UNION { ?dataset_uri <http://www.ics.forth.gr/isl/ontology/MarineTLO/P_has_curator> ?actor_uri ."
             +" ?actor_uri  <http://www.w3.org/2000/01/rdf-schema#label> ?actor_name . }"
             +"UNION { ?dataset_uri <http://www.ics.forth.gr/isl/ontology/MarineTLO/P_has_publisher> ?actor_uri  ."
             +" ?actor_uri  <http://www.w3.org/2000/01/rdf-schema#label> ?actor_name . }"
             +"UNION{ ?dataset_uri <http://www.cidoc-crm.org/cidoc-crm/P94_was_created_by> ?creation_event ."
             +" ?creation_event <http://www.cidoc-crm.org/cidoc-crm/P14_carried_out_by> ?actor_uri  ."
             +" ?actor_uri  <http://www.w3.org/2000/01/rdf-schema#label> ?actor_name . } }";

            results = directoryManager.query(query_string);
            Map<String,String> actorList = new HashMap<String,String>();
            ArrayList<String> tempList2 = new ArrayList<String>();

            for(BindingSet item : results){
                String actorName = strip(item.getValue("actor_name").toString().trim(),"\"");
                String actorUri = item.getValue("actor_uri").toString().trim();
                actorList.put(actorName,actorUri);     
                tempList2.add(actorName);
            }    
            String actorListString = StringUtils.join(tempList2,',');

            // Get the list of user's datasets
            ArrayList<String> userDatasetList;
            userDatasetList = getUserDatasets(request);
            String userDatasetListString = StringUtils.join(userDatasetList,',');                 
            
            request.setAttribute("datasetList",datasetList);
            request.setAttribute("userDatasetList",userDatasetList);
            request.setAttribute("actorList",actorList);
            request.setAttribute("actorListString", actorListString);
            request.setAttribute("datasetListString", datasetListString);
            request.setAttribute("userDatasetListString", userDatasetListString);
            
            return true;
        } catch (RepositoryConnectionException ex) {        
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());
            return false;
        } catch (QueryExecutionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "QueryExecutionException happened! "+ex.getMessage());
            return false;
        } catch (Exception ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "Exception happened! "+ex.getMessage());
            return false;
        }
                
    }
    
    /**
     * Imports data related to a dataset.
     * 
     * @param request
     * @param response
     * @return  A bolean value that indicates if the importation was successful
     */
    protected boolean addDataset(HttpServletRequest request, HttpServletResponse response){
        
        String targetDataset = request.getParameter("target_dataset2");
        
        if(targetDataset == null){
            log2db(request,"Exception","Illegal action! Add dataset request without required post parameters.");
            request.setAttribute("errorMessage","Illegal action!");
            return false;
        }
        
        try {
            // Read file field
            Part filePart = request.getPart("dataset_file"); 
            if (filePart == null){
                HttpSession session = request.getSession(false);
                ToastMessage toast = new ToastMessage();
                toast.setMessageType("warning");
                toast.setMessageString("A metadata file was not supplied!");
                session.setAttribute("toast",toast);    
                return true;
            }            
            String fileName = filePart.getSubmittedFileName();
            String file_destination = internalDatasetPath + File.separator + fileName;
            InputStream fileContent = filePart.getInputStream();
            
            // Save file field
            File file = new File(file_destination); 
            InputStream input = filePart.getInputStream();
            Files.copy(input, file.toPath(),REPLACE_EXISTING);        
            
            // Save metadata file to iRODS
            Date date = new Date();
            String datasetURI= new Transformations().createURI(this.uriPrefix,targetDataset,"dataset");
            
            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");
                     
            new  ContentStorageService()
                    .import_to_content_storage( new  ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),
                            internalDatasetPath+"/" + fileName, irodsPath, fileName,user_email, datasetURI,
                            date.toString(),targetDataset,"Dataset");                                    

            ToastMessage toast = new ToastMessage();
            toast.setMessageType("success");
            toast.setMessageString("Metadata has been added!");
            session.setAttribute("toast",toast);    
            return true;
            
        } catch (Exception ex){
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage",ex.getMessage());
            return false;
        }               

    }
    
    /**
     * Imports metadata related to a dataset.
     * 
     * @param request
     * @param response
     * @return A bolean value that indicates if the importation was successful
     */
    protected boolean addMetadata(HttpServletRequest request, HttpServletResponse response){
        
        String targetDataset = request.getParameter("target_dataset");
        String metadataType = request.getParameter("metadata_type");
        
        if((metadataType == null)||(targetDataset == null)){
            log2db(request,"error","Illegal action! Add metadata request without required post parameters.");
            request.setAttribute("errorMessage","Illegal action!");
            return false;
        }
        
        if(!datasetManagedByUser(request,targetDataset)){
            log2db(request,"error","Unathorized access! Add metadata request without required post parameters.");
            request.setAttribute("errorMessage","Unathorized access!");
            return false;
        }
        
        try {
            // Read file field
            Part filePart = request.getPart("metadata_file"); 
            if (filePart == null){
                HttpSession session = request.getSession(false);
                ToastMessage toast = new ToastMessage();
                toast.setMessageType("warning");
                toast.setMessageString("A metadata file was not supplied!");
                session.setAttribute("toast",toast);    
                return true;
            }            
            String fileName = filePart.getSubmittedFileName();
            String file_destination = internalMetadataPath + File.separator + fileName;
            InputStream fileContent = filePart.getInputStream();
            
            // Save file field
            File file = new File(file_destination); 
            InputStream input = filePart.getInputStream();
            Files.copy(input, file.toPath(),REPLACE_EXISTING);
            
            // Save metadata file to iRODS
            Date date = new Date();
            String datasetURI= new Transformations().createURI(this.uriPrefix,targetDataset,"dataset");
            
            HttpSession session = request.getSession(false);
            String user_email = (String) session.getAttribute("user_email");
                     
            new  ContentStorageService()
                    .import_to_content_storage( new  ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),
                            internalMetadataPath+"/" + fileName, irodsPath, fileName,user_email, datasetURI,
                            date.toString(),targetDataset ,metadataType);            
            
            //
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
            ArrayList<String> queryList = null; 
            switch(metadataType){
                case "occurences":
                    queryList = new Transformations().transform_occurence_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "environmental":
                    queryList = new Transformations().transform_environmental_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "measurement":
                    queryList = new Transformations().transform_measurement_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "identification":
                    queryList = new Transformations().transform_identification_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "morphometrics":
                    queryList = new Transformations().transform_traits_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "statistics":
                    queryList = new Transformations().transform_statistics_csv(file_destination,metadataGraph);
                    break;
                case "taxonomy":
                    queryList = new Transformations().transform_taxonomy_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "scientific_name":
                    queryList = new Transformations().transform_scientific_name_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "common_name":
                    queryList = new Transformations().transform_common_name_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "synonym":
                    queryList = new Transformations().transform_synonyms_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "specimen":
                    queryList = new Transformations().transform_specimen_csv(file_destination, metadataGraph,targetDataset);
                    break;
                case "collection":
                    queryList = new Transformations().transform_specimen_collection_csv(file_destination,metadataGraph,targetDataset);
                    break;
                case "temp_stats":
                    queryList = new Transformations().transform_occurrence_stats_temp_csv(file_destination,metadataGraph,targetDataset);
                    break;
                case "ct_specimen":
                    queryList = new Transformations().transform_microct_specimen_csv(file_destination,metadataGraph,targetDataset);
                    break;
                case "ct_scanning":
                    queryList = new Transformations().transform_microct_scanning_csv(file_destination,metadataGraph,targetDataset);
                    break;
                case "ct_reconstruct":
                    queryList = new Transformations().transform_microct_reconstruction_csv(file_destination,metadataGraph,targetDataset);
                    break;
                case "ct_postprocess":
                    queryList = new Transformations().transform_microct_postprocessing_csv(file_destination,metadataGraph,targetDataset);
                    break;    
                case "genetics":
                    queryList = new Transformations().transform_genetics_csv(file_destination,metadataGraph,targetDataset);
                    break;      
                default:
                    log2db(request,"info","Unknown metadata type");
            }
            
            Iterator itr = queryList.iterator();

            String queryString = "";
            while (itr.hasNext()) {
                queryString = (String)itr.next();
                directoryManager.query(queryString);
            }

            ToastMessage toast = new ToastMessage();
            toast.setMessageType("success");
            toast.setMessageString("Metadata has been added!");
            session.setAttribute("toast",toast);    
            return true;
        
        } catch(Exception ex){
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage",ex.getMessage());
            return false;
        }              

    }
    
    /**
     * Imports a dataset description from a file
     * 
     * @param request
     * @param response
     * @return A bolean value that indicates if the importation was successful
     */
    protected boolean addDescriptionFromFile(HttpServletRequest request, HttpServletResponse response){
        
        HttpSession session = request.getSession(false);
        
        // Create database record for this dataset
        String datasetName = getTextFormField(request,"file_dataset_name");        
        
        // Check if a dataset with that name already exists
        if((datasetName != null)&&(datasetExists(datasetName))){                       
            ToastMessage toast = new ToastMessage();
            toast.setMessageType("failure");
            toast.setMessageString("This dataset name is already being used.");
            session.setAttribute("toast",toast);    
            return false;
        }
        
        try {
            
            // Read file field
            Part filePart = request.getPart("description_file"); 
            if (filePart == null){
                ToastMessage toast = new ToastMessage();
                toast.setMessageType("warning");
                toast.setMessageString("A description file was not supplied!");
                session.setAttribute("toast",toast);    
                return true;
            }            
            String fileName = filePart.getSubmittedFileName();
            String file_destination = descriptionPath + File.separator + fileName;
            InputStream fileContent = filePart.getInputStream();
            
            // Save file field
            File file = new File(file_destination); 
            InputStream input = filePart.getInputStream();
            Files.copy(input, file.toPath(),REPLACE_EXISTING);
            
            // Save metadata file to iRODS
            Date date = new Date();
            String datasetURI= new Transformations().createURI(this.uriPrefix,datasetName,"dataset");
                        
            String user_email = (String) session.getAttribute("user_email");
                     
            new  ContentStorageService()
                    .import_to_directory_recovery( new  ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),
                            descriptionPath+"/" + fileName, irodsPath, fileName,user_email, datasetURI,
                            date.toString(),datasetName ,"Directory Metadata","Directory_RCV");
            
            new  ContentStorageService()
                    .import_to_content_storage( new  ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),
                            descriptionPath+"/" + fileName, irodsPath, fileName,user_email, datasetURI,
                            date.toString(),datasetName ,"Directory Metadata");            
            
            //
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
            ArrayList<String> queryList = null; 
            queryList = new Transformations().transform_data_collection_csv(file_destination, directoryGraph,datasetName);            
            Iterator itr = queryList.iterator();

            String queryString = "";
            while (itr.hasNext()) {
                queryString = (String)itr.next();
                directoryManager.query(queryString);
            }                        
            
            // Create a database record for this dataset
            dataset2db(request,datasetName);       
                            
            ToastMessage toast = new ToastMessage();
            toast.setMessageType("success");
            toast.setMessageString("The new dataset description has been saved.");
            session.setAttribute("toast",toast);    
            return true;
            
        } catch(Exception ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage",ex.getMessage());
            return false;
        }
        
    }
    
    /**
     * Imports a dataset description from the published HTML form
     * 
     * @param request
     * @param response
     * @return A bolean value that indicates if the importation was successful
     */
    protected boolean addDescription(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{        
        
        HttpSession session = request.getSession(false);
        String user_email = (String) session.getAttribute("user_email");
                
        FormValidator validator = new FormValidator("eu.lifewatchgreece.metacatalogue.beans.forms.NewDescriptionForm");          
        
        // Load the posted values on the validator
        validator.load(request.getParameterMap());
        // Run the validation
        if(validator.fails()){
            Map<String,FieldErrorInfo> feedback = new HashMap<String,FieldErrorInfo>();
            NewDescriptionForm form = (NewDescriptionForm) validator.getBeanForm();
            
            // Loop through all validation errors
            for (Map.Entry<String, String> entry : validator.getErrors().entrySet()) {
                // Retrieve error information
                String fieldName = entry.getKey();
                String errorMessage = entry.getValue();
                FieldErrorInfo errorInfo = new FieldErrorInfo(fieldName,errorMessage,form.getFieldAsString(fieldName));
                // Add error information into the feedback list
                feedback.put(fieldName,errorInfo);
            }
            
            // Load feedback to session
            session.setAttribute("newDescriptionFeedback",feedback);
             
            // We return true in order to reload the publishing page  and not the error page
            return true;
        }
        
        // Reading the posted values                               
        String datasetId = request.getParameter("dataset_id");                  if (datasetId == null) datasetId = "";
        String datasetName = request.getParameter("datasetName");              if (datasetName == null) datasetName = "";
        String parentDatasetName = request.getParameter("parent_dataset_name"); if (parentDatasetName == null) parentDatasetName = "";
        String description = request.getParameter("description");               if (description == null) description = "";
        String publicationDate = request.getParameter("publication_date1");     if (publicationDate == null) publicationDate = "";
        String creationDate = request.getParameter("creation_date");            if (creationDate == null) creationDate = "";
        String datasetType = request.getParameter("dataset_type1");             if (datasetType == null) datasetType = "";
        String accessMethod = request.getParameter("access_method");            if (accessMethod == null) accessMethod = "";
        String owner = request.getParameter("owner");                           if (owner == null) owner = "";
        String creator = request.getParameter("creator");                       if (creator == null) creator = "";
        String curator = request.getParameter("curator");                       if (curator == null) curator = "";
        String curatorEmail = request.getParameter("curator_email");            if (curatorEmail == null) curatorEmail = "";
        String contributors = request.getParameter("contributors");             if (contributors == null) contributors = "";
        String publisher = request.getParameter("publisher");                   if (publisher == null) publisher = "";
        String keeper = request.getParameter("keeper");                         if (keeper == null) keeper = "";
        String locatedAt = request.getParameter("located_at");                  if (locatedAt == null) locatedAt = "";
        String rights = request.getParameter("rights");                         if (rights == null) rights = "";
        String rightsHolder = request.getParameter("rights_holder");            if (rightsHolder == null) rightsHolder = "";
        String embargoFrom = request.getParameter("embargo_from1");             if (embargoFrom == null) embargoFrom = "";
        String embargoTo = request.getParameter("embargo_to1");                 if (embargoTo == null) embargoTo = "";
        String embargoState = request.getParameter("embargoState");             if (embargoState == null) embargoState = "";
        String imageURL = ""; 
         
        String creationEvent = datasetName + "_creation";
        
        // Check if a dataset with that name already exists
        if((datasetName != null)&&(datasetExists(datasetName))){                       
            ToastMessage toast = new ToastMessage();
            toast.setMessageType("failure");
            toast.setMessageString("This dataset name is already being used.");
            session.setAttribute("toast",toast);    
            return false;
        }
        
        // Building the required URIs
        Transformations trns = new Transformations();
        
        String datasetNameURI = trns.createURI(this.uriPrefix, datasetName, "dataset");
               
        String parentDatasetURI="";
        if(!parentDatasetName.isEmpty())
           parentDatasetURI = trns.createURI(this.uriPrefix, parentDatasetName, "dataset");

        String creatorURI="";
        if(!creator.isEmpty())
           creatorURI = trns.createURI(this.uriPrefix, creator, "actor");                         

        String ownerURI = trns.createURI(this.uriPrefix, owner, "actor");

        String keeperURI="";
        if(!keeper.isEmpty())
           keeperURI = trns.createURI(this.uriPrefix, keeper, "actor");

        String curatorURI = trns.createURI(this.uriPrefix, curator, "actor");

        String rightsHolderURI="";
        if(!rightsHolder.isEmpty())
           rightsHolderURI = trns.createURI(this.uriPrefix, rightsHolder, "actor");

        String rightsURI = "";

        if(!rights.isEmpty()){
           if(!rights.startsWith("http"))
              rightsURI = trns.createURI(this.uriPrefix, rights, "rights");
           else
              rightsURI = rights;
        }
             
        String publisherURI="";
        if(!publisher.isEmpty())
           publisherURI = trns.createURI(this.uriPrefix, publisher, "actor");  

        String creationEventURI="";
        if(!creationDate.isEmpty()||!creator.isEmpty())
           creationEventURI = trns.createURI(this.uriPrefix,datasetName+"Creation","creationEvent");

        String publicationEventURI="";
        if(!publicationDate.isEmpty()||!publisher.isEmpty())
           publicationEventURI = trns.createURI(this.uriPrefix,datasetName+"Publication","publicationEvent");

        String embargoPeriod = "";
        if(!embargoFrom.isEmpty()&&!embargoTo.isEmpty()&&!embargoFrom.equals(null)&&!embargoTo.equals(null))
            embargoPeriod = embargoFrom + "-" + embargoTo;

        String attributeAssignmentEventURI="";
        if((!embargoState.equals("Uknown"))&&(!embargoPeriod.isEmpty()))
            attributeAssignmentEventURI = trns.createURI(this.uriPrefix,datasetName+"AttributeAssignment","attributeAssignmentEvent");

        String accessMethodURI="";
        if(!accessMethod.isEmpty())
        accessMethodURI = trns.createURI(this.uriPrefix,datasetName+"AccessMethod","procedure");
        
        
        // Storing the description in a Struct
        DirectoryStruct directoryStruct = new DirectoryStruct();
    
        directoryStruct.withDatasetName(datasetName).withDatasetURI(datasetNameURI);
        directoryStruct.withParentDatasetName(parentDatasetName).withParentDatasetURI(parentDatasetURI);
        directoryStruct.withCreationDate(creationDate).withDescription(description);
        directoryStruct.withAccessRights(rights).withAccessRightsURI(rightsURI);
        directoryStruct.withRightsHolderName(rightsHolder).withRightsHolderURI(rightsHolderURI);
        directoryStruct.withCreatorName(creator).withCreatorURI(creatorURI);
        directoryStruct.withOwnerName(owner).withOwnerURI(ownerURI);
        directoryStruct.withCuratorName(curator).withCuratorURI(curatorURI);
        directoryStruct.withPublisherName(publisher).withPublisherURI(publisherURI);
        directoryStruct.withContactPoint(curatorEmail).withLocationURL(locatedAt);
        directoryStruct.withAccessMethod(accessMethod).withKeeperName(keeper).withKeeperURI(keeperURI);
        directoryStruct.withDatasetID(datasetId)
        .withCreationEventURI(creationEventURI).withImageURI(imageURL)
        .withAccessMethodURI(accessMethodURI).withDatasetType(datasetType)
        .withPublicationEventURI(publicationEventURI).withPublicationDate(publicationDate)
        .withAttributeAssignmentEventURI(attributeAssignmentEventURI)
        .withEmbargoState(embargoState).withEmbargoPeriod(embargoPeriod);        
        
        // Note: the contributors field can be multi-valued
        
        if(contributors != null){
            String[] contributorList = contributors.trim().split(",");
            for(String contributor: contributorList){
                String contributorURI = trns.createURI(this.uriPrefix,contributor.trim(), "actor");
                directoryStruct.withContributor(contributorURI, contributor);
            }
        }             
        
        try {            

            // Save form fields into a temporary file
            String name = datasetName+".csv";
            String content = "datasetID;parentDataset;datasetTitle;creator;"
                    + "creationDate;contributor;owner;keeper;curator;contactPoint;"
                    + "accessRights;rightsHolder;description;accessMethod;"
                    + "publisher;publicationDate;image;datasetType;locationURL;"
                    + "embargoState;embargoPeriod;";
            content+="\n";

            content+=datasetId+";"+datasetName+";"+parentDatasetName
                    +";"+creator+ ";"+creationDate+";"+contributors+";"+owner
                    +";"+keeper+";"+curator+";"+curatorEmail+";"+rights+";"+rightsHolder
                    +";"+description+";"+accessMethod+";"+publisher+";"+publicationDate
                    +";"+imageURL+";"+datasetType+";"+locatedAt+";"+embargoState+";"+embargoPeriod;


            File file = new File(descriptionPath + "/" +name);

            FileWriter fw = new FileWriter(file.getAbsoluteFile());
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(content);
            bw.close();

            // Save form file into iRODS for recovery purposes
            String datasetURI = trns.createURI(this.uriPrefix,datasetName,"dataset");
            Date date = new Date();                        
            
            new  ContentStorageService()
                    .import_to_directory_recovery( new  ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),
                            descriptionPath+"/" + name, irodsPath, name,user_email, datasetURI,
                            date.toString(),datasetName ,"Directory Metadata","Directory_RCV");
                        
            // Save form file into iRODS for any purpose
            new  ContentStorageService()
                    .import_to_content_storage( new  ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),
                            descriptionPath+"/" + name, irodsPath, name,user_email, datasetURI,
                            date.toString(),datasetName ,"Directory Metadata");
            
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
            String query = directoryStruct.toNtriples();

            new DirectoryService(directoryManager).insertStruct(directoryStruct,directoryGraph);
            
            dataset2db(request,datasetName);            
            ToastMessage toast = new ToastMessage();
            toast.setMessageType("success");
            toast.setMessageString("The new dataset description has been saved.");
            session.setAttribute("toast",toast);    
            return true;
            
        } catch (RepositoryConnectionException ex) {
            log2db(request,"RepositoryConnectionException",ex.getMessage());
            request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());            
            this.deleteDataset(request, datasetName);
            return false;
        } catch (URIValidationException ex) {
            log2db(request,"URIValidationException",ex.getMessage());
            request.setAttribute("errorMessage", "URIValidationException happened! "+ex.getMessage());
            this.deleteDataset(request, datasetName);
            return false;
        } catch (QueryExecutionException ex) {
            log2db(request,"QueryExecutionException",ex.getMessage());
            request.setAttribute("errorMessage", "QueryExecutionException happened! "+ex.getMessage());
            this.deleteDataset(request, datasetName);
            return false;
        } catch (JargonException ex) {
            log2db(request,"JargonException",ex.getMessage());
            request.setAttribute("errorMessage", "JargonException happened! "+ex.getMessage());
            this.deleteDataset(request, datasetName);
            return false;
        } catch (Exception ex){
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "Exception happened! "+ex.getMessage());     
            this.deleteDataset(request, datasetName);
            return false;
        }
        
    }

    /**
     * Deletes a dataset
     * 
     * @param request
     * @param datasetName  The name of the dataset to be deleted
     */
    private void deleteDataset(HttpServletRequest request, String datasetName){
        
        try {
            new  ContentStorageService().delete_dataset(null, datasetName);
        } catch (Exception ex) {
            log2db(request,"Deleting dataset exception",ex.getMessage());
            request.setAttribute("errorMessage", "Exception happened! "+ex.getMessage());            
        } 
        
    }
    
    /**
     * Updates a dataset description
     * 
     * @param request
     * @param response
     * @return  A bolean value that indicates if the update was successful
     * @throws ServletException
     * @throws IOException 
     */
    protected boolean editDescription(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String datasetName = request.getParameter("dataset_name2");
        if((datasetName != null)&&(datasetExists(datasetName))){
            if(datasetBelongsToUser(request,datasetName)){
                // Reading the posted values
                String datasetId = request.getParameter("dataset_id2");                     if (datasetId == null) datasetId = "";
                String parentDatasetName = request.getParameter("parent_dataset_name2");    if (parentDatasetName == null) parentDatasetName = "";
                String description = request.getParameter("description2");                  if (description == null) description = "";
                String publicationDate = request.getParameter("publication_date2");         if (publicationDate == null) publicationDate = "";
                String creationDate = request.getParameter("creation_date2");               if (creationDate == null) creationDate = "";
                String datasetType = request.getParameter("dataset_type2");                 if (datasetType == null) datasetType = "";
                String accessMethod = request.getParameter("access_method2");               if (accessMethod == null) accessMethod = "";
                String owner = request.getParameter("owner2");                              if (owner == null) owner = "";
                String creator = request.getParameter("creator2");                          if (creator == null) creator = "";
                String curator = request.getParameter("curator2");                          if (curator == null) curator = "";
                String curatorEmail = request.getParameter("curator_email2");               if (curatorEmail == null) curatorEmail = "";
                String contributors = request.getParameter("contributors2");                if (contributors == null) contributors = "";
                String publisher = request.getParameter("publisher2");                      if (publisher == null) publisher = "";
                String keeper = request.getParameter("keeper2");                            if (keeper == null) keeper = "";
                String locatedAt = request.getParameter("located_at2");                     if (locatedAt == null) locatedAt = "";
                String rights = request.getParameter("rights2");                            if (rights == null) rights = "";
                String rightsHolder = request.getParameter("rights_holder2");               if (rightsHolder == null) rightsHolder = "";
                String embargoFrom = request.getParameter("embargo_from2");                 if (embargoFrom == null) embargoFrom = "";
                String embargoTo = request.getParameter("embargo_to2");                     if (embargoTo == null) embargoTo = "";
        
                // Building the required URIs
                Transformations trns = new Transformations();

                String datasetNameURI = trns.createURI(this.uriPrefix, datasetName, "dataset");

                String parentDatasetURI="";
                if(!parentDatasetName.isEmpty())
                   parentDatasetURI = trns.createURI(this.uriPrefix, parentDatasetName, "dataset");

                String creatorURI="";
                if(!creator.isEmpty())
                   creatorURI = trns.createURI(this.uriPrefix, creator, "actor");                         

                String ownerURI = trns.createURI(this.uriPrefix, owner, "actor");

                String keeperURI="";
                if(!keeper.isEmpty())
                   keeperURI = trns.createURI(this.uriPrefix, keeper, "actor");

                String curatorURI = trns.createURI(this.uriPrefix, curator, "actor");

                String rightsHolderURI="";
                if(!rightsHolder.isEmpty())
                   rightsHolderURI = trns.createURI(this.uriPrefix, rightsHolder, "actor");

                String rightsURI = "";

                if(!rights.isEmpty()){
                   if(!rights.startsWith("http"))
                      rightsURI = trns.createURI(this.uriPrefix, rights, "rights");
                   else
                      rightsURI = rights;
                }

                String publisherURI="";
                if(!publisher.isEmpty())
                   publisherURI = trns.createURI(this.uriPrefix, publisher, "actor");  

                String creationEventURI="";
                if(!creationDate.isEmpty()||!creator.isEmpty())
                   creationEventURI = trns.createURI(this.uriPrefix,datasetName+"Creation","creationEvent");

                String publicationEventURI="";
                if(!publicationDate.isEmpty()||!publisher.isEmpty())
                   publicationEventURI = trns.createURI(this.uriPrefix,datasetName+"Publication","publicationEvent");

                String embargoPeriod = "";
                if(!embargoFrom.isEmpty()&&!embargoTo.isEmpty()&&!embargoFrom.equals(null)&&!embargoTo.equals(null))
                    embargoPeriod = embargoFrom + "-" + embargoTo;

                String accessMethodURI="";
                if(!accessMethod.isEmpty())
                accessMethodURI = trns.createURI(this.uriPrefix,datasetName+"AccessMethod","procedure");
                         
                // Storing the description in a Struct
                DirectoryStruct directoryStruct = new DirectoryStruct();

                directoryStruct.withDatasetName(datasetName).withDatasetURI(datasetNameURI);
                directoryStruct.withParentDatasetName(parentDatasetName).withParentDatasetURI(parentDatasetURI);
                directoryStruct.withAccessRights(rights).withAccessRightsURI(rightsURI);
                directoryStruct.withRightsHolderName(rightsHolder).withRightsHolderURI(rightsHolderURI);
                directoryStruct.withCreatorName(creator).withCreatorURI(creatorURI);
                directoryStruct.withOwnerName(owner).withOwnerURI(ownerURI);
                directoryStruct.withCuratorName(curator).withCuratorURI(curatorURI);
                directoryStruct.withPublisherName(publisher).withPublisherURI(publisherURI);
                directoryStruct.withAccessMethod(accessMethod).withKeeperName(keeper).withKeeperURI(keeperURI);
                directoryStruct.withDatasetID(datasetId);
                directoryStruct.withContactPoint(curatorEmail).withLocationURL(locatedAt);                        
                directoryStruct.withCreationDate(creationDate).withDescription(description);

                directoryStruct.withCreationEventURI(creationEventURI)
                .withAccessMethodURI(accessMethodURI).withDatasetType(datasetType)
                .withPublicationEventURI(publicationEventURI).withPublicationDate(publicationDate)                
                .withEmbargoPeriod(embargoPeriod);       
                              
                // Note: the contributors field can be multi-valued
                if(contributors != null){
                    String[] contributorList = contributors.trim().split(",");
                    for(String contributor: contributorList){
                        String contributorURI = trns.createURI(this.uriPrefix,contributor.trim(), "actor");
                        directoryStruct.withContributor(contributorURI, contributor);
                    }
                }
                try {                    
                    VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
                    
                    // Retrieve the information of the current description (before update)
                    DirectoryStruct oldDataset = getDatasetInfo(request,datasetName);  
                    
                    // Remove the graph nodes of the current description before adding the new ones
                    String subTriples = Utils.removeIndirectTriples(oldDataset.toNtriples(),Arrays.asList(oldDataset.getDatasetURI()));                                        
                    String deleteQuery = "DELETE DATA FROM <"+directoryGraph+"> {"+subTriples+"}";    
                    directoryManager.update(deleteQuery);
                    
                    // Insert the new description           
                    new DirectoryService(directoryManager).insertStruct(directoryStruct,directoryGraph);

                    HttpSession session = request.getSession(false);
                    ToastMessage toast = new ToastMessage();
                    toast.setMessageType("success");
                    toast.setMessageString("The dataset was modified successfully!");
                    session.setAttribute("toast",toast);     
                    return true;

                } catch (RepositoryConnectionException ex) {
                    log2db(request,"Exception",ex.getMessage());
                    request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());
                    return false;
                } catch (URIValidationException ex) {
                    log2db(request,"Exception",ex.getMessage());
                    request.setAttribute("errorMessage", "URIValidationException happened! "+ex.getMessage());
                    return false;
                } catch (QueryExecutionException ex) {
                    log2db(request,"Exception",ex.getMessage());
                    request.setAttribute("errorMessage", "QueryExecutionException happened! "+ex.getMessage());
                    return false;
                }
                
            } else {
                HttpSession session = request.getSession(false);
                ToastMessage toast = new ToastMessage();
                toast.setMessageType("error");
                toast.setMessageString("You are not allowed to modify dataset '"+datasetName+"'!");
                session.setAttribute("toast",toast);
                return true;
            }
        } else {
            if(datasetName == null)
                log2db(request,"info","Dataset name = null");
            else
                log2db(request,"info","Dataset name could not be found");
            HttpSession session = request.getSession(false);
            ToastMessage toast = new ToastMessage();
            toast.setMessageType("error");
            toast.setMessageString("Dataset name '"+datasetName+"' does not exist!");
            session.setAttribute("toast",toast);
            return true;
        }
                
            
    }
        

}
