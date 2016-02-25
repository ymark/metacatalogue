<div class="row">
    <div class="col-md-12">
        <div class="search_header_bar">
            Add a dataset
        </div>
    </div>
</div>
<div class="row form-group">
    <ex:Select dLen="6" lLen="4" fLen="6" fName="data_for_dataset" fTitle="Select dataset" fReq="true">
        No dataset selected,${userDatasetListString}
    </ex:Select>           
</div>
    <br>    
<form method="post" action="${baseUrl}/publish/add_dataset" enctype="multipart/form-data" id="upload_dataset_form">
    
    <div class="row form-group">
        <div class="col-md-12">
            <!-- A label for the line (optional) -->
            <label for="" class="col-sm-2 control-label">Select Dataset File: <ast>*</ast></label>
            <div class="col-sm-2">
                <!--  The file selector -->
                <span class="btn btn-default btn-file" style="width:100%">
                        Select a file...
                        <!--  In case we allow multiple files to be uploaded
                                  <input type="file" name="file[]" multiple=""> 
                        -->
                        <input type="file" name="dataset_file">
                </span>
            </div>
            <div class="col-sm-8" id="files_to_upload">
                <!--  A field to display the selected file	 -->
                <input type="text" name="dataset_file_name" class="form-control" disabled>
            </div>	
        </div>								
    </div>
    
    <input type="hidden" id="target_dataset2" name="target_dataset2" value="">
    
    <div style="text-align: center; margin-top: 20px">
        <button class="btn btn-default">Upload File</button>
    </div>
</form>
    
<script type="text/javascript">
            
    $("input[name='dataset_file']").change(function(){
	// This is a loop that can be used in case there are many selected files
	for(var i=0; i< this.files.length; i++){
		var file = this.files[i];
		name = file.name.toLowerCase();						
		$('input[name="dataset_file_name"]').val(name);
	}
    });
            
    $("#data_for_dataset").change(function(){  
        var selected_dataset = $(this).val();
        if(selected_dataset != 'No dataset selected'){
            $('#target_dataset2').val($(this).val());
        } else {
            $('#target_dataset2').val('');
        }        
    });

</script>    