 <div role="tabpanel" class="tab-pane" id="fundamentalSearch">
     <div class="container" style="width: 100%">
        <div class="row">
            <div class="col-sm-8">
                <div class="row">
                    <div class="col-md-12">
                        <div class="search_header_bar">
                            Search by Fundamental Categories
                        </div>
                    </div>
                </div>
                <div class="row">
                    <form class="form-inline" action="search/basic/thing" method="post">  
                        <div class="col-md-2">
                            <label for="valueField" class="control-label">Thing</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" name="propertyField">
                                <option value="has_met_place" selected>has_met_place</option> 
                                <option value="has_met_actor">has_met_actor</option> 
                                <option value="has_met_thing">has_met_thing</option>
                                <option value="has_met_time">has_met_time</option> 
                                <option value="from_actor">from_actor</option> 
                                <option value="from_event">from_event</option> 
                                <option value="from_place">from_place</option> 
                                <option value="from_thing">from_thing</option>
                                <option value="from_time">from_time</option> 
                                <option value="by_event">by_event</option> 
                                <option value="by_actor">by_actor</option> 
                                <option value="refers_to_event">refers_to_event</option>
                                <option value="refers_to_thing">refers_to_thing</option>
                                <option value="has_dimension">has_dimension</option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <input type="text" class="form-control" id="valueField" name="valueField">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-default">Search</button>                   
                        </div>
                    </form>                    
                </div>

                <div class="row">
                    <form class="form-inline" action="search/basic/actor" method="post">   
                        <div class="col-md-2">
                            <label for="valueField" class="control-label">Actor</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" name="propertyField">
                                <option value="has_met_place" selected>has_met_place</option> 
                                <option value="has_met_thing">has_met_thing</option> 
                                <option value="measured_dimension">measured_dimension</option> 
                                <option value="refers_to_event">refers_to_event</option>
                                <option value="refers_to_thing">refers_to_thing</option>
                                <option value="is_owner_or_creator_of">is_owner_or_creator_of</option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <input type="text" class="form-control" id="valueField" name="valueField">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-default">Search</button>                   
                        </div>
                    </form>                    
                </div>

                <div class="row">
                    <form class="form-inline" action="search/basic/dimension" method="post">   
                        <div class="col-md-2">
                            <label for="valueField" class="control-label">Dimension</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" name="propertyField">
                                <option value="by_actor" selected>by_actor</option> 
                                <option value="by_event">by_event</option> 
                                <option value="of_place">of_place</option> 
                                <option value="of_thing">of_thing</option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <input type="text" class="form-control" id="valueField" name="valueField">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-default">Search</button>                   
                        </div>
                    </form>                    
                </div>

                <div class="row">
                    <form class="form-inline" action="search/basic/event" method="post">   
                        <div class="col-md-2">
                            <label for="valueField" class="control-label">Event</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" name="propertyField">
                                <option value="by_actor" selected>by_actor</option> 
                                <option value="from_place">from_place</option> 
                                <option value="from_time">from_time</option> 
                                <option value="has_met_thing">has_met_thing</option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <input type="text" class="form-control" id="valueField" name="valueField">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-default">Search</button>                   
                        </div>
                    </form>                    
                </div>

                <div class="row">
                    <form class="form-inline" action="search/basic/place" method="post">   
                        <div class="col-md-2">
                            <label for="valueField" class="control-label">Place</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" name="propertyField">
                                <option value="has_dimension" selected>has_dimension</option> 
                                <option value="has_met_thing">has_met_thing</option> 
                            </select>
                        </div>
                        <div class="col-md-5">
                            <input type="text" class="form-control" id="valueField" name="valueField">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-default">Search</button>                   
                        </div>
                    </form>                    
                </div> 
            </div>
            <div class="col-sm-4">
                              
            </div>                            
        </div>
     </div>
</div>