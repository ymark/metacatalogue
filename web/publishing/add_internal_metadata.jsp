<div class="row">
    <div class="col-md-12">
        <div class="search_header_bar">
            Add Metadata for a Dataset
        </div>
    </div>
</div>

<div class="row form-group">
    <ex:Select dLen="6" lLen="4" fLen="6" fName="metadata_for_dataset" fTitle="Select dataset" fReq="true">
        No dataset selected,${userDatasetListString}
    </ex:Select>       
    <ex:Select dLen="6" lLen="4" fLen="6" fName="metadata_dataset_type" fTitle="Metadata type" fReq="true">
        No type selected,Common Name,Environmental,Genetics,Identification,Morphometrics,MicroCT Specimen,MicroCT Scanning,MicroCT Reconstruction,MicroCT PostProcessing,Morphological Characteristics,Scientific Name,Occurrences,Occurrence Statistics,Specimen,Specimen Collection,Statistics,Synonyms,Taxonomy
    </ex:Select>      
</div>
    <br>    
<form method="post" action="${baseUrl}/publish/add_metadata" enctype="multipart/form-data" id="upload_metadata_form">
    
    <div class="row form-group">
        <div class="col-md-12">
            <!-- A label for the line (optional) -->
            <label for="" class="col-sm-2 control-label">Select Metadata File:<ast>*</ast></label> 
            <div class="col-sm-2">
                <!--  The file selector -->
                <span class="btn btn-default btn-file" style="width:100%">
                        Select a file...
                        <!--  In case we allow multiple files to be uploaded
                                  <input type="file" name="file[]" multiple=""> 
                        -->
                        <input type="file" name="metadata_file">
                </span>
            </div>
            <div class="col-sm-8" id="files_to_upload">
                <!--  A field to display the selected file	 -->
                <input type="text" name="metadata_file_name" class="form-control" disabled>
            </div>	
        </div>								
    </div>
    
    <input type="hidden" id="target_dataset" name="target_dataset" value="">
    <input type="hidden" id="metadata_type" name="metadata_type" value="">
    
    <div style="text-align: center;  margin-top: 20px">
        <button class="btn btn-default">Upload File</button>
    </div>
</form>
    
    
<script type="text/javascript">
            
    $("input[name='metadata_file']").change(function(){
	// This is a loop that can be used in case there are many selected files
	for(var i=0; i< this.files.length; i++){
		var file = this.files[i];
		name = file.name.toLowerCase();						
		$('input[name="metadata_file_name"]').val(name);
	}
    });
            
    $( document ).ready(function() {
        $("#metadata_for_dataset").change(function(){  
            var selected_dataset = $(this).val();
            if(selected_dataset != 'No dataset selected'){
                $('#target_dataset').val($(this).val());
            } else {
                $('#target_dataset').val('');
            }        
        });

        $("#metadata_dataset_type").change(function(){
           var metadata_type = $(this).val();
           switch(metadata_type){
               case 'No type selected':
                   $('#metadata_type').val('');
                   break;
               case 'Occurrences':
                   $('#metadata_type').val('occurences');
                   break;
               case 'Environmental':
                   $('#metadata_type').val('environmental');
                   break;
               case 'Morphometrics':
                   $('#metadata_type').val('measurement');
                   break;
               case 'Identification':
                   $('#metadata_type').val('identification');
                   break;
               case 'Morphological Characteristics':
                   $('#metadata_type').val('morphometrics');
                   break;
               case 'Statistics':
                   $('#metadata_type').val('statistics');
                   break;
               case 'Taxonomy':
                   $('#metadata_type').val('taxonomy');
                   break;
               case 'Scientific Name':
                   $('#metadata_type').val('scientific_name');
                   break;
               case 'Common Name':
                   $('#metadata_type').val('common_name');
                   break;
               case 'Synonyms':
                   $('#metadata_type').val('synonym');
                   break;
               case 'Specimen':
                   $('#metadata_type').val('specimen');
                   break;
               case 'Specimen Collection':
                   $('#metadata_type').val('collection');
                   break;
               case 'Occurrence Statistics':
                   $('#metadata_type').val('temp_stats');
                   break;
               case 'MicroCT Specimen':
                   $('#metadata_type').val('ct_specimen');
                   break;
               case 'MicroCT Scanning':
                   $('#metadata_type').val('ct_scanning');
                   break;
               case 'MicroCT Reconstruction':
                   $('#metadata_type').val('ct_reconstruct');
                   break;
               case 'MicroCT PostProcessing':
                   $('#metadata_type').val('ct_postprocess');
                   break;
               case 'Genetics':
                   $('#metadata_type').val('genetics');
                   break;
           }  
        });
        
        //$('#target option[selected="selected"]').removeAttr('selected');
        //$("#target option:first").attr('selected','selected');
        
    });                

</script>    