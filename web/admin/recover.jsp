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
        <title>Data Services - Recovery</title>
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
                Recovery
            </div>
            
                <a href="${baseUrl}">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button" title="search">
                </a>             

            <c:if test = "${canManage.equals('yes')}">                
                <a href="${baseUrl}/publish">
                    <img src="${baseUrl}/images/edit.png" class="my-speed-button" title="publish">
                </a>                                                               
            </c:if> 
                
                
                <a href="${baseUrl}/admin/configure">
                    <img src="${baseUrl}/images/administrate.png" class="my-speed-button" title="system configuration">
                </a>
                <img src="${baseUrl}/images/recover.png" class="my-speed-button-selected" title="recovery">                                       
                
                <a href="${baseUrl}/annotatation">
                    <img src="${baseUrl}/images/comment.png" class="my-speed-button" title="annotate">
                </a>                
                <a href="${baseUrl}/refinement">
                    <img src="${baseUrl}/images/refine.png" class="my-speed-button" title="refine">
                </a>                
                <a href="${baseUrl}/documents">
                    <img src="${baseUrl}/images/documents.png" class="my-speed-button" title="documents">
                </a>
                
            <div style="clear: both"></div>
        </div>     
        <!-- Metacatalogue Top Bar : END -->
        
        <form method="post" name="recover_directory_form" id="recover_directory_form" class="form-horizontal" action="${baseUrl}/admin/recover_directory" enctype="multipart/form-data">                                    
        </form>
        
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#recoveryModal">Recover Directory</button>
        
        <form method="post" name="recover_metadata_form" id="recover_metadata_form" class="form-horizontal" action="${baseUrl}/admin/recover_metadata" enctype="multipart/form-data">                          
        </form>                         
            
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#materializeModal">Materialize</button>
        
        <!-- Recovery Modal -->
        <div class="modal fade" id="recoveryModal" tabindex="-1" role="dialog" aria-labelledby="myRecoveryLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myRecoveryLabel">Confirmation Dialog</h4>
              </div>
              <div class="modal-body">
                Are you sure that you want to activate recovery ?
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="this.recover_directory_form.submit()">Yes</button>
              </div>
            </div>
          </div>
        </div>  
          
        <!-- Materialize Modal -->
        <div class="modal fade" id="materializeModal" tabindex="-1" role="dialog" aria-labelledby="myMaterializeLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myMaterializeLabel">Confirmation Dialog</h4>
              </div>
              <div class="modal-body">
                Are you sure that you want to materialize ?
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="this.recover_metadata_form.submit()">Yes</button>
              </div>
            </div>
          </div>
        </div>  
            
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>
