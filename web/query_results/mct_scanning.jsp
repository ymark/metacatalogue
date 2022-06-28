<%-- 
    Document   : occurences
    Created on : 18 Μαϊ 2015, 10:26:07 πμ
    Author     : Alexandros
--%>

<%@page import="eu.lifewatch.core.model.Pair"%>
<%@page import="eu.lifewatch.core.model.MicroCTScanningStruct"%>
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
                Advanced Search - MicroCT Scanning Results
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
            <h3>MicroCT Scanning Information Found</h3>
            <table class="footable table table-bordered" >
                <thead>
                    <th>Row</th>
                    <th><span class="hovertext" data-hover="Hello, this is the tooltip">Scan ID </span></th>
                    <th>Specimen ID</th>
                    <th>Specimen Name</th>
                    <th data-toggle="true"></th>
                    <th data-hide="all">Enhancement Contrast Method</th>
                    <th data-hide="all">Filter</th>
                    <th data-hide="all">Protocol</th>
                    <th data-hide="all">Preparation Date/Time</th>
                    <th data-hide="all">Preparation Notes</th>
                    <th data-hide="all">Scope of Scan</th>
                    <th data-hide="all">Sample holder</th>
                    <th data-hide="all">Scanning medium</th>
                    <th data-hide="all">Scanned part</th>
                    <th data-hide="all">Scanned by</th>
                    <th data-hide="all">Scan date</th>
                    <th data-hide="all">Scan duration</th>
                    <th data-hide="all">Instrument</th>
                    <th data-hide="all">Voltage (kV)</th>
                    <th data-hide="all">Current (uA)</th>
                    <th data-hide="all">Zoom (um)</th>
                    <th data-hide="all">Camera resolution</th>
                    <th data-hide="all">Averaging</th>
                    <th data-hide="all">Random movement</th>
                    <th data-hide="all">Scan (360 or 180)</th>
                    <th data-hide="all">Exposure time (ms)</th>
                    <th data-hide="all">Oversize settings</th>
<!--                    <th data-hide="all">File location</th>-->
                    <th data-hide="all">Collection code</th>
                    <th data-hide="all">Specimen provider</th>
                    <th data-hide="all">Specimen provider institute</th>
                    <th data-hide="all">Specimen description</th>
                    <th data-hide="all">Material</th>
                    <th data-hide="all">Scientific name</th>
                    <th data-hide="all">Taxonomic group</th>
                    <th data-hide="all">Specimen size (mm)</th>
                    <th data-hide="all">Fixation type</th>
                    <th data-hide="all">Storage place</th>
                </thead>
                <tbody>
                    <c:forEach items="${results}" var="item" varStatus="status">
                        <tr>
                            <td><strong>${(page-1)*rpp + status.count}</strong></td>
                            <td>
                                <span class="hovertext" data-hover="A unique identifier for the specimen in the format: mCT0000x (where x = incrementing number, always with preceding zeros)">
                                    ${item.getScanningLabel()}&nbsp;
                                </span>
                                <a href="${baseUrl}/search/browse?uri=${item.getScanningURI()}"><img src="../../images/list_view.png" title="Show with triple-browser"></img></a>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="A unique code of the format scan0000x (where x=incrementing number)">
                                    ${item.getSpecimen().getSpecimenID()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Original label on specimen vial. If the label does not exist the corresponding unique code is shown">
                                    ${item.getSpecimen().getSpecimenName()}
                                </span>
                            </td>
                            <td><span class="footable-toggle"></span> More info</td>
                            <td>
                                <span class="hovertext" data-hover="Short name of chemical used">
                                    ${item.getContrastMethod()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Description of the filter used">
                                    ${item.getFilter()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Detailed protocol of the contrast enhancement method, can be a reference to a paper">
                                    ${item.getProtocol()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Date/Time range of the preparation in the form: [Begin Date/Time  - End Date/Time]">
                                    ${item.getPreparationDateTime()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Any other notes on the specimen preparation process">
                                    ${item.getDescription()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Description of the scope of scan">
                                    ${item.getScopeOfScan()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="A description of the sample holder">
                                    ${item.getSampleHolder()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The medium that surrounds the sample">
                                    ${item.getScanningMedium()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="(Body) part of the specimen that has been scanned">
                                    ${item.getScannedPart()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The person who performed the scan">
                                    ${item.getActorName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Date of the begin of the scanning process">
                                    ${item.getScanDate()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The duration of the scan in the format HH:MM">
                                    ${item.getScanningDuration()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The instrument on which the scan was performed. Usually this will be SkyScan 1172">
                                    ${item.getDeviceName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The voltage in kilovolt (kV)">
                                    ${item.getVoltage()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The current in μAmpere (uA)">
                                    ${item.getCurrent()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Resolution of the scan in μm (Zoom level)">
                                    ${item.getZoom()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Camera resolution settings">
                                    ${item.getCameraResolution()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Frame averaging value">
                                    ${item.getAveraging()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Random movement value">
                                    ${item.getRandomMovement()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="360° or 180° scan">
                                    ${item.getScanDegrees()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Exposure time in milliseconds. This can be either seen from the flat field settings or from the log file of the scan">
                                    ${item.getExposureTime()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Number of oversize parts (vertical & horizontal)">
                                    ${item.getOversizeSettings()}
                                </span>
                            </td>
                            <!--<td>${item.getFileLocation()}</td>-->
                            <td>
                                <span class="hovertext" data-hover="Original collection code of the specimen">
                                    ${item.getSpecimen().getCollectionName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The person who provided the specimen">
                                    ${item.getSpecimen().getProviderName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The institution which provided the specimen">
                                    ${item.getSpecimen().getInstitutionName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="A verbatim description of the specimen, which allows to understand the nature of the specimen at a glance">
                                    ${item.getSpecimen().getDescription()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The actual material of the specimen">
                                    ${item.getSpecimen().getMaterial()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The lowest taxonomic name to which the specimen has been identified">
                                    ${item.getSpecimen().getSpeciesName()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="The taxonomic group to which the specimen has been identified">
                                    ${item.getSpecimen().getTaxonomicGroup()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Max. length of specimen. If difficult to measure, it is an approximation">
                                    ${item.getSpecimen().getDimensionValue()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Original fixation type of the specimen">
                                    ${item.getSpecimen().getFixationType()}
                                </span>
                            </td>
                            <td>
                                <span class="hovertext" data-hover="Final storage place of the specimen after scan has finished">
                                    ${item.getSpecimen().getStoragePlace()}
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
                            <a href="${baseUrl}/search/advanced/microct_scanning?species=${species}&specimen=${specimen}&device=${device}&contrast=${contrast}&page=${page-1}" aria-label="Previous">
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
                                        <li><a href="${baseUrl}/search/advanced/microct_scanning?species=${species}&specimen=${specimen}&device=${device}&contrast=${contrast}&page=${loop.index}">${loop.index}</a></li>
                                    </c:if>                                                                      
                                </c:otherwise>
                            </c:choose>                        
                        </c:forEach>
                        <c:if test = "${rightArrow}">
                            <li>
                                <a href="${baseUrl}/search/advanced/microct_scanning?species=${species}&specimen=${specimen}&device=${device}&contrast=${contrast}&page=${page+1}" aria-label="Next">
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
