package eu.lifewatchgreece.metacatalogue.controllers;

import eu.lifewatch.core.impl.VirtuosoRepositoryManager;
import eu.lifewatch.core.model.IncomingNodeStruct;
import eu.lifewatch.core.model.OutgoingNodeStruct;
import eu.lifewatch.exception.QueryExecutionException;
import eu.lifewatch.exception.RepositoryConnectionException;
import eu.lifewatch.service.impl.MetadataRepositoryService;
import eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Implements the Browse Contents functionality
 * 
 * @license MIT
 * @author Nikos Minadakis
 * @author Alexandros Gougousis
 */
public class BrowseSearch extends MyHttpServlet {
 
    @Override
    public void init(ServletConfig config ) throws ServletException{
        super.init(config);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            String resourceURI = request.getParameter("uri");
            
            // Find outgoing graph nodes
            ArrayList<String> outGoingResults= new ArrayList<String>();            
            VirtuosoRepositoryManager directoryManager = new VirtuosoRepositoryManager(virtuosoUrl,virtuosoPort,virtuosoUser,virtuosoPass);
            List<OutgoingNodeStruct> dservice = new MetadataRepositoryService(directoryManager).selectOutgoing(resourceURI,directoryGraph,metadataGraph);
            
            String nodeTitle = "";
            boolean titleWasSet = false;
            
            for(int i=0;i<dservice.size();i++) {
                 
                String predicate =  dservice.get(i).getPredicate();
                
                String[] parts = null;
                
                if(predicate.contains("#"))
                    parts = predicate.split("#");
                else
                    parts = predicate.split("/");
                
                String predicateLabel = parts[parts.length-1];
                
                outGoingResults.add(predicateLabel);
                outGoingResults.add(predicate);
                                
                // Use the first 'label' node as a Title
                if((predicateLabel.equals("label"))&&(!titleWasSet)){
                    if(!dservice.get(i).getObjectName().isEmpty())
                        nodeTitle = dservice.get(i).getObjectName();
                    else
                        nodeTitle = dservice.get(i).getObject();
                    titleWasSet = true;
                }
                
                if((dservice.get(i).getObject().startsWith("http"))&&(!dservice.get(i).getPredicate().equals("http://www.w3.org/1999/02/22-rdf-syntax-ns#type"))){
                                    
                    if(!dservice.get(i).getObjectName().isEmpty())
                        outGoingResults.add(dservice.get(i).getObjectName());
                    else
                        outGoingResults.add(dservice.get(i).getObject());
                    
                    outGoingResults.add(dservice.get(i).getObject());    
                    
                    String type =  dservice.get(i).getObjectType();
                
                    String[] parts2 = null;
                    if(type.contains("#"))
                        parts2 = type.split("#");
                    else
                        parts2 = type.split("/");
                
                    String typeLabel = parts2[parts2.length-1];
                
                    outGoingResults.add(typeLabel);
                    outGoingResults.add(type);
                    
                } else {
                    outGoingResults.add(dservice.get(i).getObject());
                    outGoingResults.add("-");
                    outGoingResults.add("-");
                    outGoingResults.add("-");
                }
            }
            
            // Find ingoing graph nodes
            ArrayList<String> inComingResults= new ArrayList<String>();
            List<IncomingNodeStruct> mservice = new MetadataRepositoryService(directoryManager).selectIncoming(resourceURI,directoryGraph,metadataGraph);
            
            for(int i=0;i<mservice.size();i++) {
                if((mservice.get(i).getSubject().startsWith("http"))&&(!mservice.get(i).getPredicate().equals("http://www.w3.org/1999/02/22-rdf-syntax-ns#type"))){
                    if(!mservice.get(i).getSubjectName().isEmpty())
                        inComingResults.add(mservice.get(i).getSubjectName());
                     else
                        inComingResults.add(mservice.get(i).getSubject());
                    inComingResults.add(mservice.get(i).getSubject());     
                    
                    String type =  mservice.get(i).getSubjectType();
                
                    String[] parts2 = null;
                    if(type.contains("#"))
                        parts2 = type.split("#");
                    else
                        parts2 = type.split("/");
                
                    String typeLabel = parts2[parts2.length-1];
                
                    inComingResults.add(typeLabel);

                    inComingResults.add(type);

                } else {
                    inComingResults.add(mservice.get(i).getSubject());
                    inComingResults.add("-");               
                    inComingResults.add("-");   
                    inComingResults.add("-");
                }
                
                String[] parts = null;
                
                String predicate =  mservice.get(i).getPredicate();
                if(predicate.contains("#"))
                    parts = predicate.split("#");
                else
                    parts = predicate.split("/");
                
                String predicateLabel = parts[parts.length-1];
                
                inComingResults.add(predicateLabel);
                
                inComingResults.add(predicate);

            }

            HttpSession session = request.getSession(true);
            String canManage = (String)session.getAttribute("can_manage_datasets");
            
            if(nodeTitle.isEmpty()){
                nodeTitle = resourceURI;
            }
            
            request.setAttribute("canManage",canManage);
            request.setAttribute("baseUrl",baseUrl);
            request.setAttribute("nodeTitle",nodeTitle);
            request.setAttribute("resourceURI",resourceURI);
            request.setAttribute("outGoingResults",outGoingResults);
            request.setAttribute("inComingResults",inComingResults);
            request.getRequestDispatcher("/query_results/browse_results.jsp").forward(request, response);
        } catch (QueryExecutionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "QueryExecutionException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (RepositoryConnectionException ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "RepositoryConnectionException happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception ex) {
            log2db(request,"Exception",ex.getMessage());
            request.setAttribute("errorMessage", "Exception happened! "+ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
        
    }


}
