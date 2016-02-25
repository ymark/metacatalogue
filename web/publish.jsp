<%-- 
    Document   : publish
    Created on : Apr 30, 2015, 12:18:32 PM
    Author     : Alexandros Gougousis , Nikos Minadakis
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="eu.lifewatchgreece.metacatalogue.helpers.ToastMessage"%>
<%@page import="eu.lifewatchgreece.metacatalogue.helpers.FieldErrorInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="ex" uri="WEB-INF/tlds/custom.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Services - Publish</title>
        <jsp:include page="/template/head.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>    
        <script type="text/javascript" src="${baseUrl}/js/moment.js"></script>
        <script type="text/javascript" src="${baseUrl}/js/bootstrap-datetimepicker.min.js"></script>
        <script type="text/javascript" src="${baseUrl}/js/gen_validatorv4.js"></script>    
        <script type="text/javascript" src="${baseUrl}/js/toastr.js"></script>
        <link rel="stylesheet" href="${baseUrl}/css/bootstrap-datetimepicker.min.css" />
        <link rel="stylesheet" href="${baseUrl}/css/custom.css" />    
        <link rel="stylesheet" href="${baseUrl}/css/toastr.css" /> 
    </head>
    <body>
        <jsp:include page="/template/body_top.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        
        <script type="text/javascript">
            var datasetNames = new Array();
            var datasetUris = new Array();            
            <c:forEach items="${datasetList}" var="entry">
                datasetNames.push('${entry.key}');
                datasetUris.push('${entry.value}');
            </c:forEach>     
                
            var userDatasetNames = new Array();    
            <c:forEach items="${userDatasetList}" var="item">
                userDatasetNames.push('${item}');
            </c:forEach>         
                
            var actorNames = new Array();
            <c:forEach items="${actorList}" var="entry">
                actorNames.push('${entry.key}');
            </c:forEach> 
        </script>
        
        <!-- Metacatalogue Top Bar : START -->
        <div style="border: 1px solid gray; border-radius: 4px; padding:6px 0px 6px 10px; margin: 0 20px 20px 20px; background-color: #E6F3F7">            
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Publish
            </div>
            
                <a href="${baseUrl}">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button" title="search">
                </a>             

                <a href="${baseUrl}/publish">
                    <img src="${baseUrl}/images/edit.png" class="my-speed-button-selected" title="publish - home page">
                </a>
                
            <c:if test = "${canAdministrate.equals('yes')}">    
                <a href="${baseUrl}/admin/configure">
                    <img src="${baseUrl}/images/administrate.png" class="my-speed-button" title="system configuration">
                </a> 
                <a href="${baseUrl}/admin/recovery">
                    <img src="${baseUrl}/images/recover.png" class="my-speed-button" title="recovery">
                </a> 
            </c:if> 
                
                <a href="${baseUrl}/annotatation">
                    <img src="${baseUrl}/images/comment.png" class="my-speed-button" title="annotate">
                </a>                
                <a href="${baseUrl}/refinement">
                    <img src="${baseUrl}/images/refine.png" class="my-speed-button" title="refine">
                </a>                
                <a href="${baseUrl}/documents">
                    <img src="${baseUrl}/images/documents.png" class="my-speed-button" title="documents">
                </a>
                
            <c:if test = "${canAdministrate.equals('yes')}">    
                <a href="${baseUrl}/admin/logs">
                    <img src="${baseUrl}/images/logs.png" class="my-speed-button" title="Recent Logs">
                </a>                
            </c:if>
                
            <div style="clear: both"></div>
        </div>     
        <!-- Metacatalogue Top Bar : END -->        
        
        <div role="tabpanel" class="tabpanel">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
              <li role="presentation" class="active"><a href="#new_description" aria-controls="new_description" role="tab" data-toggle="tab">New Dataset Description</a></li>
              <li role="presentation"><a href="#edit_description" aria-controls="edit_description" role="tab" data-toggle="tab">Update Dataset Description</a></li>     
              <li role="presentation"><a href="#add_metadata" aria-controls="add_metadata" role="tab" data-toggle="tab">Add Dataset Metadata</a></li>               
              <li role="presentation"><a href="#add_dataset" aria-controls="add_dataset" role="tab" data-toggle="tab">Add Dataset</a></li> 
              <li role="presentation"><a href="#download_templates" aria-controls="download_templates" role="tab" data-toggle="tab">Download Templates</a></li> 
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="new_description">
                    <%@include file="publishing/new_description.jsp" %>
                </div>
                <div role="tabpanel" class="tab-pane" id="edit_description">
                    <%@include file="publishing/edit_description.jsp" %> 
                </div>
                <div role="tabpanel" class="tab-pane" id="add_metadata">
                    <%@include file="publishing/add_internal_metadata.jsp" %> 
                </div>               
                <div role="tabpanel" class="tab-pane" id="add_dataset">
                    <%@include file="publishing/add_dataset.jsp" %> 
                </div>
                <div role="tabpanel" class="tab-pane" id="download_templates">
                    <%@include file="publishing/download_templates.jsp" %> 
                </div>
            </div>
        </div>                 
        <%@ include file="checkForToast.jsp" %>
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>
