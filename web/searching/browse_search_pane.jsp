
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
                Browse Contents
            </div>
                <a href="${baseUrl}/searching/full_search_pane.jsp">
                    <img src="${baseUrl}/images/comment.png" class="my-speed-button" title="Produce Text">
                </a> 
                <a href="${baseUrl}/searching/sparql_search_pane.jsp">
                    <img src="${baseUrl}/images/sparql.png" class="my-speed-button" title="SPARQL Endpoint">
                </a> 
                <a href="${baseUrl}/searching/browse_search_pane.jsp">
                    <img src="${baseUrl}/images/browse.png" class="my-speed-button-selected" title="Browse Contents">
                </a> 
                <a href="${baseUrl}/searching/advanced_search_pane.jsp">
                    <img src="${baseUrl}/images/refine.png" class="my-speed-button" title="Advanced Search">
                </a>    
                <a href="${baseUrl}/">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button" title="Basic Search">
                </a>
            <div style="clear: both"></div>
        </div>     
        <!-- Metacatalogue Top Bar : END --> 
<div role="tabpanel" class="tab-pane" id="browseSearch">
     <div class="container" style="width: 100%">
         <div class="row">
             <div class="col-sm-6">
                <div class="row">
                    <div class="col-md-12">
                        <div class="search_header_bar">
                            Browse the Contents
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <form class="form-inline" action="../search/browse" method="get">  
                        <div class="row">                                    
                            <div class="col-md-4">
                                <label for="uri" class="control-label">URI</label>
                            </div>
                            <div class="col-md-8">
                                <input type="text" class="form-control" id="uri" name="uri" value="">
                            </div>    
                        </div>
                        <div class="row">
                            <div class="col-md-12" style="text-align: right">
                                <button type="submit" class="btn btn-default">Search</button>
                            </div>
                        </div>
                    </form>
                 </div>
             </div>
             <div class="col-sm-6">
                 
             </div>
         </div>
     </div>
 </div>
        
                <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        
            </body>
</html>