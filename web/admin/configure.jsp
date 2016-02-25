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
            </c:if> 
                
  
                <img src="${baseUrl}/images/administrate.png" class="my-speed-button-selected" title="system configuration">
      
                <a href="${baseUrl}/admin/recovery">
                    <img src="${baseUrl}/images/recover.png" class="my-speed-button" title="recovery">
                </a>                 
                
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
        
            <div style="margin:20px">
                <p style="font-size: 18px; font-weight: bold; text-align: left; margin-bottom: 10px">Admin actions</p>
                
                <form id="clearMysqlForm" name="clearMysqlForm" method="post" action="${baseUrl}/admin/clear_mysql_datasets"></form>   
                <br>
                
                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#clearMysqlModal">Delete ALL datasets from MySQL</button>
                
                <!-- Clear MysqL Datasets Modal -->
                <div class="modal fade" id="clearMysqlModal" tabindex="-1" role="dialog" aria-labelledby="clearMysqlLabel">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="clearMysqlLabel">Confirmation Dialog</h4>
                      </div>
                      <div class="modal-body">
                        Are you sure that you want to delete datasets from MySQL ?
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="this.clearMysqlForm.submit()">Yes</button>
                      </div>
                    </div>
                  </div>
                </div>  
                
                <p style="font-size: 18px; font-weight: bold; text-align: left; margin-bottom: 10px">System Settings</p>
                
                <c:if test = "${settings.size() > 0}">
                <table class="table table-bordered">
                    <thead>
                        <th>Parameter</th>
                        <th>Value</th>
                        <th>Comments</th>
                    </thead>
                    <tbody>
                        <form method="post" action="${baseUrl}/admin/save_settings" class="form-horizontal">                   
                        <c:forEach items="${settings}" var="item" varStatus="status">
                            <tr>
                                <td style='text-align: left'>${item.getSname()}</td>
                                <td style='width: 50%'><input type="text" name="${item.getSname()}" value="${item.getSvalue()}" style="width:100%" class="form-control"></td>
                                <td style="width: 600px; text-align: left">${item.getAbout()}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="3" style="text-align: right">
                                <button type="submit" class="btn btn-xs btn-primary">Save changes</button>
                            </td>
                        </tr>
                        </form>
                    </tbody>
                </table>
                </c:if>                                
                
            </div>            
        <%@ include file="../checkForToast.jsp" %>
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>
