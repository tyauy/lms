<!DOCTYPE html>


<!--- <cfif isdefined('st')><cfdump var="#st#"></cfif> --->
<cfsilent>

    <cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="lmethod" default="0">
<cfparam name="end_date" default="#LSDateFormat(DateAdd('d', 30, now()),'yyyy-mm-dd', 'fr')#">
<cfparam name="start_date" default="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">

	<!--- <cfquery name="get_deadline" datasource="#SESSION.BDDSOURCE#">
	SELECT req.* FROM (
        SELECT 
        u.user_id,
        u.user_firstname as firstname,
        u.user_name as lastname,
        o.order_id,
        tp.tp_date_end,
        o.order_end,
    	llm.method_id,
    	llm.method_alias_fr,
        tp.tp_duration as tp_duration,
        SUM(ll.lesson_duration) as lesson_book,
    	(SELECT SUM(ue2.sm_elapsed) FROM user_elapsed ue2 WHERE ue2.user_id = tp.user_id GROUP BY ue2.user_id) as time_elapsed,
    	u.user_lastconnect as lastview
        FROM lms_tp tp
        LEFT JOIN orders o ON tp.order_id = o.order_id
        LEFT JOIN lms_tpsession lts ON tp.tp_id = lts.tp_id
        LEFT JOIN lms_lesson2 as ll ON ll.session_id = lts.session_id  AND ll.status_id <> 3
        LEFT JOIN user u ON tp.user_id = u.user_id
    	LEFT JOIN lms_lesson_method llm ON tp.method_id = llm.method_id
        WHERE o.order_end BETWEEN "#start_date#" AND "#end_date#"
        AND tp.tp_status_id = 2

        <cfif lmethod neq 0>
            AND tp.method_id = #lmethod#
        </cfif>
        GROUP BY tp.tp_id) as req
    WHERE req.lesson_book < req.tp_duration OR req.lesson_book IS NULL 
    ORDER BY `req`.`order_end`  ASC

	</cfquery> --->

    <!--- <cfquery name="get_lesson_method" datasource="#SESSION.BDDSOURCE#">
        SELECT method_id, method_alias_fr FROM `lms_lesson_method`
    </cfquery> --->
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head_vue.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "ORDER : DEADLINE">


		
		<cfinclude template="./incl/incl_nav.cfm">

        
		<div class="content">
            <div id="vue-app">		
			<div class="row">	
			
				<div class="col-md-12">
					
					<!--- <a href="cs_alert_order.cfm?view=closed" class="btn p-2 <cfif view eq "closed">btn-info <cfelse>btn-outline-info</cfif>">CLOSE DEAD LINE</a>
					<a href="cs_alert_order.cfm?view=outdatedd" class="btn p-2 <cfif view eq "outdatedd">btn-info <cfelse>btn-outline-info</cfif>">OUTDATED DEADLINE</a>
					
					<cfform>
						<div class="row">
						<cfselect id="sel_fstatus" class="sel_fstatus p-2 m-1 mb-3 form-select-sm col-2" name="sel_fstatus" query="get_fstatus" display="status_finance_name" queryposition="below" selected="#st#" value="status_finance_id">
							<option <cfif st eq 0>selected </cfif> value = 0>Status: All</option>
						</cfselect>
						<cfselect id="sel_context" class="sel_context p-2 m-1 mb-3 form-select-sm col-2" name="sel_context" query="get_context" display="context_alias" queryposition="below" selected="#cont#" value="context_id">
							<option <cfif cont eq 0>selected </cfif>value = 0>Contexte: All</option>
						</cfselect>
						<cfselect id="sel_mode" class="sel_mode p-2 m-1 mb-3 form-select-sm col-2" name="sel_mode" query="get_mode" display="order_item_mode_name" queryposition="below" selected="#mode#" value="order_item_mode_id">
							<option <cfif mode eq 0>selected </cfif>value = 0>Pack: All</option>
						</cfselect>
						
						<div class="typeahead__container col-4 m-0 mt-1 mb-3 p-0">
							<div class="typeahead__field">
								<div class="typeahead__query">
									<cfsilent><cfif acc neq 0><cfquery name="get_acc" datasource="#SESSION.BDDSOURCE#">SELECT account_name FROM account WHERE account_id =#acc#</cfquery><cfset plholder = #get_acc.account_name#><cfelse><cfset plholder = "Account: all"></cfif></cfsilent>
									<input class="js_typeahead_account" <!---name="country_v1[query]"---> type="search" placeholder=<cfoutput>"#plholder#"</cfoutput> autocomplete="off">
								</div>
							</div>
						</div>
						<div class="col-1 m-0 p-0">
						<button id="btn_all_acc" class="m-0 mt-1 mb-3 p-2 btn_all_acc btn-md btn-ouline" style="background-color:white; border:1px grey solid;">
							All
						</button>
						</div>
						
						</div>
					</cfform> --->

                    <!--- <cfform action="cs_alert_deadline.cfm" method="post">
                        <div class="row">
                            <div class="col-md-2">
                                <cfselect id="lmethod" class="lmethod p-2 m-1 mb-3 form-select-sm" name="lmethod" query="get_lesson_method" display="method_alias_fr" queryposition="below" selected="#lmethod#" value="method_id">
                                    <option <cfif lmethod eq 0>selected </cfif>value = 0>Pack: All</option>
                                </cfselect>
                            </div>
                            <div class="col-md-4">
                                <div class="controls">
                                    <div class="input-group">
                                        <input id="end_date" name="end_date" type="text" class="datepicker form-control" value="<cfoutput>#end_date#</cfoutput>" />
                                        <label for="end_date" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
                                    </div>
                                </div>	
                            </div>
                            <div class="col-md-2">
                                <button type="submit" id="btn_all_acc" class="m-0 mt-1 mb-3 p-2 btn_all_acc btn-md btn-ouline" style="background-color:white; border:1px grey solid;">
                                    SELECT
                                </button>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-success"  v-on:click="callapi()">ajouter</button>
                            </div>
                        </div>
                        
                    </cfform> --->

                    <!--- <div class="table-responsive">
                    <table class="table table-sm">
                        <tbody>
                            <tr class="bg-light">
                                <th>ORDER ID</th>
                                <th>APPRENANT</th>
                                <th>TYPE</th>
                                <th>TP END</th>
                                <th>ORDER END</th>
                                <th>LESSON REMAINING</th>
                                <th>LAST CONNEXION</th>
                            </tr>
                            <cfoutput query="get_deadline">

                            <tr>
                                <td><span class="badge badge-pill text-white badge-default btn_edit_order" id="o_#order_id#" style="cursor:pointer">#order_id#</span></td>
                                <!---<td><a class="btn btn-xs #status_cs_css#">#status_cs_name#</a></td>--->
                                <td><a href="common_learner_account.cfm?u_id=#user_id#"><strong>#firstname# #lastname#</strong></a></td>
                                <!--- <td><a href="crm_account_edit.cfm?a_id=#account_id#"><small><strong><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></strong></small></a></td> --->
                                
                                <td>#method_alias_fr#</td>
                                
                                <td>#lsDateFormat(tp_date_end,'dd/mm/yyyy', 'fr')#</td>
                                <td>#lsDateFormat(order_end,'dd/mm/yyyy', 'fr')#</td>
                                <cfif method_id eq 1>
                                    <td>#(tp_duration - lesson_book) / 60# h</td>
                                <cfelse>
                                    <!--- <cfif time_elapsed neq "">
                                        <td>#(tp_duration - time_elapsed) / 60# h</td>
                                    <cfelse> --->
                                        <td>-</td>
                                    <!--- </cfif> --->
                                    
                                </cfif>
                                <td>#lastview#</td>
                                
           
                            </tr>		
                            </cfoutput>
                        </tbody>

                    </table>
                    </div>						 --->
                    <form >
                    <v-row>
                        
                    <v-col cols="4" >
                        <v-select  v-model="select"
                        :hint="`${select.METHOD_ALIAS_FR}`"
                        :items="item_method"
                        item-text="METHOD_ALIAS_FR"
                        item-value="METHOD_ID"
                        label="Select"
                        persistent-hint
                        return-object
                        single-line ></v-select>
                    </v-col>
                   
                    <v-col cols="4">
                    <v-menu
                        v-model="menu2"
                        :close-on-content-click="false"
                        :nudge-right="40"
                        transition="scale-transition"
                        offset-y
                        min-width="auto">

                        <template v-slot:activator="{ on, attrs }">
                        <v-text-field
                            v-model="date"
                            label="Picker without buttons"
                            prepend-icon="mdi-calendar"
                            readonly
                            v-bind="attrs"
                            v-on="on"></v-text-field>
                        </template>
                        
                        <v-date-picker
                        v-model="date"
                        @input="menu2 = false"
                        ></v-date-picker>
                    </v-menu>
                    </v-col>
                    <!--- <v-spacer></v-spacer> --->
                    <v-col cols="2" >
                        <v-btn class="mr-4" v-on:click="submit" >
                            <!--- :disabled="invalid"  --->
                        SELECT
                    </v-btn>
                    <!--- <v-btn @click="clear">
                        clear
                    </v-btn> --->
                    </v-col>
               
                </v-row>
                </form>
                
                    
                    <v-app>
                        <v-main>
                          <v-container>
                            <v-card>
                                <v-card-title>

                                <v-text-field
                                    v-model="search"
                                    append-icon="mdi-magnify"
                                    label="Search"
                                    single-line
                                    hide-details>
                                </v-text-field>

                                </v-card-title>

                                <v-data-table
                                  :headers="headers"
                                  :items="data"
                                  :search="search"
                                  <!--- multi-sort --->
                                  >
                                <template #item._id="{ item }">
                                    <a v-bind:href="'common_learner_account.cfm?u_id='+ item.USER_ID"><strong> {{ item.USER_ID }}</strong></a>
                                </template>
                                <!--- <template #item._remain="{ item }">
                                    <span v-if="item.METHOD_ID == 1">
                                        {{ Number(((item.TP_DURATION - item.LESSON_BOOK) / 60).toFixed(2)) }} h
                                    </span>
                                    <span v-else>-</span>
                                    
                                </template> --->
                                </v-data-table>

                              </v-card>
                          </v-container>
                        </v-main>
                      </v-app>
					
				</div>
				
            </div>
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts_vue.cfm">

