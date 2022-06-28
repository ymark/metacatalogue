<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Services - Search</title>      
        <jsp:include page="/template/head.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        <script type="text/javascript" src="${baseUrl}/js/toastr.js"></script>
        <link rel="stylesheet" href="${baseUrl}/css/toastr.css" /> 
        <link rel="stylesheet" href="${baseUrl}/css/custom.css" />           
    </head>
    <body>     
        <jsp:include page="/template/body_top.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
        <!-- Metacatalogue Top Bar : START -->
        <div style="border: 1px solid gray; border-radius: 4px; padding:6px 0px 6px 10px; margin: 0 20px 20px 20px; background-color: #E6F3F7">            
            <div style="float:left; font-size: 30px; margin-left: 30px; margin-top: 4px">
                Advanced Search
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
               

        <div role="tabpanel" class="tab-pane" id="advancedSearch">
                    <div class="container" style="width: 100%">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="row">
                                    <form class="form-horizontal">`
                                        <div class="form-group">
                                            <label for="searchType" class="col-sm-4 control-label">Select search type</label>
                                            <div class="col-sm-5">
                                            <select class="form-control" id="searchType" name="searchType">
                                                <option value="occurence" selected>Occurrence</option> 
                                                <option value="common_name">Common name</option> 
                                                <option value="environmental">Environmental</option> 
                                                <option value="genetics">Genetics</option> 
                                                <option value="identification">Identification</option>
                                                <option value="measurement">Morphometrics</option> 
                                                <option value="microct_specimen">MicroCT Specimen</option> 
                                                <option value="microct_scanning">MicroCT Scanning</option>
<!--                                                <option value="microct_reconstruction">MicroCT Reconstruction</option>
                                                <option value="microct_postprocessing">MicroCT Post Processing</option>-->
                                                <option value="morphometric">Morphological Characteristics</option>
                                                <option value="temp_stats">Occurrence Statistics</option>
                                                <option value="scientific_name">Scientific Name</option> 
                                                <option value="specimen">Specimen</option> 
                                                <option value="specimen_collection">Specimen Collection</option>
                                                <option value="statistical">Statistical</option> 
                                                <option value="synoym">Synonyms</option> 
                                                <option value="taxonomy">Taxonomy</option>                                                 
                                            </select>
                                            </div>
                                        </div>                                    
                                    </form>
                                </div>                                                               
                            </div>
                            <div class="col-md-6">  
                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="search_header_bar" id="advanced_form_header">
                                            Occurrence Search Form
                                        </div>
                                    </div>
                                </div>
                                
                                <form id="occurence_form" class="form-horizontal" action="../search/advanced/occurence"  method="get">
                                    <div class="form-group">
                                        <label for="scientificName" class="col-sm-4 control-label">Scientific Name</label>
                                        <div class="col-sm-5">
                                            <input type="text" name="scientificName" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="location" class="col-sm-4 control-label">Location</label>
                                        <div class="col-sm-5">
                                            <input type="text" name="location" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="year" class="col-sm-4 control-label">Year</label>
                                        <div class="col-sm-5">
                                            <input type="text" name="year" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-4 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>                                                                  
                                
                                <form id="temp_stats_form" class="form-horizontal" action="../search/advanced/temp_stats" method="get" style="display: none"> 
                                    <div class="form-group">
                                        <label for="scientificName" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="scientificName" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="location" class="col-sm-3 control-label">Location</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="location" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="year" class="col-sm-3 control-label">Year</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="year" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="number" class="col-sm-3 control-label">Number</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="number" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>  
                                
                                <form id="taxonomy_form" class="form-horizontal" action="../search/advanced/taxonomy" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Species</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="genus" class="col-sm-3 control-label">Genus</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="genus" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="class_" class="col-sm-3 control-label">Class</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="class_" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="family" class="col-sm-3 control-label">Family</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="family" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="phylum" class="col-sm-3 control-label">Phylum</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="phylum" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="kingdom" class="col-sm-3 control-label">Kingdom</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="kingdom" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>  
                                
                                <form id="common_name_form" class="form-horizontal" action="../search/advanced/common_name" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Species</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="cname" class="col-sm-3 control-label">Common Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="cname" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="place" class="col-sm-3 control-label">Place</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="place" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="language" class="col-sm-3 control-label">Language</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="language" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>  
                                
                                <form id="synoym_form" class="form-horizontal" action="../search/advanced/synoym" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Species</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="sname" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="sname" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="synonym" class="col-sm-3 control-label">Synonym</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="synonym" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>  
                                
                                <form id="scientific_name_form" class="form-horizontal" action="../search/advanced/scientific_name" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="scientificName" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="scientificName" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Species</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="date" class="col-sm-3 control-label">Date</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="date" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="actor" class="col-sm-3 control-label">Authority</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="actor" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form> 
                                
                                <form id="identification_form" class="form-horizontal" action="../search/advanced/identification" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="place" class="col-sm-3 control-label">Location</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="place" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="actor" class="col-sm-3 control-label">Identified By</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="actor" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="date" class="col-sm-3 control-label">Date</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="date" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="individual" class="col-sm-3 control-label">Individual</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="individual" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form> 
                                
                                <form id="measurement_form" class="form-horizontal" action="../search/advanced/measurement" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="specimen" class="col-sm-3 control-label">Specimen ID</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="specimen" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="dimension" class="col-sm-3 control-label">Dimension</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="dimension" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form> 
                                
                                <form id="specimen_form" class="form-horizontal" action="../search/advanced/specimen" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="specimen" class="col-sm-3 control-label">Specimen ID</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="specimen" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="collection" class="col-sm-3 control-label">Collection</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="collection" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form> 
                                
                                <form id="microct_specimen_form" class="form-horizontal" action="../search/advanced/microct_specimen" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="specimen" class="col-sm-3 control-label">Specimen ID</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="specimen" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="collection" class="col-sm-3 control-label">Collection</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="collection" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="provider" class="col-sm-3 control-label">Provider</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="provider" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>
                                
                                <form id="microct_scanning_form" class="form-horizontal" action="../search/advanced/microct_scanning" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Species</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="filter" class="col-sm-3 control-label">Filter</label>
                                        <div class="col-sm-4">
                                            <select class="form-control" name="filter">
                                                <option value="" selected>Not defined</option>
                                                <option>Al 0.5 mm</option>
                                                <option>Al + Cu</option>
                                                <option>Aluminium foil, 1 layer</option>
                                                <option>Aluminium foil, 2 layers</option>
                                                <option>None</option>
                                                <option>Unknown</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="contrast" class="col-sm-3 control-label">Enhancement Contrast Method</label>
                                        <div class="col-sm-4">
                                            <select class="form-control" name="contrast">
                                                <option value="" selected>Not defined</option>
                                                <option>HMDS</option>
                                                <option>HMDS and PTA</option>
                                                <option>Iodine</option>
                                                <option>Iodine and HMDS</option>
                                                <option>PMA</option>
                                                <option>PTA</option>
                                                <option>PTA and IODINE</option>
                                                <option>None</option>
                                                <option>Unknown</option>
                                            </select>
                                            <!--<input type="text" name="contrast" class="form-control">-->
                                        </div>
                                    </div>
<!--                                    <div class="form-group">
                                        <label for="scanid" class="col-sm-3 control-label">Scan ID</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="scanid" class="form-control">
                                        </div>
                                    </div>-->
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>
                                
<!--                                <form id="microct_reconstruction_form" class="form-horizontal" action="../search/advanced/microct_reconstruction" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="input" class="col-sm-3 control-label">Input</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="input" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="specimen" class="col-sm-3 control-label">Specimen</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="specimen" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Species</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>
                                
                                <form id="microct_postprocessing_form" class="form-horizontal" action="../search/advanced/microct_postprocessing" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="input" class="col-sm-3 control-label">Input</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="input" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="specimen" class="col-sm-3 control-label">Specimen</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="specimen" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Species</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>-->
                                
                                <form id="genetics_form" class="form-horizontal" action="../search/advanced/genetics" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="species" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="species" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="place" class="col-sm-3 control-label">Place</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="place" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="dataset" class="col-sm-3 control-label">Dataset</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="dataset" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="sample" class="col-sm-3 control-label">Sample</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="sample" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>                                
                                
                                <form id="specimen_collection_form" class="form-horizontal" action="../search/advanced/specimen_collection" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="collection" class="col-sm-3 control-label">Collection</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="collection" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="owner" class="col-sm-3 control-label">Owner</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="owner" class="form-control">
                                        </div>
                                    </div>                            
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>
                                
                                <form id="morphometric_form" class="form-horizontal" action="../search/advanced/morphometric" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="scientificName" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="scientificName" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="morphAttribute" class="col-sm-3 control-label">Attribute</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="morphAttribute" class="form-control">
                                        </div>
                                    </div>                            
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>
                                
                                <form id="environmental_form" class="form-horizontal" action="../search/advanced/environmental" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="dimension" class="col-sm-3 control-label">Dimension</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="dimension" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="place" class="col-sm-3 control-label">Place</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="place" class="form-control">
                                        </div>
                                    </div>                            
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>
                                
                                <form id="statistical_form" class="form-horizontal" action="../search/advanced/statistical" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="dimension" class="col-sm-3 control-label">Dimension</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="dimension" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="scientificName" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="scientificName" class="form-control">
                                        </div>
                                    </div>                            
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>
                                
                                <form id="all_about_form" class="form-horizontal" action="../search/advanced/all_about" method="get" style="display: none">
                                    <div class="form-group">
                                        <label for="scientificName" class="col-sm-3 control-label">Scientific Name</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="scientificName" class="form-control">
                                        </div>
                                    </div>                            
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button type="submit" class="btn btn-default">Search</button>
                                        </div>
                                    </div>
                                </form>
                                
                            </div>
                        </div>
                    </div>
                </div>
<script type="text/javascript">
            
            $('#advancedSearchNav').on('click',function(){
                $('#searchType').val('occurence');
                changeForm();
            });
            
            var searchType = "occurence";
            
            // This event is not fired if the same option gets selected
            $('#searchType').change(changeForm);
            
            function changeForm(){
                var headerTitle = "";
                
                // Retrieve the new search option
                newSearchType = $('#searchType').val();
                
                // Hide the previous search form
                $('#'+searchType+'_form').hide();
                
                // Save the new search option
                searchType = newSearchType;
                
                // 
                switch(newSearchType){
                    case 'occurence':
                        headerTitle = "Occurrence Search Form";
                        break;
                    case 'temp_stats':
                        headerTitle = "Temp Stats Search Form";
                        break;
                    case 'taxonomy':
                        headerTitle = "Taxonomy Search Form";
                        break;
                    case 'common_name':
                        headerTitle = "Common Name Search Form";
                        break;
                    case 'synoym':
                        headerTitle = "Synonym Search Form";
                        break;
                    case 'scientific_name':
                        headerTitle = "Scientific Name Search Form";
                        break;
                    case 'identification':
                        headerTitle = "Identification Search Form";
                        break;
                    case 'measurement':
                        headerTitle = "Measurement Search Form";
                        break;
                    case 'specimen':
                        headerTitle = "Specimen Search Form";
                        break;
                    case 'microct_specimen':
                        headerTitle = "MicroCT Specimen Search Form";
                        break;
                    case 'microct_scanning':
                        headerTitle = "MicroCT Scanning Search Form";
                        break;
                    case 'microct_reconstruction':
                        headerTitle = "MicroCT Reconstruction Search Form";
                        break;
                    case 'microct_postprocessing':
                        headerTitle = "MicroCT Postprocessing Search Form";
                        break;
                    case 'genetics':
                        headerTitle = "Genetics Search Form";
                        break;
                    case 'specimen_collection':
                        headerTitle = "Specimen Collection Search Form";
                        break;
                    case 'morphometric':
                        headerTitle = "Morphometric Search Form";
                        break;
                    case 'environmental':
                        headerTitle = "Environmental Search Form";
                        break;
                    case 'statistical':
                        headerTitle = "Statistical Search Form";
                        break;                    
                }
                
                $('#advanced_form_header').html(headerTitle);
                $('#'+newSearchType+'_form').show();
            }
            
            $(function () {
                $('[data-toggle="tooltip"]').tooltip();
                $('[data-toggle="popover"]').popover();               
            })
            
            <c:forEach items="${tooltips}" var="tooltip">
                $('label[for="${tooltip.key}"]').attr("data-content"," ${tooltip.value}");
            </c:forEach>
            
        </script>    
        <jsp:include page="/template/body_bottom.jsp"><jsp:param name="baseUrl" value="${baseUrl}" /></jsp:include>
    </body>
</html>