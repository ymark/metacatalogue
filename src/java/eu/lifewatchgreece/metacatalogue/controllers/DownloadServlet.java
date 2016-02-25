package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.core.model.DirectoryStruct;
import eu.lifewatch.service.impl.ContentStorageService;
import eu.lifewatch.service.impl.DirectoryService;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Lets the user download datasets he is permitted to
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class DownloadServlet extends MyHttpServlet {

    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            ServletContext servletContext = getServletContext();
            String contextPath = servletContext.getRealPath(File.separator);
            String dlPath = contextPath+"/download/";
            // Retrieve Dataset URI
            String dataset_uri = getTextFormField(request,"datasetURI");

            // Check URI validity (e.g non-empty)
            if(dataset_uri == null){
                request.setAttribute("errorMessage", "Illegal URL provided!");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }                                                
            
            // Establish a connection to Virtuoso repository
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);                                                            
            // Search and retrieve the results
            List<DirectoryStruct> results = new DirectoryService(directoryManager).searchDataset("","",dataset_uri,"",directoryGraph);                                    
            // There should be one and only result   
            if(results.size() != 1){
                log2db(request,"illegal","The dataset URI resulted in "+results.size()+" directory descriptions.");
                request.setAttribute("errorMessage", "Illegal URL provided!");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } else {
                DirectoryStruct dirDescription = results.get(0);
                String datasetName = dirDescription.getDatasetName();
                
                // Access Control
                boolean downloable = false;
                String embargoState = dirDescription.getEmbargoState();
                switch(embargoState){
                    case "On Embargo":
                        break;
                    case "Out Of Embargo":
                        downloable = true;
                        break;
                }
                
                // If the downloading path does not exist, create it
                File thePath = new File(dlPath);
                if(!thePath.exists()){                    
                    thePath.mkdir();
                }                
                
                // Get file from iRODS and copy it into a local folder for downloading
                String dl_filename = new  ContentStorageService().get_dataset(new  ContentStorageService().connect_to_content_storage(irodsIP, irodsPort, irodsUsername, irodsPassword,irodsPath, irodsTempZone,irodsDemoResc),dlPath, dataset_uri,"Dataset");
                
                String filePath = dlPath+dl_filename;
                File downloadFile = new File(filePath);
                FileInputStream inStream = new FileInputStream(downloadFile);
        
                // gets MIME type of the file
                String mimeType = servletContext.getMimeType(filePath);
                if (mimeType == null) {        
                    // set to binary type if MIME mapping not found
                    mimeType = "application/octet-stream";
                }
                
                // modifies response
                response.setContentType(mimeType);
                response.setContentLength((int) downloadFile.length());
                
                // forces download
                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
                response.setHeader(headerKey, headerValue);

                // obtains response's output stream
                OutputStream outStream = response.getOutputStream();

                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }

                inStream.close();
                outStream.close();     
                
                // Delete file from temp folder after download
                downloadFile.delete();
            }                        
            
        } catch (Exception ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "An unexpected problem occured!");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
        
        
    }

}
