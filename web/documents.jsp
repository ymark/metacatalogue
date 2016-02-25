<%-- 
    Document   : documents
    Created on : Apr 30, 2015, 12:18:32 PM
    Author     : Alexandros Gougousis , Nikos Minadakis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Services - Documents</title>
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
                    <img src="${baseUrl}/images/search.png" class="my-speed-button-selected" title="search">
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
        
        <div class="row">
            <div class="col-md-12">
                <div class="search_header_bar" id="template_list">
                    Download Templates
                    <div class="row">
                        <div class="col-md-4"><a href="${baseUrl}/getFile/documents/Deliverable_2.1_Metadata_Catalogue.docx"><img src="${baseUrl}/images/docx.png"><br>Deliverable 2.1: Metadata Catalogue</a></div>
                        <div class="col-md-4"><a href="${baseUrl}/getFile/documents/Deliverable_2.2_Data_Flow.docx"><img src="${baseUrl}/images/docx.png"><br>Deliverable 2.2: Data_Flow</a></div>
                        <div class="col-md-4"><a href="${baseUrl}/getFile/documents/Deliverable_2.3_Data_Services.docx"><img src="${baseUrl}/images/docx.png"><br>Deliverable 2.3: Data Services</a></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4"><a href="${baseUrl}/getFile/documents/Deliverable_2.4_Coordinates_Tool.docx"><img src="${baseUrl}/images/docx.png"><br>Deliverable 2.4: Coordinates Tool</a></div>
                        <div class="col-md-4"><a href="${baseUrl}/getFile/documents/Deliverable_2.5_Coordinates_Tool.docx"><img src="${baseUrl}/images/docx.png"><br>Deliverable 2.5: Technical Support</a></div>
                        <div class="col-md-4"><a href="${baseUrl}/getFile/documents/2015_10_LW_DataServices_(Minadakis_NHMC).pptx"><img src="${baseUrl}/images/pptx.png"><br>LW Data Services presentation</a></div>
                    </div>
                    <div class="row">
                       <div class="col-md-4"><a href="${baseUrl}/getFile/documents/2015_10_MarineTLO_(Marketakis_NHMC).pptx"><img src="${baseUMicroCTPostprocessingTemplaterl}/images/pptx.png"><br>Semantic Models presentation</a></div>                        
                    </div>                                       
                </div>
            </div>
        </div>
        
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>