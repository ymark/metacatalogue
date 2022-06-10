
package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.service.impl.MetadataRepositoryService;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static org.apache.commons.lang3.StringUtils.stripStart;

/**
 * Handles the Advanced Search functionality
 * 
 * @license MIT
 * @author Alexandros Gougousis
 * @author Nikos Minadakis
 */
public class AdvancedSearch extends MyHttpServlet {

    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);
    }    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String searchType = request.getPathInfo();      
        searchType = stripStart(searchType,"/");                 

        HttpSession session = request.getSession(true);
        String canManage = (String)session.getAttribute("can_manage_datasets");
        request.setAttribute("canManage",canManage);        
        request.setAttribute("baseUrl",baseUrl); 
        
        try {
            
            // Variables used in various search  forms. They should be declared outside 'switch' so that they can be
            // used outside 'switch', too.
            String sciName = null, location = null, year = null, datasetURI = null, number = null, species = null,
                    genus = null, family = null, order = null, phylum = null, class_ = null, kingdom = null,
                    cname = null, place = null, language = null, jspView = null, sname = null, synonym = null,
                    date = null, actor = null, individual = null,dimension = null,specimen = null, collection = null,
                    provider = null,device = null, contrast = null,input = null, sample = null,owner = null, scanid=null, filter=null;
            
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);                        
            
            switch(searchType){
                case "occurence":    
                    sciName = getTextFormField(request,"scientificName");
                    location = getTextFormField(request,"location");
                    year = getTextFormField(request,"year");  
                    datasetURI = "";
                    request.setAttribute("sciName",sciName);
                    request.setAttribute("location",location);
                    request.setAttribute("year",year);
                    jspView = "occurences.jsp";
                    break;
                case "temp_stats":    
                    sciName = getTextFormField(request,"scientificName");
                    location = getTextFormField(request,"location");
                    year = getTextFormField(request,"year");
                    number = getTextFormField(request,"number");
                    datasetURI = "";
                    request.setAttribute("sciName",sciName);
                    request.setAttribute("location",location);
                    request.setAttribute("year",year);
                    request.setAttribute("number",number);
                    jspView = "occurences_temp.jsp";                    
                    break;
                case "taxonomy":  
                    species = getTextFormField(request,"species");
                    genus = getTextFormField(request,"genus");
                    family =  getTextFormField(request,"family");
                    order =  getTextFormField(request,"order");
                    phylum = getTextFormField(request,"phylum");
                    class_ = getTextFormField(request,"class_");
                    kingdom = getTextFormField(request,"kingdom"); 
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("genus",genus);
                    request.setAttribute("family",family);
                    request.setAttribute("order",order);
                    request.setAttribute("phylum",phylum);
                    request.setAttribute("class_",class_);
                    request.setAttribute("kingdom",kingdom);
                    jspView = "taxonomy.jsp";
                    break;
                case "common_name":  
                    species = getTextFormField(request,"species");
                    cname = getTextFormField(request,"cname");
                    place = getTextFormField(request,"place");
                    language = getTextFormField(request,"language");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("cname",cname);
                    request.setAttribute("place",place);
                    request.setAttribute("language",language);
                    jspView = "common_name.jsp";
                    break;
                case "synoym":  
                    species = getTextFormField(request,"species");
                    sname = getTextFormField(request,"sname");
                    synonym = getTextFormField(request,"synonym");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("sname",sname);
                    request.setAttribute("synonym",synonym);
                    jspView = "synonym.jsp";
                    break;
                case "scientific_name":  
                    species = getTextFormField(request,"species");
                    sname = getTextFormField(request,"scientificName");
                    date = getTextFormField(request,"date");
                    actor = getTextFormField(request,"actor");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("sname",sname);
                    request.setAttribute("date",date);
                    request.setAttribute("actor",actor);
                    jspView = "scientific.jsp";
                    break;
                case "identification":  
                    species = getTextFormField(request,"species");
                    place = getTextFormField(request,"place");
                    date = getTextFormField(request,"date");
                    individual = getTextFormField(request,"individual");
                    actor = getTextFormField(request,"actor");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("place",place);
                    request.setAttribute("date",date);                    
                    request.setAttribute("actor",actor);
                    request.setAttribute("individual",individual);
                    jspView = "identification.jsp";
                    break;
                case "measurement":  
                    species = getTextFormField(request,"species");
                    dimension = getTextFormField(request,"dimension");
                    specimen = getTextFormField(request,"specimen");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("specimen",specimen);
                    request.setAttribute("dimension",dimension); 
                    jspView = "measurement.jsp";
                    break;
                case "specimen":  
                    species = getTextFormField(request,"species");
                    specimen = getTextFormField(request,"specimen");
                    collection = getTextFormField(request,"collection");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("specimen",specimen);
                    request.setAttribute("collection",collection); 
                    jspView = "specimen.jsp";
                    break;
                case "microct_specimen":  
                    species = getTextFormField(request,"species");
                    specimen = getTextFormField(request,"specimen");
                    collection = getTextFormField(request,"collection");
                    provider = getTextFormField(request,"provider");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("specimen",specimen);
                    request.setAttribute("collection",collection);                    
                    request.setAttribute("provider",provider);
                    jspView = "mct_specimen.jsp";
                    break;
                case "microct_scanning":  
                    species = getTextFormField(request,"species");
                    filter = getTextFormField(request,"filter");
//                    specimen = getTextFormField(request,"specimen");
//                    device = getTextFormField(request,"device");
                    contrast = getTextFormField(request,"contrast");
//                    scanid = getTextFormField(request,"scanid");
                    datasetURI = "";
                    request.setAttribute("species",species);
//                    request.setAttribute("specimen",specimen);
//                    request.setAttribute("device",device);                    
                    request.setAttribute("filter",filter);
                    request.setAttribute("contrast",contrast);
//                    request.setAttribute("scanid",scanid);
                    jspView = "mct_scanning.jsp";
                    break;
                case "microct_reconstruction":  
                    species = getTextFormField(request,"species");
                    specimen = getTextFormField(request,"specimen");
                    input = getTextFormField(request,"input");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("specimen",specimen);
                    request.setAttribute("input",input);                    
                    jspView = "mct_reconstruction.jsp";
                    break;
                case "microct_postprocessing":  
                    species = getTextFormField(request,"species");
                    specimen = getTextFormField(request,"specimen");
                    input = getTextFormField(request,"input");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("specimen",specimen);
                    request.setAttribute("input",input); 
                    jspView = "mct_postprocessing.jsp";
                    break;                   
                case "genetics":  
                    species = getTextFormField(request,"species");
                    device = getTextFormField(request,"device");
                    sample = getTextFormField(request,"sample");
                    place = getTextFormField(request,"place");
                    datasetURI = "";
                    request.setAttribute("species",species);                    
                    request.setAttribute("device",device);  
                    request.setAttribute("sample",sample);
                    request.setAttribute("place",place);
                    jspView = "genetics.jsp";
                    break;                   
                case "specimen_collection":  
                    collection = getTextFormField(request,"collection");
                    owner = getTextFormField(request,"owner");
                    datasetURI = "";
                    request.setAttribute("collection",collection);
                    request.setAttribute("owner",owner);
                    jspView = "specimen_collection.jsp";
                    break;
                case "morphometric":  
                    species = getTextFormField(request,"scientificName");
                    dimension = getTextFormField(request,"morphAttribute");
                    datasetURI = "";
                    request.setAttribute("species",species);
                    request.setAttribute("dimension",dimension);
                    jspView = "morphometric.jsp";
                    break;
                case "environmental":  
                    dimension = getTextFormField(request,"dimension");
                    place = getTextFormField(request,"place");
                    datasetURI = "";
                    request.setAttribute("dimension",dimension);
                    request.setAttribute("place",place);
                    jspView = "environmental.jsp";
                    break;
                case "statistical":  
                    species = getTextFormField(request,"scientificName");
                    dimension = getTextFormField(request,"dimension");
                    datasetURI = "";
                    request.setAttribute("species",species);                    
                    request.setAttribute("dimension",dimension); 
                    jspView = "statistical.jsp";
                    break;                
             } 
                                       
            String pageString = request.getParameter("page");                       // Pagination-related
            int page;                                                               // Pagination-related
            if(pageString == null){                                                 // Pagination-related
                page = 1;                                                           // Pagination-related
            } else {                                                                // Pagination-related
                page = Integer.parseInt(pageString);                                // Pagination-related
            }                                                                       // Pagination-related           
            int offset = (page-1)*this.rpp;                                         // Pagination-related
            int limit = this.rpp*(this.ppm+1);                                          // Pagination-related
            boolean leftArrow = true;                                               // Pagination-related
            boolean rightArrow = false;                                             // Pagination-related
            int lastPage;
            
            List<?> dservice = null;
            
            switch(searchType){
                case "occurence":    
                    dservice = new MetadataRepositoryService(directoryManager).searchOccurrence(sciName, location, year,datasetURI,offset,limit,this.metadataGraph);
                    break;
                case "temp_stats":    
                    dservice = new MetadataRepositoryService(directoryManager).searchOccurenceStatsTemp(sciName, location,year, number,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "taxonomy":  
                    dservice = new MetadataRepositoryService(directoryManager).searchTaxonomy(species, genus, family, order, class_, phylum, kingdom,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "common_name":  
                    dservice = new MetadataRepositoryService(directoryManager).searchCommonName(species, cname, place, language, datasetURI, this.metadataGraph);
                    break;
                case "synoym":  
                    dservice = new MetadataRepositoryService(directoryManager).searchSynonym(species, sname, synonym,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "scientific_name":  
                    dservice = new MetadataRepositoryService(directoryManager).searchScientificNaming(species, date, actor, sname,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "identification":  
                    dservice = new MetadataRepositoryService(directoryManager).searchIdentification(species, date, actor, place, individual,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "measurement":  
                    dservice = new MetadataRepositoryService(directoryManager).searchMeasurement(specimen, species, dimension,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "specimen":  
                    dservice = new MetadataRepositoryService(directoryManager).searchSpecimen(species, specimen, collection,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "microct_specimen":  
                    dservice = new MetadataRepositoryService(directoryManager).searchMicroCTSpecimen(specimen, collection,species, provider,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "microct_scanning":  
                    dservice = new MetadataRepositoryService(directoryManager).searchMicroCTScanning(species,filter,contrast,offset,limit,this.metadataGraph);
                    break;
                case "microct_reconstruction":  
                    dservice = new MetadataRepositoryService(directoryManager).searchMicroCTReconstruction(species, specimen, input,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "microct_postprocessing":  
                    dservice = new MetadataRepositoryService(directoryManager).searchMicroCTPostProcessing(species, specimen, input,datasetURI,offset,limit, this.metadataGraph);
                    break;                   
                case "genetics":  
                    dservice = new MetadataRepositoryService(directoryManager).searchGenetics(species,sample,place,device,datasetURI,offset,limit, this.metadataGraph);
                    break;                   
                case "specimen_collection":  
                    dservice = new MetadataRepositoryService(directoryManager).searchSpecimenCollection(collection, owner,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "morphometric":            
                    dservice = new MetadataRepositoryService(directoryManager).searchMorphometrics(species, dimension,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "environmental":  
                    dservice = new MetadataRepositoryService(directoryManager).searchEnvironmental(dimension, place,datasetURI,offset,limit, this.metadataGraph);
                    break;
                case "statistical":  
                    dservice = new MetadataRepositoryService(directoryManager).searchStats(species, dimension,datasetURI,offset,limit, this.metadataGraph);
                    break;                
             }             
            
            int countResults = dservice.size();                                             // Pagination-related
            int startPage = ((int) Math.ceil(page/(double) this.ppm) - 1)*this.ppm + 1;     // Pagination-related
            int endPage = startPage + this.ppm - 1;                                         // Pagination-related
            if(countResults > (endPage-page+1)*this.rpp){                                   // Pagination-related                     
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
                request.setAttribute("results",dservice.subList(0,this.rpp));
            } else {
                request.setAttribute("results",dservice);
            }
            System.out.println("countresults: "+countResults);
            System.out.println("startpage: "+startPage);
            System.out.println("endpage: "+endPage);
            System.out.println("ppm: "+this.ppm);
            System.out.println("rpp: "+this.rpp);
            
            request.setAttribute("page",page);
            request.setAttribute("rpp",this.rpp);
            request.setAttribute("startPage",startPage);
            request.setAttribute("endPage",endPage);
            request.setAttribute("lastPage", lastPage);
            request.setAttribute("leftArrow",leftArrow);
            request.setAttribute("rightArrow",rightArrow);  
            System.out.println("jspView: "+jspView);
            request.getRequestDispatcher("/query_results/"+jspView).forward(request, response);
            return;
        } catch (QueryExecutionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "QueryExecutionException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (ServletException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "ServletException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (IOException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "IOException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (RepositoryConnectionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } 
        
    }
    
}
