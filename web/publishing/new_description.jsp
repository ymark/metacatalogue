    <div class="row">
            <div class="col-md-12">
                    <div class="search_header_bar">
                            New Dataset Description
                    </div>
            </div>
    </div>    		
    
    <c:forEach items="${newDescriptionFeedback}" var="entry">
        <div class="myalert alert-danger" role="alert"><strong>${entry.key}:</strong> ${entry.value.getErrorMessage()}</div>        
    </c:forEach>

    <form method="post" id="new_description_file_form" class="form-horizontal" action="${baseUrl}/publish/new_description_file" enctype="multipart/form-data">        
        
        <div class="row form-group">
                <div class="col-md-12">
                        <!-- A label for the line (optional) -->
                        <label for="" class="col-sm-2 control-label">Description File:</label>
                        <div class="col-sm-2">
                                <!--  The file selector -->
                                <span class="btn btn-default btn-file" style="width:100%">
                                        Select a file...
                                        <!--  In case we allow multiple files to be uploaded
                                                  <input type="file" name="file[]" multiple=""> 
                                        -->
                                        <input type="file" id="description_file" name="description_file">
                                </span>
                        </div>
                        <div class="col-sm-8" id="files_to_upload">
                                <!--  A field to display the selected file	 -->
                                <input type="text" name="selected_description_file" class="form-control" disabled>
                        </div>	                        
                </div>           
        </div>
        <div class="row form-group">                 
            <div class="col-md-12">
                <label class="col-sm-2 control-label" for="file_dataset_name">
                    Dataset Name
                    <ast>*</ast>
                </label>
                <div class="col-sm-10">
                    <table style='width: 100%'>
                        <tr>
                            <td><input id="file_dataset_name" class="form-control" type="text" value="" name="file_dataset_name"></td>
                            <td style='width:32px'><img src='${baseUrl}/images/check.png' id='check-dataset-name' title='check if dataset name is taken' class='icon-link'></td>
                        </tr>
                    </table>                                        
                </div>
            </div>         
        </div>
        <div style="text-align: center; margin-top: 20px">
            <button type="submit" class="btn btn-default">Upload</button>
        </div>
    </form>

    <form method="post" id="new_description_form" class="form-horizontal" action="${baseUrl}/publish/new_description" enctype="multipart/form-data">
        <div class="row form-group">
            <div class="col-md-12">
                <label for="area1" class="col-sm-2 control-label" style="color: #993300">Dataset Identity</label>                               
            </div>
        </div>
        <div class="row form-group">
            <ex:TextField dLen="4" lLen="6" fLen="6" fName="dataset_id" fTitle="Dataset ID" fReq="false" />
            <ex:SelectList dLen="8" lLen="6" fLen="6" fName="parent_dataset_name" fTitle="Parent Dataset Name" fReq="false">
                ${datasetListString}
            </ex:SelectList>                            
        </div>
        <div class="row form-group">
            <div class="col-md-12">
                <label class="col-sm-2 control-label" for="dataset_name">
                    Dataset Name
                    <ast>*</ast>
                </label>
                <div class="col-sm-10">
                    <table style='width: 100%'>
                        <tr>
                            <td><input id="dataset_name" class="form-control" type="text" value="" name="dataset_name"></td>
                            <td style='width:32px'><img src='${baseUrl}/images/check.png' id='check-dataset-name2' title='check if dataset name is taken' class='icon-link'></td>
                        </tr>
                    </table>                                        
                </div>
            </div>                  
        </div>
        <div class="row form-group">
            <ex:Textarea dLen="12" lLen="2" fLen="10" fName="description" fTitle="Description" fReq="false" />    
        </div>        
        <div class="row form-group">
            <ex:Datetime dLen="6" lLen="4" fLen="6" fName="publication_date1" fTitle="Publication Date" fReq="false" /> 
            <ex:Datetime dLen="6" lLen="6" fLen="6" fName="creation_date" fTitle="Creation Date Date" fReq="false" /> 				
        </div> 
        <div class="row form-group">
            <ex:Select dLen="6" lLen="4" fLen="6" fName="dataset_type1" fTitle="Type of dataset" fReq="false">
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
                                        <input type="file" id="logo" name="logo">
                                </span>
                        </div>
                        <div class="col-sm-8" id="files_to_upload">
                                <!--  A field to display the selected file	 -->
                                <input type="text" name="selected_file" class="form-control" disabled>
                        </div>	
                </div>								
        </div>
        <div class="row form-group">
            <ex:TextField dLen="12" lLen="2" fLen="10" fName="access_method" fTitle="Access Method" fReq="true"/>                                                
        </div>
        <div class="row form-group">
            <div class="col-md-12">
                <label for="area1" class="col-sm-2 control-label" style="color: #993300">Dataset People</label>
            </div>
        </div>
        <div class="row form-group">
            <ex:SelectList dLen="6" lLen="4" fLen="8" fName="owner" fTitle="Owner" fReq="true">
                ${actorListString}
            </ex:SelectList>  
            <ex:SelectList dLen="6" lLen="4" fLen="8" fName="creator" fTitle="Creator" fReq="false">
                ${actorListString}
            </ex:SelectList>        
        </div>

        <div class="row form-group">
             <ex:SelectList dLen="6" lLen="4" fLen="8" fName="curator" fTitle="Curator" fReq="true">
                ${actorListString}
            </ex:SelectList>  
            <ex:TextField dLen="6" lLen="4" fLen="8" fName="curator_email" fTitle="Curator E-mail" fReq="true"/>                    
        </div>
        <div class="row form-group">
            <ex:SelectListMulti dLen="12" lLen="2" fLen="10" fName="contributors" fTitle="Contributors" fReq="false">
                ${actorListString}
            </ex:SelectListMulti>                  
        </div>
        <div class="row form-group"> 
            <ex:SelectList dLen="6" lLen="4" fLen="8" fName="publisher" fTitle="Publisher" fReq="false">
                ${actorListString}
            </ex:SelectList>
        </div>
            
        <div class="row form-group">
                <div class="col-md-12">
                        <label for="area1" class="col-sm-2 control-label" style="color: #993300">Ownership and rights</label>
                </div>
        </div>
        <div class="row form-group">
             <ex:SelectList dLen="6" lLen="4" fLen="8" fName="keeper" fTitle="Hosting Institution" fReq="false">
                ${actorListString}
            </ex:SelectList>  
            <ex:TextField dLen="6" lLen="4" fLen="8" fName="located_at" fTitle="Located at" fReq="false"/>                         
        </div>
        <div class="row form-group">	
            <ex:Select dLen="6" lLen="4" fLen="8" fName="rights" fTitle="Rights" fReq="true">
                Creative Commons Zero, Creative Commons By
            </ex:Select>
            <ex:SelectList dLen="6" lLen="4" fLen="8" fName="rights_holder" fTitle="Rights Holder" fReq="true">
                ${actorListString}
            </ex:SelectList>	                        			
        </div>
        <div class="row form-group">
            <ex:Datetime dLen="6" lLen="4" fLen="6" fName="embargo_from1" fTitle="Embargo From" fReq="false" /> 
            <ex:Datetime dLen="6" lLen="4" fLen="6" fName="embargo_to1" fTitle="Embargo To" fReq="false" />                    
        </div> 	
        <div class="row form-group">
            <ex:SelectList dLen="6" lLen="4" fLen="8" fName="embargo_state" fTitle="Embargo State" fReq="false">
                On Embargo,Out Of Embargo,Unknown
            </ex:SelectList> 
        </div>
        <div style="text-align: center; margin-top: 20px">
            <button type="submit" class="btn btn-default">Submit</button>
        </div>
    </form>


