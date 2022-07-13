<%-- 
    Document   : index
    Created on : Apr 30, 2015, 12:18:32 PM
    Author     : Alexandros Gougousis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@page import="java.util.Collection"%>
<%@page import="java.util.Set"%>
<%@page import="eu.lifewatchgreece.metacatalogue.controllers.ControlledVocabularies"%>
<%@page import="eu.lifewatchgreece.metacatalogue.helpers.MyHttpServlet"%>

<%
//    request.setAttribute("dataset_types", MyHttpServlet.datasetTypes);
    ControlledVocabularies controlledVocabularies=new ControlledVocabularies();
    if(controlledVocabularies.datasetTypes==null){
        controlledVocabularies.init(this.getServletConfig());
        Collection<String> datasetTypes=controlledVocabularies.getDatasetTypes();
        request.setAttribute("dataset_types", datasetTypes);
    }else{
        request.setAttribute("dataset_types", controlledVocabularies.datasetTypes);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Services - Search</title>      
        <jsp:include page="/template/head.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        <script type="text/javascript" src="${baseUrl}/js/toastr.js"></script>
        <link rel="stylesheet" href="${baseUrl}/css/toastr.css" /> 
        <link rel="stylesheet" href="${baseUrl}/css/custom.css" />           
    </head>
    <body>     
        <jsp:include page="/template/body_top.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        <!-- Metacatalogue Top Bar : START -->
        <div style="border: 1px solid gray; border-radius: 4px; padding:6px 0px 6px 10px; margin: 0 20px 20px 20px; background-color: #E6F3F7">            
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Basic Search - <font size="4"><i>search through metadata</i></font>
            </div>
                <a href="${baseUrl}/searching/full_search_pane.jsp">
                    <img src="${baseUrl}/images/comment.png" class="my-speed-button" title="Produce Text">
                </a> 
                <a href="${baseUrl}/searching/sparql_search_pane.jsp">
                    <img src="${baseUrl}/images/sparql.png" class="my-speed-button" title="SPARQL Endpoint">
                </a> 
<!--                <a href="${baseUrl}/searching/browse_search_pane.jsp">
                    <img src="${baseUrl}/images/browse.png" class="my-speed-button" title="Browse Contents">
                </a> -->
                <a href="${baseUrl}/searching/advanced_search_pane.jsp">
                    <img src="${baseUrl}/images/refine.png" class="my-speed-button" title="Advanced Search">
                </a>    
                <a href="${baseUrl}">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button-selected" title="Basic Search">
                </a>
            <div style="clear: both"></div>
        </div>     
        <!-- Metacatalogue Top Bar : END -->
                
        <div role="tabpanel" class="tabpanel">
    <div role="tabpanel" class="tab-pane active" id="basicSearch">
        <div class="row">
            <div class="col-sm-6">
                <div class="row">
                    <div class="col-md-12">
                        <div class="search_header_bar">
                            Search Dataset Description
                        </div>
                    </div>
                </div>
                <form class="form-inline" action="search/directory" method="get">  
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="datasetName" class="control-label">Dataset Name</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="datasetName" name="datasetName" value="">
                        </div>    
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="institution" class="control-label info-label" data-container="body" data-toggle="popover" data-placement="left" data-content="">Institution</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="institution" name="institution" value="">
                        </div>                                    
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="creator" class="control-label">Creator</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="creator" name="creator" value="">
                        </div> 
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="location" class="control-label">Location</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="location" name="location" value="">
                        </div> 
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="taxonomicCoverage" class="control-label">Taxonomic Coverage</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="taxonomicCoverage" name="taxonomicCoverage" value="">
                        </div> 
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="dateCoverage" class="control-label">Date (from/until)</label>
                        </div>
                        <div class="col-md-4">
                            <input type="number" class="form-control" id="dateCoverageFrom" name="dateCoverageFrom" min="1900" max="2030" step="1" value=""> 
                        </div>
                        <div class="col-md-4">
                            <input type="number" class="form-control" id="dateCoverageTo" name="dateCoverageTo" min="1900" max="2030" step="1" value=""> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <label for="datasetType" class="control-label">Dataset Type</label>
                        </div>
                        <div class="col-md-8">
                            <select class="form-control" name="datasetType">
                                <option value="" selected>Not defined</option>
                                <c:forEach var="dataset_type" items="${dataset_types}">                
                                    <option><c:out value="${dataset_type}" /></option>
                                </c:forEach>                                                                                              
                            </select>
                        </div>              
                    </div>
                    <div class="row">
                        <div class="col-md-12" style="text-align: right">
                            <button type="submit" class="btn btn-default">Search</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-sm-6">
                                               
            </div>                            
        </div>
</div>

            

        </div>
                
        
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>