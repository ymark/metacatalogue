package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static org.apache.commons.lang3.StringUtils.stripStart;

/**
 * Lets the user download documents and templates
 * 
 * @license MIT
 * @author Alexandros Gougousis
 */
public class FileServlet extends MyHttpServlet {

    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String getType = request.getPathInfo();      
        getType = stripStart(getType,"/");   
        String[] pathParts = getType.split("/");                
        ServletContext servletContext;
        String contextPath, dlPath, mimeType, headerKey, headerValue;
        File downloadFile;
        FileInputStream inStream;
        OutputStream outStream;
        byte[] buffer;
        int bytesRead;
        
        switch(pathParts[0]){
            case "templates":
                
                // Check is second part (the template file name) of URL is there 
                if(pathParts[1] == null){
                    log2db(request,"error","Request for template file. The second parts of url is missing.");
                    request.setAttribute("errorMessage", "This URL is not valid!");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                    return;
                }
                
                // Build the file path
                servletContext = getServletContext();
                contextPath = servletContext.getRealPath(File.separator);
                dlPath = contextPath+"/files/"+pathParts[1];
                
                downloadFile = new File(dlPath);
                
                // Check that the template file exists
                if(!downloadFile.exists()){
                    log2db(request,"error","Request for template file. File not found!");
                    request.setAttribute("errorMessage", "File not found!");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                    return;
                }
                
                inStream = new FileInputStream(downloadFile);
                
                // gets MIME type of the file
                mimeType = servletContext.getMimeType(dlPath);
                if (mimeType == null) {        
                    // set to binary type if MIME mapping not found
                    mimeType = "application/octet-stream";
                }
                
                // modifies response
                response.setContentType(mimeType);
                response.setContentLength((int) downloadFile.length());
                
                // forces download
                headerKey = "Content-Disposition";
                headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
                response.setHeader(headerKey, headerValue);

                // obtains response's output stream
                outStream = response.getOutputStream();

                buffer = new byte[4096];
                bytesRead = -1;

                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }

                inStream.close();
                outStream.close();  
                
                break;
            case "documents":
                // Check is second part (the document file name) of URL is there 
                if(pathParts[1] == null){
                    log2db(request,"error","Request for document file. The second parts of url is missing.");
                    request.setAttribute("errorMessage", "This URL is not valid!");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                    return;
                }
                
                // Build the file path
                servletContext = getServletContext();
                contextPath = servletContext.getRealPath(File.separator);
                dlPath = contextPath+"/files/documents/"+pathParts[1];
                
                downloadFile = new File(dlPath);
                
                // Check that the template file exists
                if(!downloadFile.exists()){
                    log2db(request,"error","Request for document file. File not found!");
                    request.setAttribute("errorMessage", "File not found!");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                    return;
                }
                
                inStream = new FileInputStream(downloadFile);
                
                // gets MIME type of the file
                mimeType = servletContext.getMimeType(dlPath);
                if (mimeType == null) {        
                    // set to binary type if MIME mapping not found
                    mimeType = "application/octet-stream";
                }
                
                // modifies response
                response.setContentType(mimeType);
                response.setContentLength((int) downloadFile.length());
                
                // forces download
                headerKey = "Content-Disposition";
                headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
                response.setHeader(headerKey, headerValue);

                // obtains response's output stream
                outStream = response.getOutputStream();

                buffer = new byte[4096];
                bytesRead = -1;

                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }

                inStream.close();
                outStream.close();  
                break;
        }                
        
        
    }


}