<script type="text/javascript">

        // Disable until they have implemented in metadata catalogue
        $('#logo').attr('disabled','disabled');

        $("#new_description_form input[name='logo']").change(function(){
                // This is a loop that can be used in case there are many selected files
                for(var i=0; i< this.files.length; i++){
                        var file = this.files[i];
                        name = file.name.toLowerCase();	                        
                        $('#new_description_form input[name="selected_file"]').val(name);
                }
        });
        
        $("#new_description_file_form input[name='description_file']").change(function(){
                // This is a loop that can be used in case there are many selected files
                for(var i=0; i< this.files.length; i++){
                        var file = this.files[i];
                        name = file.name.toLowerCase();	                        
                        $('#new_description_file_form input[name="selected_description_file"]').val(name);
                }
        });
        
        $("#new_description_form input[name='embargo_state']").change(function(){
            if(($(this).val() == "Out Of Embargo")||($(this).val() == "Unknown")){
                $("#new_description_form input[name='embargo_from1']").prop('disabled',true);
                $("#new_description_form input[name='embargo_to1']").prop('disabled',true);
            } else {
                $("#new_description_form input[name='embargo_from1']").prop('disabled',false);
                $("#new_description_form input[name='embargo_to1']").prop('disabled',false);
            }
        });

        // Reset check-icon color if the dataset name in the field has changed
        $('#file_dataset_name').on('change paste keypress',function(){
            $('#check-dataset-name').attr('src',"${baseUrl}/images/check.png");
        });

        // Reset check-icon color if the dataset name in the field has changed
        $('#dataset_name').on('change paste keypress',function(){
            $('#check-dataset-name2').attr('src',"${baseUrl}/images/check.png");
        });

        // Check if the dataset name in the field is taken (in the database)
        $('#check-dataset-name').on('click',function(){
            var nameToCheck = $('#file_dataset_name').val();
            $.ajax({
                url : "${baseUrl}/helper/dataset_exists?name="+nameToCheck,
                type: "GET",
                dataType : 'json',
                success:function(data, textStatus, jqXHR) 
                {
                    if(data.found == 'yes'){
                        $('#check-dataset-name').attr("src","${baseUrl}/images/red-check.png");
                    } else {
                        $('#check-dataset-name').attr("src","${baseUrl}/images/green-check.png");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) 
                {
                    alert('Dataset name could not be validated!');  
                }
            });

        });
        
        // Check if the dataset name in the field is taken (in the database)
        $('#check-dataset-name2').on('click',function(){
            var nameToCheck = $('#datasetName').val();
            $.ajax({
                url : "${baseUrl}/helper/dataset_exists?name="+nameToCheck,
                type: "GET",
                dataType : 'json',
                success:function(data, textStatus, jqXHR) 
                {
                    if(data.found == 'yes'){
                        $('#check-dataset-name2').attr("src","${baseUrl}/images/red-check.png");
                    } else {
                        $('#check-dataset-name2').attr("src","${baseUrl}/images/green-check.png");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) 
                {
                    alert('Dataset name could not be validated!');  
                }
            });

        });

        function unique_datatset_name(){
            var dForm = document.forms["new_description_form"];
            var new_dataset_name = dForm.datasetName.value.trim();
            if(jQuery.inArray(new_dataset_name,datasetNames) == -1){
                return true;
            } else {
                sfm_show_error_msg('This dataset name is already being used!',dForm.datasetName);
                return false;            
            }
        }

        var frmValidator = new Validator("new_description_form");
        frmValidator.addValidation("dataset_id","maxlen=7","Dataset ID must be 7 characters at most");
        frmValidator.addValidation("dataset_name","req","This field is required");
        frmValidator.addValidation("owner","req","This field is required");
        frmValidator.addValidation("curator","req","This field is required");
        frmValidator.addValidation("curator_email","req","This field is required");
        frmValidator.addValidation("access_method","req","This field is required")
        //frmValidator.addValidation("creator","req","This field is required");
        //frmValidator.addValidation("rights_holder","req","This field is required");                        
        // Custom validation function (pass the function name as is , not as a string)
        //frmValidator.setAddnlValidationFunction(unique_datatset_name); 
        
</script>