<script>

$(document).ready(function() {
    $("#end_date").datepicker({	
		weekStart: 1,
		dateFormat: 'yy-mm-dd',
		onClose: function( selectedDate ) {
			end_date = $('#end_date').datepicker("getDate");
			end_date = moment(end_date).format('YYYY-MM-DD');
		}		
    });
});

    // import common_trainer_account_main from './vue/common_trainer_account_main.cfm'
    // var common_trainer_account_main = import('./vue/common_trainer_account_main.cfm');
    // const { createApp, ref, computed, watch } = Vue;
    
    var app = new Vue({
        el: "#vue-app",
        vuetify: new Vuetify(),
    //   setup () {
    //     return {
    //       tab: ref('mails')
    //     };
    //   },
        
      data() {
          return {
              message: 'hello',
              date: (new Date(new Date().setDate(new Date().getDate() + 7))).toISOString().substr(0, 10),
              select: { METHOD_ID: '0', METHOD_ALIAS_FR: 'ALL' },
              item_method: [],
              menu2: false,
              search: '',
              data: [],
              headers:[{ text: 'ORDER ID', align: 'start', value: 'ORDER_ID',},
                { text: 'NAME', value: 'FIRSTNAME' },
                { text: 'SURNAME', value: 'LASTNAME' },
                { text: 'USER ID', value: '_id' },
                { text: 'TYPE', value: 'METHOD_ALIAS_FR' },
                { text: 'TP END', value: 'TP_DATE_END' },
                { text: 'ORDER END', value: 'ORDER_END' },
                { text: 'LESSON REMAINING', value: 'remain' },
                { text: 'LAST CONNEXION', value: 'LASTVIEW' }],
          };
      },
      methods: {
          async callapi () {
              // const axios = require('axios');
            try {
                // console.log("hello");

                const list = await axios.get('api/report/report_get.cfc?method=oget_method_list');
                this.item_method = list.data;
                this.item_method.unshift({ METHOD_ID: '0', METHOD_ALIAS_FR: 'ALL' })
                console.log(this.item_method );
                const response = await axios.post('api/report/report_post.cfc?method=get_tp_deadline');

                for (let index = 0; index < response.data.length; index++) {
                    const element = response.data[index];
                    if (element.METHOD_ID == 1) {
                      element.remain = Number(((element.TP_DURATION - element.LESSON_BOOK) / 60).toFixed(2));
                    } else {
                      element.remain = "-"
                    }
                      
                }
                this.data = response.data;
            } catch (error) {
                console.error(error);
            }
          },

          async submit () {
              try {

                console.log(this.date);
                let formData = new FormData();

				formData.append('end_date', this.date);
                if (this.select.METHOD_ID != 0) {
                    formData.append('lmethod', this.select.METHOD_ID);
                }


                const response = await axios.post('api/report/report_post.cfc?method=get_tp_deadline', formData);

                for (let index = 0; index < response.data.length; index++) {
                    const element = response.data[index];
                    if (element.METHOD_ID == 1) {
                    element.remain = Number(((element.TP_DURATION - element.LESSON_BOOK) / 60).toFixed(2));
                    } else {
                    element.remain = "-"
                    }
                    
                }
                this.data = response.data;
              } catch (error) {
                  console.error(error);
              }
          }
      },
      created() {
		  this.callapi();
	  },
    });

    // createApp(app).mount('#vue-app')


	
</script>

</body>
</html>