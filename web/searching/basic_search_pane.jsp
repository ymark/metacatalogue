<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collection"%>
<%@page import="eu.lifewatchgreece.metacatalogue.controllers.ControlledVocabularies"%>

<%
//db connection test
try{
    ControlledVocabularies cv=new ControlledVocabularies();
    cv.init(this.getServletConfig());
    Collection<String>types=cv.getDatasetTypes();
    request.setAttribute("dataset_types",types);
}
catch(Exception e){
    out.print("Unable to retrieve dataset types "+e.getMessage());
    request.setAttribute("dataset_types",new ArrayList<>());
}
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                            <label for="dateCoverage" class="control-label">Date</label>
                        </div>
                        <div class="col-md-8">
                            <input type="date" class="form-control" id="dateCoverage" name="dateCoverage" value="">
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