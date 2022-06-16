<%-- 
    Document   : occurences
    Created on : 18 Μαϊ 2015, 10:26:07 πμ
    Author     : Alexandros
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Services - Search results</title>
        <jsp:include page="/template/head.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include> 
        <script type="text/javascript" src="${baseUrl}/js/footable.js"></script>
        <link rel="stylesheet" href="${baseUrl}/css/footable.core.css" />
        <link rel="stylesheet" href="${baseUrl}/css/custom.css" />
        
    </head>
    <body>
        <jsp:include page="/template/body_top.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        
        <!-- Metacatalogue Top Bar : START -->
        <div style="border: 1px solid gray; border-radius: 4px; padding:6px 0px 6px 10px; margin: 0 20px 20px 20px; background-color: #E6F3F7">            
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Browse Contents - Results
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
        <div class="results_wrapper">            
            <div style="text-align: center; font-size: 20px">
                Info about node: <span style="color: #c9302c">${nodeTitle}</span>
                <button type="button" class="btn" style="background-color: white; padding: 3px 6px; outline: 0" data-container="body" data-toggle="popover" data-placement="right" data-content="${resourceURI}">
                    <span class="glyphicon glyphicon-globe" aria-hidden="true"></span>
                </button>               
            </div>
            <br><br>
            
            <h3>Relation from <span style="font-style: italic">${nodeTitle}</span></h3>
            <table class="footable table table-bordered">
                <thead>
                    <th style="text-align: left">Relation</th>
                    <th style="text-align: left">Object</th>
                    <th style="text-align: left">Object Type</th>                
                </thead>
                <tbody>
                    <c:forEach step="6" items="${outGoingResults}" varStatus="status">
                        <tr <c:if test = "${status.count > 15}">class="collapse inputNode"</c:if> >                            
                            <td style='text-align: left'><a href="${outGoingResults[status.count*6-5]}">${outGoingResults[status.count*6-6]}</a></td>
                            <c:choose> 
                                <c:when test="${outGoingResults[status.count*6-3].equals('-')}">
                                    <td style='text-align: left'>${outGoingResults[status.count*6-4]}</td>
                                </c:when>
                                <c:otherwise>
                                    <td style='text-align: left'><a href="${baseUrl}/search/browse?uri=${outGoingResults[status.count*6-3]}">${outGoingResults[status.count*6-4]}</a></td>
                                </c:otherwise>
                            </c:choose>
                            <td style='text-align: left'><a href="${baseUrl}/search/browse?uri=${outGoingResults[status.count*6-1]}">${outGoingResults[status.count*6-2]}</a></td>                                                                                                                                          
                        <tr/>
                    </c:forEach>
                </tbody>
            </table>
            
            <div style="text-align: right" data-toggle="collapse" data-target=".inputNode" id="toggleInputNodesButton">Display all</div>                        
            
            <br>
            <h3>Relation to <span style="font-style: italic">${nodeTitle}</span></h3>            
            <table class="footable table table-bordered" >
                <thead>
                    <th style="text-align: left">Subject</th>
                    <th style="text-align: left">Subject Type</th>
                    <th style="text-align: left">Relation</th>                
                </thead>
                <tbody>
                    <c:forEach step="6" items="${inComingResults}" varStatus="status">
                        <tr <c:if test = "${status.count > 15}">class="collapse outputNode"</c:if> >
                             <c:choose> 
                                <c:when test="${inComingResults[status.count*6-5].equals('-')}">
                                    <td style='text-align: left'>${inComingResults[status.count*6-6]}</td>
                                </c:when>
                                <c:otherwise>
                                    <td style='text-align: left'><a href="${baseUrl}/search/browse?uri=${inComingResults[status.count*6-5]}">${inComingResults[status.count*6-6]}</a></td>
                                </c:otherwise>
                            </c:choose>
                            <td style='text-align: left'><a href="${baseUrl}/search/browse?uri=${inComingResults[status.count*6-3]}">${inComingResults[status.count*6-4]}</a></td> 
                            <td style='text-align: left'><a href="${inComingResults[status.count*6-1]}">${inComingResults[status.count*6-2]}</a></td>                                                                                                                                                                 
                        <tr/>
                    </c:forEach>
                </tbody>
            </table>
            <div style="text-align: right" data-toggle="collapse" data-target=".outputNode" id="toggleOutputNodesButton">Display all</div>
            
        </div>
        
        <style type="text/css">
            .inputNode.in , .outputNode.in {
                display: table-row;
            }

            #toggleInputNodesButton , #toggleOutputNodesButton {
                color: blue;
            }
            
            #toggleInputNodesButton:hover , #toggleOutputNodesButton:hover {
                cursor: pointer;                         
            }        

        </style>
            
        <script type="text/javascript">
            $(function () {
                $('.footable').footable();
                $('[data-toggle="popover"]').popover();
            });
            
            $('#toggleInputNodesButton').on('click',function(){
                $(this).hide();
            });
            
            $('#toggleOutputNodesButton').on('click',function(){
                $(this).hide();
            });
            
        </script>
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>
