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
        <link rel="stylesheet" href="${baseUrl}/css/hover.css"/>
    </head>
    <body>
        
        <jsp:include page="/template/body_top.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        
        <!-- Metacatalogue Top Bar : START -->
        <div style="border: 1px solid gray; border-radius: 4px; padding:6px 0px 6px 10px; margin: 0 20px 20px 20px; background-color: #E6F3F7">            
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Advanced Search - MicroCT Specimen Results
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
                    <img src="${baseUrl}/images/refine.png" class="my-speed-button-selected" title="Advanced Search">
                </a>    
                <a href="${baseUrl}/">
                    <img src="${baseUrl}/images/search.png" class="my-speed-button" title="Basic Search">
                </a>
            <div style="clear: both"></div>
        </div>     
        <!-- Metacatalogue Top Bar : END -->
        
        <div class="results_wrapper">
            <h3>MicroCT Specimen Information Found</h3>
            <table class="footable table table-bordered" >
                <thead>
                    <th>Row</th>
                    <th>Species</th>                    
                    <th>Provider</th>
                    <th>Specimen ID</th> 
                    <th>Specimen</th> 
                    <th data-toggle="true"></th>
                    <!--<th data-hide="all">Dataset Title</th>-->
                    <th data-hide="all">Collection</th>
                    <th data-hide="all">Institution</th>   
                    <th data-hide="all">Description</th>            
                    <th data-hide="all">Dimension</th>     
                    <th data-hide="all">Dimension Unit</th> 
                    <th data-hide="all">Dimension Value</th> 
                </thead>
                <tbody>
                    <c:forEach items="${results}" var="item" varStatus="status">
                        <tr>
                            <td><strong>${(page-1)*rpp + status.count}</strong></td>
                            <td style="text-align: left">
                                <span class="hovertext" data-hover="The lowest taxonomic name to which the specimen has been identified">
                                    ${item.getSpeciesName()}&nbsp;
                                </span>
                                <a href="${baseUrl}/search/browse?uri=${item.getSpeciesURI()}"><img src="../../images/list_view.png" title="Show with triple-browser"></img></a>
                            </td>
                            <td style="text-align: left">
                                <span class="hovertext" data-hover="The person who provided the specimen">
                                    ${item.getProviderName()}
                                </span>
                            </td>
                            <td style="text-align: left">
                                <span class="hovertext" data-hover="A unique identifier for the specimen in the format: mCT0000x (where x = incrementing number, always with preceding zeros)">
                                    ${item.getSpecimenID()}
                                </span>
                            </td>    
                            <td style="text-align: left">
                                <span class="hovertext" data-hover="Original label on specimen vial. If the label does not exist the corresponding unique code is shown">
                                    ${item.getSpecimenName()}
                                </span>
                            </td>
                            <td><span class="footable-toggle"></span> More info</td>
                            <!--<td>${item.getDatasetName()}</td>-->
                            <td>
                                <span class="hovertext" data-hover="Original collection code of the specimen">
                                    ${item.getCollectionName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The institution which provided the specimen">
                                    ${item.getInstitutionName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="A verbatim description of the specimen, which allows to understand the nature of the specimen at a glance">
                                    ${item.getDescription()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The type of measured dimension of the specimen">
                                    ${item.getDimensionName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The unit of the measured dimension of the specimen">
                                    ${item.getDimensionUnit()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The value of the measured dimension of the specimen">
                                    ${item.getDimensionValue()}
                                </span>
                            </td>
                        <tr/>
                    </c:forEach>
                </tbody>
            </table>
            
            <c:if test = "${lastPage != 1}">                                        
                <nav>
                    <ul class="pagination">
                        <li <c:if test = "${!leftArrow}">class='disabled'</c:if> >
                            <a href="${baseUrl}/search/advanced/microct_specimen?species=${species}&specimen=${specimen}&collection=${collection}&provider=${provider}&page=${page-1}" aria-label="Previous">
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
                                        <li><a href="${baseUrl}/search/advanced/microct_specimen?species=${species}&specimen=${specimen}&collection=${collection}&provider=${provider}&page=${loop.index}">${loop.index}</a></li>
                                    </c:if>                                                                      
                                </c:otherwise>
                            </c:choose>                        
                        </c:forEach>
                        <c:if test = "${rightArrow}">
                            <li>
                                <a href="${baseUrl}/search/advanced/microct_specimen?species=${species}&specimen=${specimen}&collection=${collection}&provider=${provider}&page=${page+1}" aria-label="Next">
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
