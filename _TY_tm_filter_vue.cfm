<!DOCTYPE html>
    
<cfsilent>

<cfquery name="get_language_taught" datasource="#SESSION.BDDSOURCE#">
        SELECT DISTINCT t.user_id, t.formation_id, COUNT(t.formation_id) AS count, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation f
        INNER JOIN user_teaching t ON t.formation_id = f.formation_id
        LEFT JOIN user u ON u.user_id = t.user_id
        LEFT JOIN user_profile p ON p.profile_id = u.profile_id
        WHERE u.profile_id = 4 
        AND u.user_status_id = 4
        GROUP BY t.formation_id
        HAVING COUNT(*)>1
        ORDER BY formation_name

</cfquery>

<cfquery name="get_language_spoken" datasource="#SESSION.BDDSOURCE#">
        SELECT DISTINCT t.user_id, t.formation_id, COUNT(t.formation_id) AS count, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation f
        INNER JOIN user_speaking t ON t.formation_id = f.formation_id
        LEFT JOIN user u ON u.user_id = t.user_id
        LEFT JOIN user_profile p ON p.profile_id = u.profile_id
        WHERE u.profile_id = 4 
        AND u.user_status_id = 4
        GROUP BY t.formation_id
        HAVING COUNT(*)>1
        ORDER BY formation_name
</cfquery>


<cfquery name="get_accent_spoken" datasource="#SESSION.BDDSOURCE#">
        SELECT formation_accent_id, formation_accent_name_#SESSION.LANG_CODE# as formation_accent_name, lfa.formation_id, lf.formation_name_#SESSION.LANG_CODE# as formation_name FROM lms_formation_accent lfa
        LEFT JOIN lms_formation lf ON lf.formation_id = lfa.formation_id
        ORDER BY formation_name
</cfquery>

<cfquery name="get_user_personality" datasource="#SESSION.BDDSOURCE#">
        SELECT perso_id, perso_name_#SESSION.LANG_CODE# as perso_name FROM user_personality_index
        ORDER BY perso_name
</cfquery>

<cfquery name="get_lms_business_area" datasource="#SESSION.BDDSOURCE#">
        SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 WHERE keyword_cat_id = 2
        ORDER BY keyword_name
</cfquery>

<cfquery name="get_lms_level" datasource="#SESSION.BDDSOURCE#">
        SELECT level_id, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level
        ORDER BY level_name
</cfquery>
<cfquery name="get_lms_skills" datasource="#SESSION.BDDSOURCE#">
        SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 WHERE keyword_cat_id = 5
        ORDER BY keyword_name
</cfquery>

<cfquery name="get_lms_badge" datasource="#SESSION.BDDSOURCE#">
        SELECT badge_id, badge_name_#SESSION.LANG_CODE# as badge_name FROM lms_badge_index
        ORDER BY badge_name
</cfquery>

