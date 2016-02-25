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
            <div style="float: left">
                <img src="${baseUrl}/images/data_services.png" style="width: 50px">
            </div>
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Dataset Catalogue Service
            </div>
            <c:if test = "${canManage.equals('yes')}">
    
                <img src="${baseUrl}/images/search.png" class="my-speed-button-selected">
                <a href="${baseUrl}/publish">
                    <img src="${baseUrl}/images/edit.png" class="my-speed-button">
                </a>
            </c:if>            
            <div style="clear: both"></div>
        </div>     
        <!-- Metacatalogue Top Bar : END -->
        
        <div class="results_wrapper" id="results_wrapper_div">
            
            <div>
                <h3 style="float: left">Occurrences Information Found</h3>
                <div style="float: right; margin-top: 15px">
                    <input id="annoToggleButton" data-toggle="toggle" data-on="Annotation On" data-off="Annotation Off" type="checkbox">
                </div>
            </div>
            
            <table class="footable table table-bordered" >
                <thead>
                    <th>Row</th>
                    <th>Species</th>
                    <th>Country </th>
                    <th style="text-align: left">Date</th>                
                    <th>Related Dataset</th>
                    <th data-toggle="true"></th>
                    <th data-hide="all">Dataset Title</th>
                    <th data-hide="all">Occurrence Event ID</th>                
                    <th data-hide="all">Individual ID</th>
                    <th data-hide="all">Actor</th>
                    <th data-hide="all">Place</th>
                    <th data-hide="all">Water Area</th>
                    <th data-hide="all">Habitat</th>
                    <th data-hide="all">Equipment Type</th>
                    <th data-hide="all">Ecosystem</th>
                    <th data-hide="all">Description</th>
                    <th data-hide="all">Station URI</th>
                    <th data-hide="all">Station Notes</th>
                    <th data-hide="all">Bibliographic Citation</th>
                    <th data-hide="all">Sampling Protocol</th>
                    <th data-hide="all">Coordinates</th>
                </thead>
                <tbody>
                    <c:forEach items="${results}" var="item" varStatus="status">
                        <tr>
                            <td><strong>${(page-1)*rpp + status.count}</strong></td>
                            <td style="text-align: left"><a href="${baseUrl}/search/browse?uri=${item.getSpeciesURI()}">${item.getSpeciesName()}</a></td>
                            <td style="text-align: left"><a href="${baseUrl}/search/browse?uri=${item.getCountryURI()}">${item.getCountryName()}</a></td>
                            <td>${item.getTimeSpan()}</td>                        
                            <td><a href="${baseUrl}/search/directory?datasetName=&owner=&datasetURI=${item.getDatasetURI()}">View dataset</a></td>
                            <td><span class="footable-toggle"></span> More info</td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getDatasetURI()}">${item.getDatasetTitle()}</a></td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getOccurrenceEventURI()}">${item.getOccurrenceEvent()}</a></td>                        
                            <td><a href="${baseUrl}/search/browse?uri=${item.getIndividualURI()}">${item.getIndividualLabel()}</a></td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getActors().get(0).getKey().toString()}">${item.getActors().get(0).getValue().toString()}</a></td>                            
                            <td><a href="${baseUrl}/search/browse?uri=${item.getLocalityURI()}">${item.getLocalityName()}</a></td>                   
                            <td><a href="${baseUrl}/search/browse?uri=${item.getWaterAreaURI()}">${item.getWaterAreaName()}</a></td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getHabitatURI()}">${item.getHabitatName()}</a></td>      
                            <td><a href="${baseUrl}/search/browse?uri=${item.getEquipmentTypeURI()}">${item.getEquipmentTypeName()}</a></td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getEcosystemURI()}">${item.getEcosystemName()}</a></td>
                            <td>${item.getDescription()}</td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getStationURI()}">${item.getStationURI()}</a></td>
                            <td>${item.getStationNotes()}</td>                 
                            <td><a href="${baseUrl}/search/browse?uri=${item.getBibliographicCitationURI()}">${item.getBibliographicCitation()}</a></td>                       
                            <td><a href="${baseUrl}/search/browse?uri=${item.getSamplingProtocolURI()}">${item.getSamplingProtocol()}</a></td>
                            <td>${item.getCoordinates()}</td>
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
