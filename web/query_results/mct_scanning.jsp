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
        
        <div class="results_wrapper">
            <h3>MicroCT Scanning Information Found</h3>
            <table class="footable table table-bordered" >
                <thead>
                    <th>Row</th>
                    <th>Specimen</th>
                    <th>Device</th>
                    <th>Enhancement Method</th>
                    <th>Related Dataset</th>
                    <th data-toggle="true"></th>
                    <th data-hide="all">Dataset Title</th>                                  
                    <th data-hide="all">Scanning ID</th>
                    <th data-hide="all">Product</th>                                 
                    <th data-hide="all">Actor</th>
                    <th data-hide="all">Date</th>   
                    <th data-hide="all">Zoom</th>   
                    <th data-hide="all">Exposure Time</th>   
                    <th data-hide="all">Filter</th>   
                    <th data-hide="all">Voltage</th>   
                </thead>
                <tbody>
                    <c:forEach items="${results}" var="item" varStatus="status">
                        <% Pair products = ((MicroCTScanningStruct)pageContext.getAttribute("item")).getProducts().get(0); %>
                        <tr>
                            <td><strong>${(page-1)*rpp + status.count}</strong></td>
                            <td style="text-align: left"><a href="${baseUrl}/search/browse?uri=${item.getSpecimenURI()}">${item.getSpecimenName()}</a></td>
                            <td style="text-align: left"><a href="${baseUrl}/search/browse?uri=${item.getDeviceURI()}">${item.getDeviceName()}</a></td>
                            <td style="text-align: left">${item.getContrastMethod()}</td>         
                             <td><a href="${baseUrl}/search/directory?datasetName=&owner=&datasetURI=${item.getDatasetURI()}">View dataset</a></td>
                            <td><span class="footable-toggle"></span> More info</td>
                            <td><a href="${baseUrl}/search/browse?uri=${item.getDatasetURI()}">${item.getDatasetName()}</a></td>        
                            <td><a href="${baseUrl}/search/browse?uri=${item.getScanningURI()}">${item.getScanning()}</a></td>
                            <td><a href="${baseUrl}/search/browse?uri=<% out.print(products.getKey().toString()); %>"><% out.print(products.getValue().toString()); %></a></td>

                            <td><a href="${baseUrl}/search/browse?uri=${item.getActorURI()}">${item.getActorName()}</a></td>
                            <td>${item.getTimespan()}</td>    
                            <td>${item.getZoom()}</td>  
                            <td>${item.getExposureTime()}</td>  
                            <td>${item.getFilter()}</td>  
                            <td>${item.getVoltage()}</td>  
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
