
    <div class="row">
        <div class="col-md-12">
            <div class="search_header_bar">
                Update Dataset Description
            </div>
        </div>
    </div>
    <div class="row form-group">
        <ex:Select dLen="6" lLen="4" fLen="6" fName="dataset_to_edit" fTitle="Select dataset" fReq="false">
            No dataset selected,${userDatasetListString}
        </ex:Select>                                 
    </div>
        
    <form method="post" id="edit_description_form" class="form-horizontal" action="${baseUrl}/publish/edit_description" enctype="multipart/form-data">
        <div class="row form-group">
                <div class="col-md-12">
                    <label for="area1" class="col-sm-2 control-label" style="color: #993300">Dataset Identity</label>                               
                </div>
        </div>
        <div class="row form-group">
                <ex:TextField dLen="4" lLen="6" fLen="6" fName="dataset_id2" fTitle="Dataset ID" fReq="false" />
                <ex:SelectList dLen="8" lLen="6" fLen="6" fName="parent_dataset_name2" fTitle="Parent Dataset Name" fReq="false">
                    ${datasetListString}
                </ex:SelectList>                            
        </div>
        <div class="row form-group">
            <ex:TextField dLen="12" lLen="2" fLen="10" fName="dataset_name2" fTitle="Dataset Name" fReq="true" fReadonly="true"/>                        
        </div>
        <div class="row form-group">
            <ex:Textarea dLen="12" lLen="2" fLen="10" fName="description2" fTitle="Description" fReq="true" />                       
        </div>        
        <div class="row form-group">
            <ex:Datetime dLen="6" lLen="4" fLen="6" fName="publication_date2" fTitle="Publication Date" fReq="false" /> 
            <ex:Datetime dLen="6" lLen="6" fLen="6" fName="creation_date2" fTitle="Creation Date Date" fReq="false" /> 				
        </div> 
        <div class="row form-group">
            <ex:Select dLen="6" lLen="4" fLen="6" fName="dataset_type2" fTitle="Type of dataset" fReq="false">
                Common Names Dataset, Environmental Dataset, Genetics Dataset, Identification Dataset, MicroCT Dataset, Morphological Characteristics Dataset, Morphometrics Dataset, Occurrence Dataset, Scientific Naming Dataset, Synonyms Dataset, Specimen Info Dataset, Specimen Collections Dataset, Taxonomy Dataset, Temporary Aggregates Dataset
            </ex:Select>                                 
        </div>				
        <div class="row form-group">
                <div class="col-md-12">
                        <!-- A label for the line (optional) -->
                        <label for="" class="col-sm-2 control-label">Dataset Logo:</label>
                        <div class="col-sm-2">
                                <!--  The file selector -->
                                <span class="btn btn-default btn-file" style="width:100%">
                                        Select a file...
                                        <!--  In case we allow multiple files to be uploaded
                                                  <input type="file" name="file[]" multiple=""> 
                                        -->
                                        <input type="file" name="logo2">
                                </span>
                        </div>
                        <div class="col-sm-8" id="files_to_upload">
                                <!--  A field to display the selected file	 -->
                                <input type="text" name="selected_file2" class="form-control" disabled>
                        </div>	
                </div>								
        </div>
        <div class="row form-group">
            <ex:TextField dLen="12" lLen="2" fLen="10" fName="access_method2" fTitle="Access Method" fReq="false"/>                                                
        </div>
        <div class="row form-group">
            <div class="col-md-12">
                <label for="area1" class="col-sm-2 control-label" style="color: #993300">Dataset People</label>
            </div>
        </div>
        <div class="row form-group">
            <ex:SelectList dLen="6" lLen="4" fLen="8" fName="owner2" fTitle="Owner" fReq="true">
                ${actorListString}
            </ex:SelectList>  
            <ex:SelectList dLen="6" lLen="4" fLen="8" fName="creator2" fTitle="Creator" fReq="true">
                ${actorListString}
            </ex:SelectList>                         
        </div>

        <div class="row form-group">
             <ex:SelectList dLen="6" lLen="4" fLen="8" fName="curator2" fTitle="Curator" fReq="true">
                ${actorListString}
            </ex:SelectList>  
            <ex:TextField dLen="6" lLen="4" fLen="8" fName="curator_email2" fTitle="Curator E-mail" fReq="true"/>                    
        </div>
        <div class="row form-group">
            <ex:SelectListMulti dLen="12" lLen="2" fLen="10" fName="contributors2" fTitle="Contributors" fReq="false">
                ${actorListString}
            </ex:SelectListMulti>                  
        </div>
        <div class="row form-group">
            <ex:TextField dLen="6" lLen="4" fLen="8" fName="publisher2" fTitle="Publisher" fReq="false"/>                       

        </div>
        <div class="row form-group">
                <div class="col-md-12">
                        <label for="area1" class="col-sm-2 control-label" style="color: #993300">Ownership and rights</label>
                </div>
        </div>
        <div class="row form-group">
             <ex:SelectList dLen="6" lLen="4" fLen="8" fName="keeper2" fTitle="Hosting Institution" fReq="false">
                ${actorListString}
            </ex:SelectList>  
            <ex:TextField dLen="6" lLen="4" fLen="8" fName="located_at2" fTitle="Located at" fReq="false"/>                         
        </div>
        <div class="row form-group">	
            <ex:Select dLen="6" lLen="4" fLen="8" fName="rights2" fTitle="Rights" fReq="true">
                Creative Commons Zero, Creative Commons By
            </ex:Select>
            <ex:SelectList dLen="6" lLen="4" fLen="8" fName="rights_holder2" fTitle="Rights Holder" fReq="true">
                ${actorListString}
            </ex:SelectList>	                        			
        </div>
        <div class="row form-group">
            <ex:Datetime dLen="6" lLen="4" fLen="6" fName="embargo_from2" fTitle="Embargo From" fReq="false" /> 
            <ex:Datetime dLen="6" lLen="4" fLen="6" fName="embargo_to2" fTitle="Embargo To" fReq="false" />                    
        </div> 	
        <div style="text-align: center;  margin-top: 20px">
            <button type="submit" class="btn btn-default" id="edit_submit_button" disabled>Submit</button>
        </div>
    </form>    

    <img src="${baseUrl}/images/loading.gif" style="display:none" id="loading-image" />
        
