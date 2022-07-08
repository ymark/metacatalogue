<%-- 
    Document   : query_results
    Created on : 18 Μαϊ 2015, 10:26:07 πμ
    Author     : Alexandros Gougousis,Nikos Minadakis
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
        <script type="text/javascript" src="${baseUrl}/js/toastr.js"></script>
        <link rel="stylesheet" href="${baseUrl}/css/toastr.css" /> 
        <link rel="stylesheet" href="${baseUrl}/css/footable.core.css" />
        <link rel="stylesheet" href="${baseUrl}/css/custom.css" />
        
    </head>
    <body>
        <jsp:include page="/template/body_top.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        
        <!-- Metacatalogue Top Bar : START -->
            
        <div style="border: 1px solid gray; border-radius: 4px; padding:6px 0px 6px 10px; margin: 0 20px 20px 20px; background-color: #E6F3F7">            
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Basic Search - Results
            </div>
                <a href="${baseUrl}/searching/full_search_pane.jsp">
                    <img src="${baseUrl}/images/comment.png" class="my-speed-button" title="Produce Text">
                </a> 
                <a href="${baseUrl}/searching/sparql_search_pane.jsp">
                    <img src="${baseUrl}/images/sparql.png" class="my-speed-button" title="SPARQL Endpoint">
                </a> 
                <a href="${baseUrl}/searching/browse_search_pane.jsp">
                    <img src="${baseUrl}/images/browse.png" class="my-speed-button" title="Browse Contents">
                </a> 
                <a href="${baseUrl}/searching/advanced_search_pane.jsp">
                    <img src="${baseUrl}/images/refine.png" class="my-speed-button" title="Advanced Search">
                </a>    
                <a href="${baseUrl}/">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button-selected" title="Basic Search">
                </a>
            <div style="clear: both"></div>
        </div>     
        <!-- Metacatalogue Top Bar : END -->
        <div class="results_wrapper">
            <h3>Datasets Found</h3>
            <table class="footable table table-bordered" style="width: 100%">
                <thead>
                    <th>Row</th>
                    <th style="text-align: left">Dataset Title</th>                    
                    <th>Owner</th>
                    <th>Curator</th>                               
                    <th style="text-align: left">Dataset Type</th>
                    <th>View Dataset</th>
                    <th data-toggle="true"></th>
                    <th data-hide="all">Contact Point</th>
                    <th data-hide="all">Access Method</th>
                    <th data-hide="all">Description</th>
                    
                    <th data-hide="all">Owner</th>
<!--                    <th data-hide="all">Publisher</th>-->
                    <th data-hide="all">Publication Date</th>
                    <th data-hide="all">Creator</th>
                    <th data-hide="all">Metadata Provider</th>
                    <th data-hide="all">Access Rights</th>
                    <th data-hide="all">Rights Holder</th>
                
                    <!--<th data-hide="all">Parent Dataset</th>-->
                    <th data-hide="all">Geographic Coverage</th>
                    <th data-hide="all">Taxonomic Coverage</th>
                    <th data-hide="all">Temporal Coverage</th>
                    <th data-hide="all">Embargo Period</th>
                    <th data-hide="all">Keywords</th>
                    <th data-hide="all">How to Cite</th>
                    <th data-hide="all" style="text-align: left">Dataset URL</th> 
                </thead>
                <tbody>
                    <c:forEach items="${results}" var="item" varStatus="status">
                        <tr>
                            <td><strong>${(page-1)*rpp + status.count}</strong></td>
                            <td style='text-align: left'>${item.getDatasetName()}&nbsp;<a href="${baseUrl}/search/browse?uri=${item.getDatasetURI()}"><img src="../images/list_view.png" title="Show with triple-browser"></img></a></td>
                            <td>${item.getOwnerName()}</td>
                            <td>${item.getCuratorName()}</td>
                            <td style='text-align: left'>${item.getDatasetType()}</td>
                            <td>
                                <a href="${item.getDatasetID()}" target="_blank">View</a>
                            </td>
                            <td style='white-space: nowrap'><span class="footable-toggle"></span> More info</td>
                            
                            <td>${item.getContactPoint()}</td>
                            <td>${item.getAccessMethod()}</td>
                            <td>${item.getDescription()}</td>
                            <td>${item.getKeeperName()}</td>
                            <!--<td><a href="${baseUrl}/search/browse?uri=${item.getPublisherURI()}">${item.getPublisherName()}</a></td>-->
                            <td>${item.getPublicationDate()}</td>
                            <td>${item.getCreatorName()}</td>
                            
                            <c:choose>
                                <c:when test="${item.getContributors().isEmpty()}">
                                    <td>-</td>
                                </c:when>    
                                <c:otherwise>
                                    <td>${item.getContributors().get(0).getValue()}</td>
                                </c:otherwise>
                            </c:choose>   
                                    
                            <td>${item.getAccessRights()}</td>
                            <td>${item.getRightsHolderName()}</td>
               
                            <td>${item.getGeographicCoverage()}</td>
                            <td>${item.getTaxonomicCoverage()}</td>
                            <td>${item.getTemporalCoverage()}</td>
                            <td>${item.getEmbargoPeriod()}</td>   
                            <td>${item.getKeywordsUserFriendly()}</td>   
                            <td>${item.getCitation()}</td>   
                            <td><a href="${item.getDatasetID()}" target="_blank">${item.getDatasetID()}</a></td>  
                            
                        <tr/>
                    </c:forEach>
                </tbody>
            </table>
            
            <c:if test = "${lastPage != 1}">                                        
                <nav>
                    <ul class="pagination">
                        <li <c:if test = "${!leftArrow}">class='disabled'</c:if> >
                            <a href="${baseUrl}/search/directory?datasetName=${searchName}&institution=${institution}&creator=${creator}&datasetType=${datasetType}&location=${location}&taxonomicCoverage=${taxonomicCoverage}&dateCoverage=${dateCoverage}&page=${page-1}" aria-label="Previous">
                              <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:forEach begin="${startPage}" end="${endPage}" varStatus="loop">                    
                            <c:choose>
                                <c:when test="${loop.index == page}">
                                    <li class='active'><a href="#">${loop.index}</a></li>
                                </c:when>    
                                <c:otherwise>     
                                    <c:if test = "${loop.index <= lastPage}">
                                        <li><a href="${baseUrl}/search/directory?datasetName=${searchName}&institution=${institution}&creator=${creator}&datasetType=${datasetType}&location=${location}&taxonomicCoverage=${taxonomicCoverage}&dateCoverage=${dateCoverage}&page=${loop.index}">${loop.index}</a></li>
                                    </c:if>                                                                      
                                </c:otherwise>
                            </c:choose>                        
                        </c:forEach>
                        <c:if test = "${rightArrow}">
                            <li>
                                <a href="${baseUrl}/search/directory?datasetName=${searchName}&institution=${institution}&creator=${creator}&datasetType=${datasetType}&location=${location}&taxonomicCoverage=${taxonomicCoverage}&dateCoverage=${dateCoverage}&page=${page+1}" aria-label="Next">
                                  <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>            
            </c:if>
                          
        </div>
        <script type="text/javascript">
            $(function () {
                $('.footable').footable();
            });
        </script>               
        
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>
