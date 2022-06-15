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
            <div style="float: left">
                <img src="${baseUrl}/images/data_services.png" style="width: 50px">
            </div>
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Dataset Catalogue Service
            </div>
            <c:if test = "${canManage.equals('yes')}">
    
                <a href="${baseUrl}">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button-selected" title="search">
                </a>   
                
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
        <div class="results_wrapper">
            <h3>Datasets Found</h3>
            <table class="footable table table-bordered" style="width: 100%">
                <thead>
                    <th>Row</th>
                    <th style="text-align: left">Dataset Title</th>                    
                    <th>Owner</th>
                    <th>Curator</th>                               
                    <th style="text-align: left">Dataset Type</th>
                    <th>Download Dataset</th>
                    <th data-toggle="true"></th>
                    
                    <th data-hide="all" style="text-align: left">Dataset URI</th>
                    <th data-hide="all">Contact Point</th>
                    <th data-hide="all">Access Method</th>
                    <th data-hide="all">Description</th>
                    
                    <th data-hide="all">Keeper</th>
<!--                    <th data-hide="all">Publisher</th>-->
                    <th data-hide="all">Publication Date</th>
                    <th data-hide="all">Creator</th>
                    <th data-hide="all">Creation Date</th>
                    <th data-hide="all">Contributor</th>
                    <th data-hide="all">Access Rights</th>
                    <th data-hide="all">Rights Holder</th>
                
                    <!--<th data-hide="all">Parent Dataset</th>-->
                    <th data-hide="all">Geographic Coverage</th>
                    <th data-hide="all">Taxonomic Coverage</th>
                    <th data-hide="all">Temporal Coverage</th>
                    <th data-hide="all">Embargo Period</th>
                    
                    <th data-hide="all" style="text-align: left">Dataset ID</th> 
                </thead>
                <tbody>
                    <c:forEach items="${results}" var="item" varStatus="status">
                        <tr>
                            <td><strong>${(page-1)*rpp + status.count}</strong></td>
                            <!--<td style='text-align: left'><a href="${baseUrl}/search/browse?uri=${item.getDatasetURI()}">${item.getDatasetName()}</a></td>-->
                            <td style='text-align: left'>${item.getDatasetName()}&nbsp;<a href="${baseUrl}/search/browse?uri=${item.getDatasetURI()}"><img src="../images/list_view.png" title="Show with triple-browser"></img></a></td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getOwnerURI()}">${item.getOwnerName()}</a></td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getCuratorURI()}">${item.getCuratorName()}</a></td>                                                                     
                            <td style='text-align: left'>${item.getDatasetType()}</td>
                            <td>
                                <a href="${item.getDatasetID()}" target="_blank">Download</a>
                            </td>
                            <td style='white-space: nowrap'><span class="footable-toggle"></span> More info</td>
                            
                            <td style='text-align: left'><a href="${baseUrl}/search/browse?uri=${item.getDatasetURI()}">${item.getDatasetURI()}</a></td>
                            <td>${item.getContactPoint()}</td>
                            <td>${item.getAccessMethod()}</td>
                            <td>${item.getDescription()}</td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getKeeperURI()}">${item.getKeeperName()}</a></td>
                            <!--<td><a href="${baseUrl}/search/browse?uri=${item.getPublisherURI()}">${item.getPublisherName()}</a></td>-->
                            <td>${item.getPublicationDate()}</td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getCreatorURI()}">${item.getCreatorName()}</a></td>
                            <td>${item.getCreationDate()}</td>
                            
                            <c:choose>
                                <c:when test="${item.getContributors().isEmpty()}">
                                    <td>-</td>
                                </c:when>    
                                <c:otherwise>
                                    <td><a href="${baseUrl}/search/browse?uri=${item.getContributors().get(0).getKey()}">${item.getContributors().get(0).getValue()}</a></td>
                                </c:otherwise>
                            </c:choose>   
                                    
                            <td><a href="${baseUrl}/search/browse?uri=${item.getAccessRightsURI()}">${item.getAccessRights()}</a></td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getRightsHolderURI()}">${item.getRightsHolderName()}</a></td>
               
                            <td>${item.getGeographicCoverage()}</td>
                            <td>${item.getTaxonomicCoverage()}</td>
                            <td>${item.getTemporalCoverage()}</td>
                                                                            
                            <!--<td>${item.getEmbargoState()}</td>-->
                            <td>${item.getEmbargoPeriod()}</td>    
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
