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
        
        <!-- Annotation resources START -->
        
        <script src="${baseUrl}/js/jquery-ui.min.js"></script>
        <script src="${baseUrl}/js/jquery.slidereveal.min.js"></script>
        <script type="text/javascript">
            // Change JQueryUI plugin names to fix name collision with Bootstrap.
            // Currently the annotation uses jquery-ui tooltips and slide bars.
            // Have to check if we can port it to pure bootstrap
            $.widget.bridge('uitooltip', $.ui.tooltip);
            $.widget.bridge('uibutton', $.ui.button);
            
        </script>
        <script src="${baseUrl}/js/anno.js" ></script>
        <script src="${baseUrl}/js/jsonld-markup.js"></script>
        <script src="${baseUrl}/js/select2.full.min.js"></script>
        <script src="${baseUrl}/js/bootstrap-toggle.min.js"></script>
        
        <link rel="stylesheet" type="text/css" href="${baseUrl}/css/jquery-ui.min.css">
        <link rel="stylesheet" type="text/css" href="${baseUrl}/css/anno.css">
        <link rel="stylesheet" type="text/css" href="${baseUrl}/css/jsonld-markup.css">
        <link rel="stylesheet" type="text/css" href="${baseUrl}/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="${baseUrl}/css/bootstrap-toggle.min.css">
        
        <!-- Annotation resources END -->
        
    </head>
    <body>
        
        <jsp:include page="/template/body_top.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        
        <!-- Metacatalogue Top Bar : START -->
        <div style="border: 1px solid gray; border-radius: 4px; padding:6px 0px 6px 10px; margin: 0 20px 20px 20px; background-color: #E6F3F7">            
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Advanced Search - <font size="4"><i>search through data</i></font>
            </div>
                <a href="${baseUrl}/searching/full_search_pane.jsp">
                    <img src="${baseUrl}/images/comment.png" class="my-speed-button" title="Produce Text">
                </a> 
                <a href="${baseUrl}/searching/sparql_search_pane.jsp">
                    <img src="${baseUrl}/images/sparql.png" class="my-speed-button" title="SPARQL Endpoint">
                </a> 
<!--                <a href="${baseUrl}/searching/browse_search_pane.jsp">
                    <img src="${baseUrl}/images/browse.png" class="my-speed-button" title="Browse Contents">
                </a> -->
                <a href="${baseUrl}/searching/advanced_search_pane.jsp">
                    <img src="${baseUrl}/images/refine.png" class="my-speed-button-selected" title="Advanced Search">
                </a>    
                <a href="${baseUrl}/">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button" title="Basic Search">
                </a>
            <div style="clear: both"></div>
        </div>  
        <!-- Metacatalogue Top Bar : END -->
        
        <div class="results_wrapper" id="results_wrapper_div">
            
            <div>
                <h3 style="float: left">Datasets with occurrence information</h3>
<!--                <div style="float: right; margin-top: 15px">
                    <input id="annoToggleButton" data-toggle="toggle" data-on="Annotation On" data-off="Annotation Off" type="checkbox">
                </div>-->
            </div>
            
            <table class="footable table table-bordered" >
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
                            <td style='text-align: left'>${item.getDatasetName()}&nbsp;<a href="${baseUrl}/search/browse?uri=${item.getDatasetURI()}"><img src="../../images/list_view.png" title="Show with triple-browser"></img></a></td>
                            <td>${item.getOwnerName()}</td>
                            <td>${item.getCuratorName()}</td>
                            <td style='text-align: left'>${item.getDatasetType()}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${!item.getDatasetID().isEmpty()}">
                                        <a href="${item.getDatasetID()}" target="_blank">View</a>
                                    </c:when>
                                    <c:otherwise>
                                        --
                                    </c:otherwise>
                                </c:choose>   
                            </td>
                            <td style='white-space: nowrap'><span class="footable-toggle"></span> More info</td>
                            
                            <td>
                                <span class="hovertext" data-hover="People that should be contacted to get more information about the dataset, that curate the dataset or to whom putative problems with the dataset should be addressed">
                                    ${item.getContactPoint()}
                                </span>
                            </td>    
                            <td>
                                <span class="hovertext" data-hover="The repository through which you can access the dataset">
                                    ${item.getAccessMethod()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="A brief overview of the dataset">
                                    ${item.getDescription()}
                                </span>
                            </td>
                            <td>${item.getKeeperName()}</td>
                            <!--<td><a href="${baseUrl}/search/browse?uri=${item.getPublisherURI()}">${item.getPublisherName()}</a></td>-->
                            <td>
                                <span class="hovertext" data-hover="The last published version of the dataset">
                                    ${item.getPublicationDate()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The list of creators represents the people and organisations who created the resource, in priority order">
                                    ${item.getCreatorName()}
                                </span>
                            </td>
                            
                            <c:choose>
                                <c:when test="${item.getContributors().isEmpty()}">
                                    <td>-</td>
                                </c:when>    
                                <c:otherwise>
                                    <td>${item.getContributors().get(0).getValue()}</td>
                                </c:otherwise>
                            </c:choose>   
                                    
                            <td>
                                <span class="hovertext" data-hover="The licence that is applied to a dataset provides a standardized way to define the appropriate use of the work">
                                    ${item.getAccessRights()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The owner of the dataset">
                                    ${item.getRightsHolderName()}
                                </span>    
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The geographic area covered by the dataset">
                                    ${item.getGeographicCoverage()}
                                </span> 
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Taxonomic areas covered by the dataset">
                                    ${item.getTaxonomicCoverage()}
                                </span> 
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Metadata about the time periods covered by the dataset">
                                    ${item.getTemporalCoverage()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Specifies if and for how long the owner has set an empargo period for the data">
                                    ${item.getEmbargoPeriod()}
                                </span>
                            </td>   
                            <td>
                                <span class="hovertext" data-hover="Keywords that concisely describe the resource or are related to the resource">
                                    ${item.getKeywordsUserFriendly()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The citation of the work">
                                    ${item.getCitation()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The link through which the dataset is available">
                                    <a href="${item.getDatasetID()}" target="_blank">${item.getDatasetID()}</a>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            
            <c:if test = "${lastPage != 1}">                                        
                <nav>
                    <ul class="pagination">
                        <li <c:if test = "${!leftArrow}">class='disabled'</c:if> >
                            <a href="${baseUrl}/search/advanced/occurence?scientificName=${sciName}&location=${location}&year=${year}&page=${page-1}" aria-label="Previous">
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
                                        <li><a href="${baseUrl}/search/advanced/occurence?scientificName=${sciName}&location=${location}&year=${year}&page=${loop.index}">${loop.index}</a></li>
                                    </c:if>                                                                      
                                </c:otherwise>
                            </c:choose>                        
                        </c:forEach>
                        <c:if test = "${rightArrow}">
                            <li>
                                <a href="${baseUrl}/search/advanced/occurence?scientificName=${sciName}&location=${location}&year=${year}&page=${page+1}" aria-label="Next">
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
    
            $('#annoToggleButton').change(function() {
                anno.toggleAnnotation("results_wrapper_div");                              
            })
            
        </script>
        
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>