<script type="text/javascript">
    
    // Disable until they have implemented in metadata catalogue
    $('#embargo_from2').attr('disabled','disabled');
    $('#embargo_to2').attr('disabled','disabled');
    $('input[name="logo2"]').attr('disabled','disabled');

    // Reset dataset name dropdown
    $("#dataset_to_edit")[0].selectedIndex = 0;

    $("#dataset_to_edit").change(function(event){
        
        if($(this).val() != 'No dataset selected'){
            var targetUrl = "${baseUrl}/publish/get_dataset";
            var postData = { 
                dataset_name: $(this).val()
            };
            
            $('#loading-image').center().show();
            $.ajax(
            {
                url : targetUrl,
                type: "POST",
                data : postData,
                dataType : 'json',
                success:function(data, textStatus, jqXHR) 
                {
                    if(data.found == 'no'){
                        alert('A dataset with that name was not found!');
                        $('#edit_submit_button').prop('disabled',true);
                    } else {
                        $('#dataset_id2').val(data.datasetId);
                        $('#dataset_name2').val(data.datasetName);
                        $('#parent_dataset_name2').val(data.parentDatasetName);
                        $('#access_method2').val(data.accessMethod);
                        $('#rights2').val(data.accessRights);
                        $('#curator_email2').val(data.contactPoint);
                        $('#creator2').val(data.creator);
                        $('#curator2').val(data.curator);
                        $('#keeper2').val(data.keeper);
                        $('#located_at2').val(data.location);
                        $('#description2').val(data.description);
                        $('#owner2').val(data.owner);
                        $('#publisher2').val(data.publisher);
                        $('#rights_holder2').val(data.rightsHolder);
                        $('#creation_date2').val(data.creationDate);
                        $('#contributors2').val(data.contributors);
                        $('#publication_date2').data("DateTimePicker").date(data.publicationDate);
                        $('#creation_date2').data("DateTimePicker").date(data.creationDate);
                        
                        $('#rights2 option').filter(function() { 
                            return ($(this).text() == data.accessRights); //To select Blue
                        }).prop('selected', true);   
                        
                        $('#edit_submit_button').prop('disabled',false);
                    }
                    $('#loading-image').hide();
                },
                error: function(jqXHR, textStatus, errorThrown) 
                {
                    switch (jqXHR.status) {
                        case 400:
                            alert('Loading dataset failed! Error: 400');
                            break;
                         case 401: // Unauthorized access
                            alert('Loading dataset failed! Unauthorized access!');
                            break;
                         case 500: // Unexpected error
                            alert('Loading dataset failed due to an unexpected error!');
                            break;
                    }
                    $('#edit_submit_button').prop('disabled',true);
                    $('#loading-image').hide();
                },
                complete: function(){
                    $('#loading-image').hide();
                }
            });
        }                
        
        var frmValidator2 = new Validator("edit_description_form");
        frmValidator2.addValidation("dataset_id2","maxlen=7","Dataset ID must be 7 characters at most");
        frmValidator2.addValidation("dataset_name2","req","This field is required");
        frmValidator2.addValidation("owner2","req","This field is required");
        frmValidator2.addValidation("curator2","req","This field is required");
        frmValidator2.addValidation("curator_email2","req","This field is required")
        frmValidator2.addValidation("creator2","req","This field is required");
        frmValidator2.addValidation("rights_holder2","req","This field is required");                        
        // Custom validation function (pass the function name as is , not as a string)
        frmValidator2.setAddnlValidationFunction(unique_datatset_name); 
        
    });

</script>
