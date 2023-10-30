<!DOCTYPE html>


<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfset year = "2023">

<!--- <cfparam name="lmethod" default="0">
<cfparam name="end_date" default="#LSDateFormat(DateAdd('d', 30, now()),'yyyy-mm-dd', 'fr')#">
<cfparam name="start_date" default="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#"> --->
<cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#">
	SELECT provider_id, provider_name, provider_code FROM account_provider
</cfquery>

<cfquery name="get_status_finance" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
    SELECT status_finance_id, status_finance_name FROM order_status_finance
</cfquery>

<cfquery name="get_context_finance" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
    SELECT context_id, context_alias, context_name, context_color FROM order_context
</cfquery>

<cfquery name="get_tp_method" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
    SELECT method_id, method_name_fr FROM lms_lesson_method WHERE method_id IN (1,2,3,6,7)
</cfquery>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head_vue.cfm">

    <style>
        th {
            overflow: hidden;
            white-space: nowrap;
            cursor: pointer;
        }
    </style>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "ORDER">
		<cfinclude template="./incl/incl_nav.cfm">

        
		<div class="content">

            <cfif listFindNoCase("SALES", SESSION.USER_PROFILE)>
                <cfinclude template="./incl/incl_nav_sales.cfm">
            <cfelseif listFindNoCase("TRAINERMNG", SESSION.USER_PROFILE)>
                <cfinclude template="./incl/incl_nav_tmg.cfm">
            <cfelseif listFindNoCase("CS", SESSION.USER_PROFILE)>
                <cfinclude template="./incl/incl_nav_cs.cfm">
            <cfelseif listFindNoCase("FINANCE", SESSION.USER_PROFILE)>
                <cfinclude template="./incl/incl_nav_finance.cfm">
            </cfif>



            <!--- <cfdump var="#SESSION.REPORT_OPTION#">
            <cfdump var="#SESSION.REPORT_OPTION["finance_order_list_get"].path#">
            <cfdump var="#SESSION.REPORT_OPTION["finance_order_list_get"]#"> --->

            <!--- START OF VUE COMPONENT --->
            <div id="vue-app">		
			<div class="row">	
			
				<div class="col-md-12">
                    <v-app>
                        <v-main>
                          <v-container>

                            <form>
                            <v-row>
                                
                               
                                <v-col cols="2">
                                    <v-select
                                        v-model="select_provider"
                                        :items="item_provider"
                                        item-text="name"
                                        item-value="id"
                                        label="Provider"
                                        multiple
                                        >
                                        <template v-slot:selection="{ item, index }">
                                            <v-chip v-if="index < 1">
                                            <span>{{ item.name }}</span>
                                            </v-chip>
                                            <span
                                            v-if="index === 1"
                                            class="grey--text text-caption"
                                            >
                                            (+{{ select_provider.length - 1 }} autres)
                                            </span>
                                        </template>
                                    </v-select>
                                </v-col>


                                <v-col cols="2">
                                    <v-select
                                        v-model="select_status_finance"
                                        :items="item_status_finance"
                                        item-text="name"
                                        item-value="id"
                                        label="Status"
                                        multiple
                                        >
                                        <template v-slot:selection="{ item, index }">
                                            <v-chip v-if="index < 1">
                                            <span>{{ item.name }}</span>
                                            </v-chip>
                                            <span
                                            v-if="index === 1"
                                            class="grey--text text-caption"
                                            >
                                            (+{{ select_status_finance.length - 1 }} autres)
                                            </span>
                                        </template>
                                    </v-select>
                                </v-col>

                                <v-col cols="2">
                                    <v-select
                                        v-model="select_finance"
                                        :items="item_finance"
                                        item-text="name"
                                        item-value="id"
                                        label="Financement"
                                        multiple
                                        >
                                        <template v-slot:selection="{ item, index }">
                                            <v-chip v-if="index < 1">
                                            <span>{{ item.name }}</span>
                                            </v-chip>
                                            <span
                                            v-if="index === 1"
                                            class="grey--text text-caption"
                                            >
                                            (+{{ select_finance.length - 1 }} autres)
                                            </span>
                                        </template>
                                    </v-select>
                                </v-col>

                                <v-col cols="2">
                                    <v-select
                                        v-model="select_method"
                                        :items="item_method"
                                        item-text="name"
                                        item-value="id"
                                        label="Method"
                                        multiple
                                        >
                                        <template v-slot:selection="{ item, index }">
                                            <v-chip v-if="index < 1">
                                            <span>{{ item.name }}</span>
                                            </v-chip>
                                            <span
                                            v-if="index === 1"
                                            class="grey--text text-caption"
                                            >
                                            (+{{ select_method.length - 1 }} autres)
                                            </span>
                                        </template>
                                    </v-select>
                                </v-col>

                                <v-col cols="2">
                                    <v-select
                                        v-model="select_manager"
                                        :items="item_manager"
                                        item-text="name"
                                        item-value="id"
                                        label="Manager"
                                        multiple
                                        >
                                        <template v-slot:selection="{ item, index }">
                                            <v-chip v-if="index < 1">
                                            <span>{{ item }}</span>
                                            </v-chip>
                                            <span
                                            v-if="index === 1"
                                            class="grey--text text-caption"
                                            >
                                            (+{{ select_manager.length - 1 }} autres)
                                            </span>
                                        </template>
                                    </v-select>
                                </v-col>

                                <v-col cols="2">
                                    <v-select
                                        v-model="select_year"
                                        :items="item_year"
                                        multiple
                                        >
                                        <template v-slot:selection="{ item, index }">
                                            <v-chip v-if="index < 1">
                                            <span>{{ item }}</span>
                                            </v-chip>
                                            <span
                                            v-if="index === 1"
                                            class="grey--text text-caption"
                                            >
                                            (+{{ select_year.length - 1 }} autres)
                                            </span>
                                        </template>
                                    </v-select>
                                </v-col>
                                
                            </v-row>
                            <v-row>

                                <v-col cols="2">
                                    <v-menu
                                        v-model="menu"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        transition="scale-transition"
                                        offset-y
                                        min-width="auto">
                
                                        <template v-slot:activator="{ on, attrs }">
                                        <v-text-field
                                            v-model="date_begin"
                                            label="Begin"
                                            prepend-icon="mdi-calendar"
                                            readonly
                                            v-bind="attrs"
                                            v-on="on"></v-text-field>
                                        </template>
                                        
                                        <v-date-picker
                                        v-model="date_begin"
                                        @input="menu = false"
                                        ></v-date-picker>
                
                                    </v-menu>
                                </v-col>
                                <!--- <v-spacer></v-spacer> --->

                                <v-col cols="2">
                                    <v-menu
                                        v-model="menu2"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        transition="scale-transition"
                                        offset-y
                                        min-width="auto">
                
                                        <template v-slot:activator="{ on, attrs }">
                                        <v-text-field
                                            v-model="date_end"
                                            label="End"
                                            prepend-icon="mdi-calendar"
                                            readonly
                                            v-bind="attrs"
                                            v-on="on"></v-text-field>
                                        </template>
                                        
                                        <v-date-picker
                                        v-model="date_end"
                                        @input="menu2 = false"
                                        ></v-date-picker>
                
                                    </v-menu>
                                </v-col>
                                <!--- <v-spacer></v-spacer> --->
                                <v-col cols="2" >
                                    <v-btn class="mr-4" v-on:click="submit" >
                                        <!--- :disabled="invalid"  --->
                                    DISPLAY
                                    </v-btn>
                                <!--- <v-btn @click="clear">
                                    clear
                                </v-btn> --->
                                </v-col>
                                <v-col cols="2" >
                                    <a type="button" :href="'/exporter/export_order.cfm?year=' + select_year + '&manager=' + select_manager + '&finance=' + select_finance + '&provider=' + select_provider + '&status_finance=' + select_status_finance + '&from_tselect=' + date_begin + '&to_tselect=' + date_end + '&method=' + select_method" class="btn btn-sm btn-info">XLS<i class="fa-light fa-download"></i></a>
                                </v-col>
                            </v-row>
                          </form>

                            <v-rows>
                            <v-text-field
                                v-model="search"
                                append-icon="mdi-magnify"
                                label="Search"
                                single-line
                                hide-details>
                            </v-text-field>
                            </v-rows>

                            <v-rows>
                            <span>
                                {{result_nb}} resultat
                            </span>
                            </v-rows>

                                
                            <v-row>
                                <v-pagination
                                v-model="currentPageTop"
                                :length="rows"
                                :per-page="perPage"
                                :total-visible="9"
                                aria-controls="my-table"
                                ></v-pagination>
                            </v-row>
            
                            <v-col cols="12">
                                <div id="my-table">

                                    <!--- <div class="search-wrapper">
                                        <label>Search title:</label>
                                        <input type="text" v-model="search" placeholder="Search title.."/>
                                    </div> --->

                                    

                                    <table class="table table-sm">
                                        <tbody>
                                            <tr class="bg-light">
                                                <th @click="sortBy('ORDER_ID')">ID <i class="fa-solid fa-arrow-up-arrow-down"></i></th>
                                                <th @click="sortBy('CONTEXT_ALIAS')">STATUS <i class="fa-solid fa-arrow-up-arrow-down"></i></th>
                                                <!--- FULL --->
                                                <th @click="sortBy('MANAGER_FIRSTNAME')">MANAGER <i class="fa-solid fa-arrow-up-arrow-down"></i></th>
                                                <th @click="sortBy('ORDER_DATE')">CLOSED <i class="fa-solid fa-arrow-up-arrow-down"></i></th>
                                                <!--- FULL --->
                                                <th @click="sortBy('ACCOUNT_NAME')">APPRENANT <i class="fa-solid fa-arrow-up-arrow-down"></i></th>
                                                <th @click="sortBy('FORMATION_CODE')">LANG <i class="fa-solid fa-arrow-up-arrow-down"></i></th>
                                                <th>PACK</th>
                                                <th @click="sortBy('ORDER_START')">START <i class="fa-solid fa-arrow-up-arrow-down"></i></th>
                                                <th @click="sortBy('ORDER_END')">END <i class="fa-solid fa-arrow-up-arrow-down"></i></th>
                                                <th align="center"><strong>+</strong></th>
                                                <th align="center"><strong>-</strong></th>
                                            </tr>

                                            <tr v-for="item in filteredData">
                                                <td><span class="badge badge-pill text-white badge-default btn_edit_order" style="cursor:pointer">{{item.ORDER_REF}}</span></td>
                                                <td><span class="badge badge-pill text-white badge-default btn_edit_order" style="cursor:pointer">{{item.CONTEXT_ALIAS}}</span>
                                                    <br><span class="badge badge-pill text-white" :class="'bg-' + item.STATUS_FINANCE_CSS" style="cursor:pointer">{{item.STATUS_FINANCE_NAME}}</span></td>
                                                <!--- FULL --->
                                                <td><span class="badge badge-pill text-white" :style="'background-color:#'+ item.MANAGER_COLOR">{{item.MANAGER_FIRSTNAME}}</span></td>
                                                <td>{{formatDate(item.ORDER_DATE)}}</td>
                                                <!--- FULL --->

                                                <td>
                                                    <div v-for="le in item._LEARNER">
                                                        <a :href="'common_learner_account.cfm?u_id='+ le._USER_ID"><strong>{{le._USER_FIRSTNAME}} {{le._USER_NAME}}</strong></a>
                                                        <br><a :href="'crm_account_edit.cfm?a_id='+le._ACCOUNT_ID"><small><strong>{{le._ACCOUNT_NAME}}</strong></small></a>
                                                    </div>
                                                </td>
                                    
                                                <td>
                                                    <span class='lang-sm' :lang='item.FORMATION_CODE'></span>
                                                </td>

                                                <td> 
                                                    <table class="table table-condensed table-bordered bg-white" style="margin:0px">
                                                        <tr v-for="invoice_item in item._FINANCE"><!---#order_id#--->
                                                            <!----<td width="10%">#item_inv_unit_price#</td>
                                                            <td width="10%">#item_inv_fee#</td>--->
                                                            <td width="15%">{{invoice_item._ORDER_ITEM_MODE_NAME}}</td>
                                                            <td width="15%"><strong>{{invoice_item._ITEM_INV_TOTAL}}&euro;</strong></td>
                                                            <!---<td width="20%"><small><cfif opca_id eq "0">DIRECT<cfelse>#opca_name#</cfif> </small></td>--->
                                                        </tr>
                                                    </table>
                                                </td>

                                                <td>{{formatDate(item.ORDER_START)}}</td>
                                                <td>{{formatDate(item.ORDER_END)}}</td>

                                                <td>
                                                    <td align="center">
                                                        <a type="button" @click="btn_read_order(item.ORDER_ID)" class="btn btn-sm btn-info"><i class="fa-light fa-eye"></i></a>
                                                        <a type="button" @click="btn_edit_order(item.ORDER_ID, item.ACCOUNT_ID)"class="btn btn-sm btn-info"><i class="fa-light fa-edit"></i></a>
                                                    
                                                        <!--- <cfif isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1">
                                                            <a type="button" class="delete_order btn btn-sm btn-info" id="delete_order_#order_id#"><i class="fa-light fa-trash-alt"></i></a>
                                                        </cfif> --->
                                                    </td>
                                                </td>
                                            </tr>		
                                        </tbody>
                                    
                                    </table>

                                </div>
                              </v-col>

                              <v-row>
                                <v-pagination
                                v-model="currentPageBottom"
                                :length="rows"
                                :per-page="perPage"
                                :total-visible="9"
                                aria-controls="my-table"
                                ></v-pagination>
                              </v-row>

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
<cfinclude template="./incl/incl_scripts_param.cfm">