<cfparam name="u_level" default="">
<cfparam name="TEACHING_CRITERIA_ID" default="">
<cfparam name="USER_NEEDS_NBTRAINER" default="">
<cfparam name="SPEAKING_CRITERIA_ID" default="">
<cfparam name="AVAIL_ID" default="">
<cfparam name="U_ID" default="">


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
      
		<cfset title_page = "test">
		<cfinclude template="./incl/incl_nav.cfm">

        
		<div class="content">
        
            <div id="vue-app">	
			
				<div class="col-md-12">
                    <v-app>
                        <v-main>
                          <v-container>
                            <form id="testsd">
                                <v-row>
                                    <v-col cols="2">
                                        <v-select
                                            v-model="select_language_taught"
                                            :items="item_language_taught"
                                            item-text="name"
                                            item-value="id"
                                            label="Language taught"
                                            @change="onChange($event)"
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
                                                (+{{ select_language_taught.length - 1 }} autres)
                                                </span>
                                            </template>
                                        </v-select>
                                    </v-col>
                                    <v-col cols="2">
                                        <v-select
                                            v-model="select_language_spoken"
                                            :items="item_language_spoken"
                                            item-text="name"
                                            item-value="id"
                                            label="Language spoken"
                                            @change="onChange($event)"
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
                                                (+{{ select_language_spoken.length - 1 }} autres)
                                                </span>
                                            </template>
                                        </v-select>
                                    </v-col>
                                    <v-col cols="2">
                                        <v-select
                                            v-model="select_accent_spoken"
                                            :items="item_accent_spoken"
                                            item-text="name"
                                            item-value="id"
                                            label="Accent spoken"
                                            @change="onChange($event)"
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
                                                (+{{ select_language_spoken.length - 1 }} autres)
                                                </span>
                                            </template>
                                        </v-select>
                                    </v-col>
                                    <v-col cols="2">
                                        <v-select
                                            v-model="select_user_personality"
                                            :items="item_user_personality"
                                            item-text="name"
                                            item-value="id"
                                            label="User personality"
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
                                                (+{{ select_user_personality.length - 1 }} autres)
                                                </span>
                                            </template>
                                        </v-select>
                                    </v-col>
                                    <v-col cols="2">
                                        <v-select
                                            v-model="select_lms_business_area"
                                            :items="item_lms_business_area"
                                            item-text="name"
                                            item-value="id"
                                            label="Business area"
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
                                                (+{{ select_lms_business_area.length - 1 }} autres)
                                                </span>
                                            </template>
                                        </v-select>
                                    </v-col>
                                    <v-col cols="2">
                                        <v-select
                                            v-model="select_lms_level"
                                            :items="item_lms_level"
                                            item-text="name"
                                            item-value="id"
                                            label="Level"
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
                                                (+{{ select_lms_level.length - 1 }} autres)
                                                </span>
                                            </template>
                                        </v-select>
                                    </v-col>
                                    <v-col cols="2">
                                        <v-select
                                            v-model="select_lms_skills"
                                            :items="item_lms_skills"
                                            item-text="name"
                                            item-value="id"
                                            label="Skills"
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
                                                (+{{ select_lms_skills.length - 1 }} autres)
                                                </span>
                                            </template>
                                        </v-select>
                                    </v-col>
                                    <v-col cols="2">
                                        <v-select
                                            v-model="select_lms_badge"
                                            :items="item_lms_badge"
                                            item-text="name"
                                            item-value="id"
                                            label="Badge"
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
                                                (+{{ select_lms_badge.length - 1 }} autres)
                                                </span>
                                            </template>
                                        </v-select>
                                    </v-col>
                                    <v-col cols="2" >
                                        <v-btn class="mr-4" v-on:click="submit" >
                                            <!--- :disabled="invalid"  --->
                                        FILTER
                                        </v-btn>
                                    </v-col>
                                </v-row>
                            </form>
                            
                            <div class="row mt-3">
                            
                                <div class="col-md-12">
                                    <div class="card border-top border-info">
                                        
                                        <div class="card-body" id="t_lists">
                                        <template v-for="item in data">
                                            <li>{{ item }}</li>
                                        </template>
                                        </div>
                                    </div>
                                
                                </div>
                            </div>


                          </v-container>
                        </v-main>
                      </v-app>
					
				</div>
				
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
            select_language_taught: [],
            item_language_taught: [<cfoutput query="get_language_taught">{ id: #formation_id#, name: "#formation_name# (#count#)"},</cfoutput>],
            select_language_spoken: [],
            item_language_spoken: [<cfoutput query="get_language_spoken">{ id: #formation_id#, name: "#formation_name# (#count#)" },</cfoutput>],
            select_accent_spoken: [],
            item_accent_spoken: [<cfoutput query="get_accent_spoken">{ id: #formation_accent_id#, name: "#formation_accent_name#", formation_id: "#formation_id#", formation_name: "#formation_name#" },</cfoutput>],
            select_user_personality: [],
            item_user_personality: [<cfoutput query="get_user_personality">{ id: #perso_id#, name: "#perso_name#" },</cfoutput>], 
            select_lms_business_area: [],
            item_lms_business_area: [<cfoutput query="get_lms_business_area">{ id: #keyword_id#, name: "#keyword_name#" },</cfoutput>], 
            select_lms_level: [],
            item_lms_level: [<cfoutput query="get_lms_level">{ id: #level_id#, name: "#level_name#" },</cfoutput>], 
            select_lms_skills: [],
            item_lms_skills: [<cfoutput query="get_lms_skills">{ id: #keyword_id#, name: "#keyword_name#" },</cfoutput>], 
            select_lms_badge: [],
            item_lms_badge: [<cfoutput query="get_lms_badge">{ id: #badge_id#, name: "#badge_name#" },</cfoutput>],
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
        async callapi () {
              // const axios = require('axios');
            try {
                let data = new FormData()
                const response = await axios.post('_TY_tm_filter_api.cfc?method=filter', data);

                if(this.select_language_taught.length > 0) {
                    data.append('get_language_taught_id', this.select_language_taught)
                }
                if(this.select_language_spoken.length > 0) {
                    data.append('get_language_spoken_id', this.select_language_spoken)
                }
                if(this.select_accent_spoken.length > 0) {
                    data.append('get_accent_spoken_id', this.select_user_personality)
                }
                if(this.select_user_personality.length > 0) {
                    data.append('get_user_personality_id', this.select_user_personality)
                }
                if(this.select_lms_business_area.length > 0) {
                    data.append('get_lms_business_area_id', this.select_lms_business_area)
                }
                if(this.select_lms_level.length > 0) {
                    data.append('get_lms_level_id', this.select_lms_level)
                }
                if(this.select_lms_skills.length > 0) {
                    data.append('get_lms_skills_id', this.select_lms_skills)
                }
                if(this.select_lms_badge.length > 0) {
                    data.append('get_lms_badge_id', this.select_lms_badge)
                } 

                this.data = data

                axios.post('_TY_tm_filter_api.cfc?method=filter', this.data, {headers:{"Content-Type" : "application/json"}}).then(response => {
                    console.log(response)
                    //this.data = response.data.DATA
                })

            } catch (error) {
                console.error(error.response.data);
            }
        },

        async submit () {
              try {
                this.callapi()
              } catch (error) {
                  console.error(error)
              }
        },
        
        onChange(event) {
            this.callapi()
        }
      },
      computed: {
        
      },
      created() {
        this.callapi()
	  },
    });

    // createApp(app).mount('#vue-app')


</script>


</body>
</html>