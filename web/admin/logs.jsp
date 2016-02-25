<%-- 
    Document   : main
    Created on : 2 Οκτ 2015, 10:29:44 πμ
    Author     : Alexandros
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administration Main Page</title>
        <jsp:include page="/template/head.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include> 
        <script type="text/javascript" src="${baseUrl}/js/toastr.js"></script>
        <link rel="stylesheet" href="${baseUrl}/css/toastr.css" /> 
        <link rel="stylesheet" href="${baseUrl}/css/custom.css" />      
        <link rel="stylesheet" href="${baseUrl}/js/custom.js" />
    </head>
    <body>
        <jsp:include page="/template/body_top.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>     
        
        <!-- Metacatalogue Top Bar : START -->
        <div style="border: 1px solid gray; border-radius: 4px; padding:6px 0px 6px 10px; margin: 0 20px 20px 20px; background-color: #E6F3F7">            
            
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                System Configuration
            </div>
            
                <a href="${baseUrl}">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button" title="search">
                </a>             

            <c:if test = "${canManage.equals('yes')}">                
                <a href="${baseUrl}/publish">
                    <img src="${baseUrl}/images/edit.png" class="my-speed-button" title="publish">
                </a>                             
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
                    <img src="${baseUrl}/images/logs.png" class="my-speed-button-selected" title="Recent Logs">
                </a>                
            </c:if>
                
            <div style="clear: both"></div>
        </div>     
        <!-- Metacatalogue Top Bar : END -->                
        
            <div style="margin:20px">                                                              
                
                <p style="font-size: 18px; font-weight: bold; text-align: left; margin-bottom: 10px">Last 30 MySQL logs</p>
                <table class="table table-bordered table-condensed">
                    <thead>
                        <th>user_email</th>
                        <th>when</th>
                        <th>action</th>
                        <th>message</th>
                    </thead>
                    <tbody>              
                        <c:if test = "${mysqlLogs.size() > 0}">
                            <c:forEach items="${mysqlLogs}" var="item" varStatus="status">
                                <tr>
                                    <td style='text-align: left'>${item.getUser_email()}</td>
                                    <td style='text-align: left'>${item.getWhen().toString()}</td>
                                    <td style="text-align: left">${item.getAction()}</td>
                                    <td style="width: 50%; text-align: left">${item.getMessage()}</td>
                                </tr>
                            </c:forEach>    
                        </c:if>
                    </tbody>
                </table>
                
                <p style="font-size: 18px; font-weight: bold; text-align: left; margin-bottom: 10px">Last 10 text logs</p>
                <table class="table table-bordered table-condensed">
                    <tbody>              
                        <c:if test = "${textLogs.size() > 0}">
                            <c:forEach items="${textLogs}" var="item" varStatus="status">
                                <tr>
                                    <td style='text-align: left'>${item}</td>                                  
                                </tr>
                            </c:forEach>    
                        </c:if>
                    </tbody>
                </table>
                
            </div>            
        <%@ include file="../checkForToast.jsp" %>
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>
