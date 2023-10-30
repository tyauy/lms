
		
		
		
		
		
		
		
		
		
		

					<div class="btn-group-toggle" data-toggle="buttons" align="center">	
                        <cfoutput>
                        <cfloop query="get_keyword_cat">
                        <label class="btn btn-sm btn-outline-info" data-toggle="collapse" data-target="##collapse_#keyword_cat_id#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> 
                        <img src="./assets/img/lst_extrovert.jpg" width="150"><br>
                        <h5 class="m-0">#keyword_cat_name#</h5>
                        </label>
                        </cfloop>	
                        </cfoutput>			
                        </div>
                        
                        <div class="accordion" id="accordion_kw">
                        
                        <!--- <div class="row"> --->
                        
                            <!--- <cfloop query="get_keyword_cat"> --->
                            <!--- <div class="col-md-4"> --->
                                <!--- <div class="card border mb-1"> --->
                                
                                    <!--- <div class="card-header bg-light"> --->
                                        
                                        <!--- <cfoutput><button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="##collapse_#keyword_cat_id#"></cfoutput> --->
                                            
                                            <!--- <h6 class="my-1"> --->
                                            <!--- <cfoutput>#keyword_cat_name#</cfoutput> --->
                                            <!--- </h6> --->
                                        <!--- </button> --->
                                        
                                    <!--- </div> --->
                                <!--- </div> --->
                            <!--- </div> --->
                            <!--- </cfloop> --->
                            
                        <!--- </div> --->
    
                            <cfloop query="get_keyword_cat">
                                <cfoutput><div id="collapse_#keyword_cat_id#" class="collapse p-2" data-parent="##accordion_kw"></cfoutput>
                                            
                                    <cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
                                    SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, (SELECT COUNT(sessionmaster_id) FROM lms_tpsessionmaster2 sm WHERE FIND_IN_SET(k.keyword_id, keyword_id)) as nb 
                                    FROM lms_keyword k 
                                    WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> 
                                    GROUP BY keyword_id
                                    ORDER BY keyword_name
                                    </cfquery>
                                    
                                    <cfif get_keyword.recordcount gt 3>
                                    <div class="row justify-content-md-center">
                                        <div class="col-md-4">
                                        
                                        <cfoutput query="get_keyword" startrow="1" maxrows="#ceiling(get_keyword.recordcount/3)#">
                                        <label><input type="checkbox" name="interest_id" id="interest_id" class="interest_id" value="#keyword_id#" <cfif listfind(int_id,keyword_id)>checked</cfif>> #keyword_name# (#nb#)</label><br>							
                                        </cfoutput>
                                        </div>
                                        
                                        <div class="col-md-4">
                                        <cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)+1#" maxrows="#ceiling(get_keyword.recordcount/3)#">
                                        <label><input type="checkbox" name="interest_id" id="interest_id" class="interest_id" value="#keyword_id#" <cfif listfind(int_id,keyword_id)>checked</cfif>> #keyword_name# (#nb#)</label><br>				
                                        </cfoutput>
                                        </div>
                                        
                                        <div class="col-md-4">
                                        <cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)*2+1#" maxrows="#get_keyword.recordcount#">
                                        <label><input type="checkbox" name="interest_id" id="interest_id" class="interest_id" value="#keyword_id#" <cfif listfind(int_id,keyword_id)>checked</cfif>> #keyword_name# (#nb#)</label><br>				
                                        </cfoutput>
                                        </div>
                                        
                                    </div>
                                    </cfif>
                                
                                </div>
                                
                                
                            </cfloop>
                            </div>
                        
                            </div>
                        
                        </div>
                
                        <div class="show_counter">
                        
                            <div class="row justify-content-md-center">
                                <div class="col-md-2" align="center">
                                    <div class="card border bg-light">
                                        <div class="card-body">
                                        <h6 class="mt-0">Durée du parcours</h6>
                                        <br>
                                        <h5><a class="btn btn-secondary text-white">
                                        <cfoutput>
                                        #get_tp.tp_duration/60# h
                                        </cfoutput>
                                        </a></h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-1" align="center">
                                <h1 class="mt-5">+</h1>
                                </div>
                                <div class="col-md-2" align="center">
                                    <div class="card border bg-light">
                                        <div class="card-body">
                                        <h6 class="mt-0">Mon niveau</h6>
                                        <br>
                                        <h5><a class="btn btn-secondary text-white">
                                        A2
                                        </a></h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-1" align="center">
                                <h1 class="mt-5">+</h1>
                                </div>
                                <div class="col-md-2" align="center">
                                    <div class="card border bg-light">
                                        <div class="card-body">
                                        <h6 class="mt-0">Thématiques</h6>
                                        <br>
                                        <h5><a class="btn btn-secondary text-white">
                                        <span class="counter_theme">0</span>
                                        </a></h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-1" align="center">
                                <h1 class="mt-5">=</h1>
                                </div>
                                <div class="col-md-3" align="center">
                                    <div class="card border bg-light">
                                        <div class="card-body">
                                        <h6 class="mt-0">Ressource(s) trouvée(s)</h6>
                                        <br>
                                        <h5><a class="btn btn-secondary counter_material text-white">
                                        <div class="spinner-grow text-secondary d-none loading_material" role="status">
                                        <span class="sr-only">Loading...</span>
                                        </div>
                                        </a></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row justify-content-md-center">
                                <div class="col-md-9" align="center">
                                    <div class="alert alert-danger warning_message">
                                    Veuillez sélectionner plus de thématiques SVP.
                                    </div>
                                </div>
                            </div>
                        
                        </div>
                        
                        <div align="center"><a class="btn btn-lg btn-secondary greenlight_material disabled text-white">Valider mon choix</a></div>
                
                
                </div>
                
                
                
            </div>
            
        </div>
        
    
    
    <script>
    $(document).ready(function() {
    
    
        tp_duration = 10;
        level = "A2";
        
        var interest = [];
        $.each($("input[id='interest_id']:checked"), function(){
            interest.push($(this).val());
        });
        
        $(".loading_material").show("fast");
        
        
        $('.btn_go_suggested').click(function(event) {
            event.preventDefault();		
            document.location.href="learner_launch_2b.cfm?tp_choice=solo&tp_suggested=1&kwish_id="+interest;
            
        });
            
        <!--- var level = []; --->
        <!--- $.each($("input[name='level_id']:checked"), function(){ --->
            <!--- level.push($(this).val()); --->
        <!--- }); --->
        
        $.ajax({
            url : 'updater_counter.cfc?method=oget_material',
            type : 'GET',
            data : 'interest_id='+interest+'&level_id='+level,
            success : function(result, statut){
                $(".loading_material").hide("slow");
                $(".counter_material").text(result);
                $(".greenlight_material").hide();
                $(".show_counter").hide();
                
                if(result == "0")
                {
                $(".counter_material").removeClass("btn-success");
                $(".counter_tp").removeClass("btn-success");
                $(".counter_material").addClass("btn-secondary");
                $(".counter_tp").addClass("btn-secondary");
                }
                
            }
        })
        
        $(".interest_id").click(function() {
            
            var interest = [];
            $.each($("input[id='interest_id']:checked"), function(){
                interest.push($(this).val());
            });
            $(".loading_material").show("fast");
            $(".counter_theme").text(interest.length);
            <!--- var level = []; --->
            <!--- $.each($("input[name='level_id']:checked"), function(){ --->
                <!--- level.push($(this).val()); --->
            <!--- }); --->
            
            $.ajax({
                url : 'updater_counter.cfc?method=oget_material',
                type : 'GET',
                data : 'interest_id='+interest+'&level_id='+level,
                success : function(result, statut){
                    $(".loading_material").hide("slow");
                    $(".counter_material").text(result);
                    $(".show_counter").show("fast");
                    if(result == "0")
                    {
                        $(".counter_material").removeClass("btn-success");
                        $(".counter_tp").removeClass("btn-success");
                        $(".counter_material").addClass("btn-secondary");
                        $(".counter_tp").addClass("btn-secondary");
                        $(".greenlight_material").hide();
                    }
                    else if(result != "0" && result < tp_duration)
                    {
                        
                        $(".greenlight_material").hide();
                        <!--- $(".greenlight_material").text("Valider mon choix"); --->
                        $(".counter_material").removeClass("btn-success");
                        $(".counter_tp").removeClass("btn-success");
                        $(".counter_material").addClass("btn-secondary");
                        $(".counter_tp").addClass("btn-secondary");
                        
                        $(".greenlight_material").removeClass("btn-success");
                        $(".greenlight_material").addClass("btn-secondary");
                        $(".greenlight_material").addClass("disabled");
                        
                        $(".warning_message").show();
                        
                        <!--- $(".warning_message").hide("slow"); --->
                        
                    }
                    else
                    {
                        $(".greenlight_material").show();
                        $(".counter_material").removeClass("btn-secondary");
                        $(".counter_tp").removeClass("btn-secondary");
                        $(".counter_material").addClass("btn-success");
                        $(".counter_tp").addClass("btn-success");
                        
                        $(".greenlight_material").removeClass("btn-secondary");
                        $(".greenlight_material").addClass("btn-success");
                        $(".greenlight_material").removeClass("disabled");
                        
                        $(".warning_message").hide("slow");
                    }
                    
                }
            })
        });
    });
    
        </script>
        