 <div role="tabpanel" class="tab-pane active" id="basicSearch">
        <div class="row">
            <div class="col-sm-6">
                <div class="row">
                    <div class="col-md-12">
                        <div class="search_header_bar">
                            Search Dataset Description
                        </div>
                    </div>
                </div>
                <form class="form-inline" action="search/directory" method="get">  
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="datasetName" class="control-label">Dataset Name</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="datasetName" name="datasetName" value="">
                        </div>    
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="owner" class="control-label info-label" data-container="body" data-toggle="popover" data-placement="left" data-content="">Owner</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="owner" name="owner" value="">
                        </div>                                    
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="datasetUri" class="control-label">Dataset URI</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="datasetUri" name="datasetUri" value="">
                        </div> 
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="location" class="control-label">Location</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="location" name="location" value="">
                        </div> 
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="taxonomicCoverage" class="control-label">Taxonomic Coverage</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="taxonomicCoverage" name="taxonomicCoverage" value="">
                        </div> 
                    </div>
                    <div class="row">                                    
                        <div class="col-md-4">
                            <label for="dateCoverage" class="control-label">Date</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="dateCoverage" name="dateCoverage" value="">
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <label for="datasetType" class="control-label">Dataset Type</label>
                        </div>
                        <div class="col-md-8">
                            <select class="form-control" name="datasetType">
                                <option value="" selected>Not defined</option> 
                                <option>Common Names Dataset</option>
                                <option>Identification Dataset</option>
                                <option>Genetics Dataset</option>                                   
                                <option>MicroCT Dataset</option>
                                <option>Morphological Characteristics Dataset</option> 
                                <option>Morphometrics Dataset</option>                                                                                              
                                <option>Occurrence Dataset</option> 
                                <option>Scientific Naming Dataset</option> 
                                <option>Specimen Info Dataset</option> 
                                <option>Specimen Collections Dataset</option> 
                                <option>Synonyms Dataset</option> 
                                <option>Taxonomy Dataset</option>                                  
                                <option>Temporary Aggregates Dataset</option>                                                                                                
                            </select>
                        </div>              
                    </div>
                    <div class="row">
                        <div class="col-md-12" style="text-align: right">
                            <button type="submit" class="btn btn-default">Search</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-sm-6">
                                               
            </div>                            
        </div>
</div>