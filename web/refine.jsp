<%-- 
    Document   : refine
    Created on : 21 Ιαν 2016, 11:03:15 πμ
    Author     : Alexandros Gougousis,Nikos Minadakis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Services - Refinement</title>
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
                Search
            </div>
            
                <a href="${baseUrl}">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button" title="search">
                </a>
            
            <c:if test = "${canManage.equals('yes')}">
                
                <a href="${baseUrl}/publish">
                    <img src="${baseUrl}/images/edit.png" class="my-speed-button" title="publish">
                </a>                                                               
            </c:if> 
                
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
                    <img src="${baseUrl}/images/refine.png" class="my-speed-button-selected" title="refine">
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
        
        <p>A manual on data refinement best practices can be found in chapter 6 of <a href="${baseUrl}/getFile/documents/Deliverable_2.3_Data_Services.docx">LifeWatchGreece Deliverable 2.3: Data Services</a> </p>
        <p>In order to execute Biovel's Data Refinement Workflow you must register and login in <a href="https://portal.biovel.eu/">Biovel's portal</a>. 
            A tutorial for Biovel's Data 
            Refinement Workflow can be found <a href="https://wiki.biovel.eu/display/doc/Data+Refinement+Workflow">here</a>. LifeWatch is in 
            strong cooperation with Biovel whose workflows have been also included in LifeWatch Marine vLab</p>
        
        <iframe src="https://portal.biovel.eu" style="width:100%; height: 500px; border: none"></iframe>
        
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>