<script>

    var app = new Vue({
        el: "#vue-app",
        vuetify: new Vuetify(),
        
      data() {
          return {
                menu: false,
                menu2: false,
                date_begin: null,
                date_end: null,

                select_provider: [],
                item_provider: [<cfoutput query="get_provider">{ id: #provider_id#, name: "#provider_name#" },</cfoutput>],

                select_status_finance: [],
                item_status_finance: [<cfoutput query="get_status_finance">{ id: #status_finance_id#, name: "#status_finance_name#" },</cfoutput>],

                select_finance: [],
                item_finance: [<cfoutput query="get_context_finance">{ id: #context_id#, name: "#context_name#" },</cfoutput>],

                select_method: [],
                item_method: [<cfoutput query="get_tp_method">{ id: #method_id#, name: "#method_name_fr#" },</cfoutput>],

                select_manager: [],
                item_manager: [],

                select_year: ["<cfoutput>#year#</cfoutput>"],
                item_year: ["2018","2019","2020","2021","2022","2023"],

                
                perPage: 50,
                currentPage: 1,
                currentPageTop: 1,
                currentPageBottom: 1,
                rows: 0,
                total: 0,
                result_nb: 0,

                sortKey: 'ORDER_ID',
                reverse: 1,
                
                search: '',

                initaldata: [],
                data: []
          };
      },
      methods: {
        initdata (data, full = 0) {
            let tmp = [];

            for (let index = 0; index < data.length; index++) {
                const element = data[index];
                

                if (!tmp[element['ORDER_ID']]){
                    element._LEARNER = {};
                    element._FINANCE = {};
                    element._PACK = [];

                    element._LEARNER[element['LEARNER_ID']] = {
                        _USER_FIRSTNAME: element.USER_FIRSTNAME,
                        _USER_NAME: element.USER_NAME,
                        _USER_ID: element.LEARNER_ID,
                        _ACCOUNT_NAME: element.ACCOUNT_NAME,
                        _ACCOUNT_ID: element.ACCOUNT_ID
                    }

                    element._FINANCE[element['ORDER_ITEM_MODE_ID']] = {
                        _ORDER_ITEM_MODE_ID: element.ORDER_ITEM_MODE_ID,
                        _ORDER_ITEM_MODE_NAME: element.ORDER_ITEM_MODE_NAME,
                        _ITEM_INV_TOTAL: element.ITEM_INV_TOTAL
                    }


                    tmp[element['ORDER_ID']] = element;

                } else {
                    if(!tmp[element['ORDER_ID']]._LEARNER[element['LEARNER_ID']]) {
                        tmp[element['ORDER_ID']]._LEARNER[element['LEARNER_ID']] = {
                            _USER_FIRSTNAME: element.USER_FIRSTNAME,
                            _USER_NAME: element.USER_NAME,
                            _USER_ID: element.LEARNER_ID,
                            _ACCOUNT_NAME: element.ACCOUNT_NAME,
                            _ACCOUNT_ID: element.ACCOUNT_ID
                        }
                    }
                    if(!tmp[element['ORDER_ID']]._FINANCE[element['ORDER_ITEM_MODE_ID']]) {
                        tmp[element['ORDER_ID']]._FINANCE[element['ORDER_ITEM_MODE_ID']] = {
                            _ORDER_ITEM_MODE_ID: element.ORDER_ITEM_MODE_ID,
                            _ORDER_ITEM_MODE_NAME: element.ORDER_ITEM_MODE_NAME,
                            _ITEM_INV_TOTAL: element.ITEM_INV_TOTAL
                        }
                    }
                }

                tmp[element['ORDER_ID']]._PACK.push({
                    _METHOD_ID: element.METHOD_ID,
                    _HOUR_QTY: element.HOUR_QTY,
                    _ELEARNING_ID: element.ELEARNING_ID,
                    _CERTIF_ID: element.CERTIF_ID,
                    _DESTINATION_ID: element.DESTINATION_ID
                })
                // this.data[element['ORDER_ID']].push(element)
            }

            let tmp_2 = [];
            tmp.forEach(element => {
                if (!this.item_manager.includes(element.MANAGER_FIRSTNAME)) this.item_manager.push(element.MANAGER_FIRSTNAME)
                tmp_2.push(element);
            });

            if (full == 0) {
                this.data = tmp_2;
            }
            this.initaldata = tmp_2;

            console.log(this.data);
        },
        async callapi () {
              // const axios = require('axios');
            try {
                let formData = new FormData();
                formData.append('report', 'finance_order_list_get');
                formData.append('option', '{"y_id": "23"}');

                const response = await axios.post('api/report/report_get.cfc?method=oget_report_json', formData);

                this.initdata(response.data);

                formData = new FormData();
                formData.append('report', 'finance_order_list_get');
                axios.post('api/report/report_get.cfc?method=oget_report_json', formData).then(response => {
                    console.log(response)
                    this.initdata(response.data, 1);
                })

            } catch (error) {
                console.log(error);
            }
        },

        updateRow(nb) {
            this.rows = Math.ceil(nb / this.perPage);
            this.total = nb;
        },

        sortBy: function(sortKey) {
            this.reverse = (this.sortKey == sortKey) ? this.reverse * -1 : 1;
            this.sortKey = sortKey;
        },

        async submit () {
              try {

                let tmp = this.initaldata;

                // console.log(this.select_method, this.select_finance, this.select_manager, this.select_year, this.date_begin, this.date_end)

                if (this.date_begin && this.date_end) {
                    tmp = tmp.filter((item) => {
                        var date = new Date(item.ORDER_END).toISOString().slice(0, 10);
                        return (date >= this.date_begin && date <= this.date_end);
                    });
                }
                
                if(this.select_provider.length > 0) {
                    tmp = tmp.filter((item) => {
                        return (
                            this.select_provider.includes(item.PROVIDER_ID)
                        );
                    });
                }

                if(this.select_status_finance.length > 0) {
                    tmp = tmp.filter((item) => {
                        return (
                            this.select_status_finance.includes(item.STATUS_FINANCE_ID)
                        );
                    });
                }

                if(this.select_finance.length > 0) {
                    tmp = tmp.filter((item) => {
                        return (
                            this.select_finance.includes(item.CONTEXT_ID)
                        );
                    });
                }

                if(this.select_manager.length > 0) {
                    tmp = tmp.filter((item) => {
                        return (
                            this.select_manager.includes(item.MANAGER_FIRSTNAME)
                        );
                    });
                }

                if(this.select_year.length > 0) {
                    tmp = tmp.filter((item) => {
                        return (
                            this.select_year.includes(item.ORDER_YEAR)
                        );
                    });
                }


                if(this.select_method.length > 0) {
                    tmp = tmp.filter((item) => {
                        
                        let tpm_method = 0;

                        for (let index = 0; index < item._PACK.length; index++) {
                            const element = item._PACK[index];
                            if(this.select_method.includes(element._METHOD_ID)) tpm_method = 1
                        }
                        
                        return tpm_method;
                    });
                }

                this.data = tmp;
              } catch (error) {
                  console.error(error);
              }
        },
        formatDate(date) {
            if(date) return moment(new Date(date)).format('DD/MM/YYYY');
            return "-";
        },
        btn_read_order(o_id){
            // console.log(o_id);
            $("#window_item_xl").modal('show');
            $('#window_item_xl').modal({keyboard: true});
            $('#modal_title_xl').text("Edition order "+o_id);
            $('#modal_body_xl').load("modal_window_order_read.cfm?o_id="+o_id, function(){});
        },
        btn_edit_order(o_id, a_id){
            // console.log(o_id);
            $("#window_item_xl").modal('show');
            $('#window_item_xl').modal({keyboard: true, backdrop: "static"});
            $('#modal_title_xl').text("Order - " + o_id);
            $('#modal_body_xl').empty();
            $('#modal_body_xl').load("modal_window_order_create.cfm?a_id="+a_id+"&o_id="+o_id, function() {});
        }
      },
      computed: {
        filteredData() {
            let tmp = this.data;

            if (this.currentPage != this.currentPageTop) {
                this.currentPage = this.currentPageTop;
                this.currentPageBottom = this.currentPageTop;
            } else if (this.currentPage != this.currentPageBottom) {
                this.currentPage = this.currentPageBottom;
                this.currentPageTop = this.currentPageBottom;
            }

            if (this.search) {
                this.currentPage = 1;
                this.currentPageTop = 1;
                this.currentPageBottom = 1;
                tmp = tmp.filter((item) => {
                return (
                    item.ACCOUNT_NAME.toLowerCase().includes(this.search.toLowerCase())
                    || item.ORDER_REF.toLowerCase().includes(this.search.toLowerCase())
                );
                });
            }

            this.result_nb=tmp.length;

            this.updateRow(tmp.length);

            tmp.sort((a,b) => {
                if (a[this.sortKey] < b[this.sortKey])
                    return this.reverse;
                if (a[this.sortKey] > b[this.sortKey])
                    return this.reverse * -1;
                return 0;
            })

            tmp = tmp.slice(
                (this.currentPage - 1) * this.perPage,
                this.currentPage * this.perPage
            );
            // console.log(tmp);
            return tmp;

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