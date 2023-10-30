<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,4,5,7,8,9,12,13">
<cfinclude template="./incl/incl_secure.cfm">	

</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>

</head>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Chart example">
		
		<cfinclude template="./incl/incl_nav.cfm">
			
		<div class="content">
            <div class="card">
                <div class="card-body">
                    <div class="w-100">
                        <h5 class="d-inline"><i class="fa-thin fa-list-check text-red fa-lg mr-2"></i>General Assessment</h5>
                        <hr class="border-danger mb-1 mt-2">
                    </div>

                    <div class="row mt-2">
                        <div class="col-lg-5 col-md-6">
                            <canvas id="myChart" class="w-100"></canvas>
                        </div>
                        <div class="col-lg-7 col-md-6">
                            
                            <table>
                                <tr align="center" class="level_presentation_3" id="level_presentation_3_9" style="">
        
                                    <td class="bg-light text-muted" width="150">
                                        <i class="fa-thin fa-comments fa-2x"></i><br>Speaking
                                    </td>
            
                                    <td align="left">	<img src="https://lms.wefitgroup.com/assets/img_sublevel/4_plain.svg" class="subskill_img cursored" id="img_subskill_3_4" width="40">
                                        <strong>Expression écrite / Écrire</strong>
                                        <p>
                                            Can easily give brief reasons for opinions<br>Can tell a story or explain narrative of book/film with ease
                                             Can easily discuss family, hobbies, work, travel and news/current affairs
                                        </p>
                                    </td>
                                </tr>

                                <tr align="center" class="level_presentation_3" id="level_presentation_3_9" style="">
        
                                    <td class="bg-light text-muted" width="150">
                                        <i class="fa-thin fa-edit fa-2x" aria-hidden="true"></i><br>Writing
                                    </td>
            
                                    <td align="left">	<img src="https://lms.wefitgroup.com/assets/img_sublevel/7_plain.svg" class="subskill_img cursored" id="img_subskill_3_4" width="40">
                                        <strong>Expression orale / Parler</strong>
                                        <p>
                                            Can read short simple texts with some difficulty
                                            Find information in ads, catalogues and timetables with some difficulty Can understand short simple personal letters with some difficulty
                                        </p>
                                    </td>
            
                                </tr>

                                
                                <tr align="center" class="level_presentation_3" id="level_presentation_3_9" style="">
        
                                    <td class="bg-light text-muted" width="150">
                                        <i class="fa-thin fa-books fa-2x" aria-hidden="true"></i><br>Reading
                                    </td>
            
                                    <td align="left">	<img src="https://lms.wefitgroup.com/assets/img_sublevel/12_plain.svg" class="subskill_img cursored" id="img_subskill_3_4" width="40">
                                        <strong>Compréhension écrite / Lire</strong>
                                        <p>
                                            <ul>
                                            <li>Vous pouvez comprendre des phrases isolées et des expressions fréquemment utilisées en relation avec des domaines immédiats de priorité (par exemple, informations personnelles et familiales simples, achats, environnement proche, travail).</li>
                                        </ul> 
                                        </p>
                                    </td>
            
                                </tr>

                                <tr align="center" class="level_presentation_3" id="level_presentation_3_9" style="">
        
                                    <td class="bg-light text-muted" width="150">
                                        <i class="fa-thin fa-head-side-headphones fa-2x" aria-hidden="true"></i><br>Listening
                                    </td>
            
                                    <td align="left">	<img src="https://lms.wefitgroup.com/assets/img_sublevel/9_plain.svg" class="subskill_img cursored" id="img_subskill_3_4" width="40">
                                        <strong>Compréhension orale / Écouter</strong>
                                        <p>
                                            <ul>
                                            <li>Vous pouvez communiquer lors de tâches simples et habituelles ne demandant qu'un échange d'informations simple et direct sur des sujets familiers et habituels.</li>
                                            <li>Vous pouvez décrire avec des moyens simples votre formation, votre environnement immédiat et évoquer des sujets qui correspondent à des besoins immédiats.</li>
                                            </ul> 
                                        </p>
                                    </td>
            
                                </tr>



                            </table>
                            
                        </div>
                        
                    </div>		
                    
                </div>	
                		
			</div>

            <div class="card-deck">
                
                <div class="card">
                    <div class="card-body">

                        <div class="w-100">
                            <h5 class="d-inline"><i class="fa-thin fa-language text-red fa-lg mr-2"></i>Global skills</h5>
                            <hr class="border-danger mb-1 mt-2">
                        </div>

                        <div class="p-2">
                            <div class="mt-2 collapse show" id="div_global" aria-labelledby="skill_global" data-parent="#skill_accordion" style="">
                                <table class="table table-sm bg-white">
                                    <tbody><tr>
                                        <th>Skill</th>
                                        <th>Level</th>
                                        <th>Activity</th>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                                <label>Expressing ideas</label>
                                
                                        </td>
                                        <td>
                                            <div id="rating_subskill_3" class="collapse show">
                                            
                                                <div id="subskill_3_1" class="p-1 ratingsubskill float-left" name="3" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/1_plain.svg" class="subskill_img cursored" id="img_subskill_3_1" width="30">
                                                    <input type="radio" name="subskill_3" class="form_3" id="input_3_1" value="1" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="subskill_3_2" class="p-1 ratingsubskill float-left" name="3" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/2_plain.svg" class="subskill_img cursored" id="img_subskill_3_2" width="30">
                                                    <input type="radio" name="subskill_3" class="form_3" id="input_3_2" value="2" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="subskill_3_3" class="p-1 ratingsubskill float-left" name="3" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/3_plain.svg" class="subskill_img cursored" id="img_subskill_3_3" width="30">
                                                    <input type="radio" name="subskill_3" class="form_3" id="input_3_3" value="3" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="subskill_3_4" class="p-1 ratingsubskill float-left" name="3" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/4_plain.svg" class="subskill_img cursored" id="img_subskill_3_4" width="30">
                                                    <input type="radio" name="subskill_3" class="form_3" id="input_3_4" value="4" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="subskill_3_5" class="p-1 ratingsubskill float-left" name="3" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/5_plain.svg" class="subskill_img cursored" id="img_subskill_3_5" width="30">
                                                    <input type="radio" name="subskill_3" class="form_3" id="input_3_5" value="5" style="visibility: hidden" required="">
                                                </div>
                                            
                                            </div>
                                        </td>
                                        <td>
                                            2 dedicated lessons / 1h30 / 4 notations
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <label>Describing</label>
                                        </td>
                                        <td>
                                            <div id="rating_subskill_4" class="collapse show">
                                            
                                                <div id="subskill_4_1" class="p-1 ratingsubskill float-left" name="4" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/1_plain.svg" class="subskill_img cursored" id="img_subskill_4_1" width="30">
                                                    <input type="radio" name="subskill_4" class="form_4" id="input_4_1" value="1" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="subskill_4_2" class="p-1 ratingsubskill float-left" name="4" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/2_plain.svg" class="subskill_img cursored" id="img_subskill_4_2" width="30">
                                                    <input type="radio" name="subskill_4" class="form_4" id="input_4_2" value="2" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="subskill_4_3" class="p-1 ratingsubskill float-left" name="4" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/3_plain.svg" class="subskill_img cursored" id="img_subskill_4_3" width="30">
                                                    <input type="radio" name="subskill_4" class="form_4" id="input_4_3" value="3" style="visibility: hidden" required="">
                                                </div>
                                            
                                            </div>
                                        </td>
                                        <td>

                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <label>Écrire</label>
                                        </td>
                                        <td>
                                            <div id="rating_subskill_5" class="collapse show">
                                            
                                                <div id="subskill_5_1" class="p-1 ratingsubskill float-left" name="5" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/1_plain.svg" class="subskill_img cursored" id="img_subskill_5_1" width="30">
                                                    <input type="radio" name="subskill_5" class="form_5" id="input_5_1" value="1" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="subskill_5_2" class="p-1 ratingsubskill float-left" name="5" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/2_plain.svg" class="subskill_img cursored" id="img_subskill_5_2" width="30">
                                                    <input type="radio" name="subskill_5" class="form_5" id="input_5_2" value="2" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="subskill_5_3" class="p-1 ratingsubskill float-left" name="5" style="max-height: 30px;">
                                                    <img src="https://lms.wefitgroup.com/assets/img_sublevel/3_plain.svg" class="subskill_img cursored" id="img_subskill_5_3" width="30">
                                                    <input type="radio" name="subskill_5" class="form_5" id="input_5_3" value="3" style="visibility: hidden" required="">
                                                </div>
                                            
                                            </div>
                                        </td>
                                        <td>

                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <label>Debating</label>
                                        </td>
                                        <td>
                                            <div id="rating_subskill_6">
                                            
                                                N/A
                                            
                                            </div>
                                        </td>   <td>

                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <label>Reporting</label>
                                        </td>
                                        <td>
                                            <div id="rating_subskill_6">
                                            
                                                N/A
                                            
                                            </div>
                                        </td>
                                        <td>

                                        </td>
                                    </tr>
                                    

                                </tbody></table>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="card">
                    <div class="card-body">

                        <div class="w-100">
                            <h5 class="d-inline"><i class="fa-thin fa-earth-europe text-red fa-lg mr-2"></i>General English</h5>
                            <hr class="border-danger mb-1 mt-2">
                        </div>

                        <table class="table table-sm bg-white">
                            <tr>
                                <td class="w-25">
                                    <img class="w-100" src="./assets/img_keyword/64.jpg">
                                </td>
                                <td>    
                                    <strong>Medecine</strong>
                                    <br>
                                    You spent 2h25 talking of this subject, in 3 different lessons with Robert Y, Adam & Kirsteen


                                </td>
                            </tr>
                            <tr>
                                <td class="w-25">
                                    <img class="w-100" src="./assets/img_keyword/68.jpg">
                                </td>
                                <td>    
                                    <strong>General Culture</strong>
                                    <br>
                                    You spent 2h talking of this subject, in 2 different lessons with Paul & Tom


                                </td>
                            </tr>
                        </table>

                    </div>
                </div>

            
            </div>


            <div class="card-deck mt-3">
                
                <div class="card">
                    <div class="card-body">

                        <div class="w-100">
                            <h5 class="d-inline"><i class="fa-thin fa-briefcase text-red fa-lg mr-2"></i>Business skills</h5>
                            <hr class="border-danger mb-1 mt-2">
                        </div>
                        
                        <div class="p-2">

                            <table class="table table-sm bg-white">
                                <tbody><tr>
                                    <th>Core skills</th>
                                    <th>Notation</th>
                                </tr>
                                
                                <tr>
                                    <td>
                                        <div class="label">Résolution de problèmes</label>
                                    </td>
                                    <td>
                                        <div id="rating_kw_16" class="collapse show">
                                        
                                            <div id="kw_16_1" class="p-1 ratingkey float-left" name="16" style="max-height: 30px;">
                                                
                                                <img src="https://lms.wefitgroup.com/assets/img_smile/3.svg" class="smiley_img cursored" id="img_kw_16_1" width="30">
                                                <input type="radio" name="kw_16" class="form_16" id="input_16_1" value="1" style="visibility: hidden" required="">
                                            </div>
                                        
                                            <div id="kw_16_2" class="p-1 ratingkey float-left" name="16" style="max-height: 30px;">
                                                
                                                <img src="https://lms.wefitgroup.com/assets/img_smile/3.svg" class="smiley_img cursored" id="img_kw_16_2" width="30">
                                                <input type="radio" name="kw_16" class="form_16" id="input_16_2" value="2" style="visibility: hidden" required="">
                                            </div>
                                        
                                            <div id="kw_16_3" class="p-1 ratingkey float-left" name="16" style="max-height: 30px;">
                                                
                                                <img src="https://lms.wefitgroup.com/assets/img_smile/3.svg" class="smiley_img cursored" id="img_kw_16_3" width="30">
                                                <input type="radio" name="kw_16" class="form_16" id="input_16_3" value="3" style="visibility: hidden" required="">
                                            </div>
                                        
                                            <div id="kw_16_4" class="p-1 ratingkey float-left" name="16" style="max-height: 30px;">
                                                
                                                <img src="https://lms.wefitgroup.com/assets/img_smile/3_nb.svg" class="smiley_img cursored" id="img_kw_16_4" width="30">
                                                <input type="radio" name="kw_16" class="form_16" id="input_16_4" value="4" style="visibility: hidden" required="">
                                            </div>
                                        
                                            <div id="kw_16_5" class="p-1 ratingkey float-left" name="16" style="max-height: 30px;">
                                                
                                                <img src="https://lms.wefitgroup.com/assets/img_smile/3_nb.svg" class="smiley_img cursored" id="img_kw_16_5" width="30">
                                                <input type="radio" name="kw_16" class="form_16" id="input_16_5" value="5" style="visibility: hidden" required="">
                                            </div>
                                            
                                        </div>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td>
                                        <div class="label">Négociation</label>
                                    </td>
                                    <td>
                                        <div id="rating_kw_14" class="collapse show">
                                        
                                                <div id="kw_14_1" class="p-1 ratingkey float-left" name="14" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1.svg" class="smiley_img cursored" id="img_kw_14_1" width="30">
                                                    <input type="radio" name="kw_14" class="form_14" id="input_14_1" value="1" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="kw_14_2" class="p-1 ratingkey float-left" name="14" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_kw_14_2" width="30">
                                                    <input type="radio" name="kw_14" class="form_14" id="input_14_2" value="2" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="kw_14_3" class="p-1 ratingkey float-left" name="14" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_kw_14_3" width="30">
                                                    <input type="radio" name="kw_14" class="form_14" id="input_14_3" value="3" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="kw_14_4" class="p-1 ratingkey float-left" name="14" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_kw_14_4" width="30">
                                                    <input type="radio" name="kw_14" class="form_14" id="input_14_4" value="4" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="kw_14_5" class="p-1 ratingkey float-left" name="14" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_kw_14_5" width="30">
                                                    <input type="radio" name="kw_14" class="form_14" id="input_14_5" value="5" style="visibility: hidden" required="">
                                                </div>
                                            
                                        </div>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td>
                                        <div class="label">Bien être au travail</label>
                                    </td>
                                    <td>
                                        <div id="rating_kw_93" class="collapse show">
                                        
                                                <div id="kw_93_1" class="p-1 ratingkey float-left" name="93" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1.svg" class="smiley_img cursored" id="img_kw_93_1" width="30">
                                                    <input type="radio" name="kw_93" class="form_93" id="input_93_1" value="1" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="kw_93_2" class="p-1 ratingkey float-left" name="93" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_kw_93_2" width="30">
                                                    <input type="radio" name="kw_93" class="form_93" id="input_93_2" value="2" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="kw_93_3" class="p-1 ratingkey float-left" name="93" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_kw_93_3" width="30">
                                                    <input type="radio" name="kw_93" class="form_93" id="input_93_3" value="3" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="kw_93_4" class="p-1 ratingkey float-left" name="93" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_kw_93_4" width="30">
                                                    <input type="radio" name="kw_93" class="form_93" id="input_93_4" value="4" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="kw_93_5" class="p-1 ratingkey float-left" name="93" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_kw_93_5" width="30">
                                                    <input type="radio" name="kw_93" class="form_93" id="input_93_5" value="5" style="visibility: hidden" required="">
                                                </div>
                                            
                                        </div>
                                    </td>
                                </tr>
                                
                            </tbody></table>

                        </div>

                        <div class="w-100">
                            <h5 class="d-inline"><i class="fa-thin fa-briefcase text-red fa-lg mr-2"></i>Speciality</h5>
                            <hr class="border-danger mb-1 mt-2">
                        </div>

                        <div class="p-2">
                            <table class="table table-sm bg-white">
                                <tr>
                                    <td class="w-25">
                                        <img class="card-img-top" src="./assets/img_keyword/40.jpg"> 
                                    </td>
                                    <td>    
                                        <strong>RH</strong>
                                        <br>
                                        You spent 2h25 talking of this subject, in 3 different lessons with Robert Y, Adam & Kirsteen
    
    
                                    </td>
                                </tr>
                                <tr>
                                    <td class="w-25">
                                        <img class="card-img-top" src="./assets/img_keyword/96.jpg"> 
                                    </td>
                                    <td>    
                                        <strong>Compta</strong>
                                        <br>
                                        You spent 2h talking of this subject, in 2 different lessons with Paul & Tom
    
    
                                    </td>
                                </tr>
                            </table>

                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">

                        <div class="w-100">
                            <h5 class="d-inline"><i class="fa-thin fa-spell-check text-red fa-lg mr-2"></i>Grammar & vocabulary
                                <img src="https://lms.wefitgroup.com/assets/img_sublevel/13_plain.svg" class="subskill_img cursored" id="img_subskill_3_4" width="40">
                            
                            </h5>
                            <hr class="border-danger mb-1 mt-2">
                        </div>

                        <br>

                        <table class="table table-sm bg-white">
                            <tbody><tr>
                                <th>Vocabulary list</th>
                                <th>Time spent</th>
                            </tr>
                            
                            <tr>
                                <td>
                                    En ville
                                </td>
                                <td>
                                    14min
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    Vêtements / Mode
                                </td>
                                <td>
                                    12 min
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    Chez le docteur
                                </td>
                                <td>
                                    15 min
                                </td>
                            </tr>
                            
                        </tbody></table>


                        <div class="w-100">
                            <h5 class="d-inline"><i class="fa-thin fa-spell-check text-red fa-lg mr-2"></i>Language points</h5>
                            <hr class="border-danger mb-1 mt-2">
                        </div>

                        <table class="table table-sm bg-white">
                            <tbody><tr>
                                <th>Language points</th>
                                <th>Mastery level by trainer</th>
                                <th>Mastery level by EL</th>
                            </tr>
                            
                            <tr>
                                <td>
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input switch_mapping" id="custom_mapping_591">
                                        <label class="custom-control-label mb-0 pb-0" for="custom_mapping_591">Adjectives</label>
                                    </div>
                                </td>
                                <td>
                                    <div id="rating_mapping_591" class="collapse show">
                                        
                                                <div id="mapping_591_1" class="p-1 ratingkey float-left" name="591" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/1_nb.svg" class="smiley_img cursored" id="img_mapping_591_1" width="30">
                                                    <input type="radio" name="mapping_591" class="form_591" id="input_591_1" value="1" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_591_2" class="p-1 ratingkey float-left" name="591" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/2_nb.svg" class="smiley_img cursored" id="img_mapping_591_2" width="30">
                                                    <input type="radio" name="mapping_591" class="form_591" id="input_591_2" value="2" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_591_3" class="p-1 ratingkey float-left" name="591" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/3_nb.svg" class="smiley_img cursored" id="img_mapping_591_3" width="30">
                                                    <input type="radio" name="mapping_591" class="form_591" id="input_591_3" value="3" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_591_4" class="p-1 ratingkey float-left" name="591" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/4_nb.svg" class="smiley_img cursored" id="img_mapping_591_4" width="30">
                                                    <input type="radio" name="mapping_591" class="form_591" id="input_591_4" value="4" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_591_5" class="p-1 ratingkey float-left" name="591" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/5_nb.svg" class="smiley_img cursored" id="img_mapping_591_5" width="30">
                                                    <input type="radio" name="mapping_591" class="form_591" id="input_591_5" value="5" style="visibility: hidden" required="">
                                                </div>
                                            
                                    </div>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input switch_mapping" id="custom_mapping_2">
                                        <label class="custom-control-label mb-0 pb-0" for="custom_mapping_2">Articles</label>
                                    </div>
                                </td>
                                <td>
                                    <div id="rating_mapping_2" class="collapse show">
                                        
                                                <div id="mapping_2_1" class="p-1 ratingkey float-left" name="2" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/5.svg" class="smiley_img cursored" id="img_mapping_2_1" width="30">
                                                    <input type="radio" name="mapping_2" class="form_2" id="input_2_1" value="1" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_2_2" class="p-1 ratingkey float-left" name="2" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/5.svg" class="smiley_img cursored" id="img_mapping_2_2" width="30">
                                                    <input type="radio" name="mapping_2" class="form_2" id="input_2_2" value="2" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_2_3" class="p-1 ratingkey float-left" name="2" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/5.svg" class="smiley_img cursored" id="img_mapping_2_3" width="30">
                                                    <input type="radio" name="mapping_2" class="form_2" id="input_2_3" value="3" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_2_4" class="p-1 ratingkey float-left" name="2" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/5.svg" class="smiley_img cursored" id="img_mapping_2_4" width="30">
                                                    <input type="radio" name="mapping_2" class="form_2" id="input_2_4" value="4" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_2_5" class="p-1 ratingkey float-left" name="2" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/5.svg" class="smiley_img cursored" id="img_mapping_2_5" width="30">
                                                    <input type="radio" name="mapping_2" class="form_2" id="input_2_5" value="5" style="visibility: hidden" required="">
                                                </div>
                                            
                                    </div>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input switch_mapping" id="custom_mapping_52">
                                        <label class="custom-control-label mb-0 pb-0" for="custom_mapping_52">Numbers, dates, months</label>
                                    </div>
                                </td>
                                <td>
                                    <div id="rating_mapping_52" class="collapse show">
                                        
                                                <div id="mapping_52_1" class="p-1 ratingkey float-left" name="52" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/4.svg" class="smiley_img cursored" id="img_mapping_52_1" width="30">
                                                    <input type="radio" name="mapping_52" class="form_52" id="input_52_1" value="1" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_52_2" class="p-1 ratingkey float-left" name="52" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/4.svg" class="smiley_img cursored" id="img_mapping_52_2" width="30">
                                                    <input type="radio" name="mapping_52" class="form_52" id="input_52_2" value="2" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_52_3" class="p-1 ratingkey float-left" name="52" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/4.svg" class="smiley_img cursored" id="img_mapping_52_3" width="30">
                                                    <input type="radio" name="mapping_52" class="form_52" id="input_52_3" value="3" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_52_4" class="p-1 ratingkey float-left" name="52" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/4.svg" class="smiley_img cursored" id="img_mapping_52_4" width="30">
                                                    <input type="radio" name="mapping_52" class="form_52" id="input_52_4" value="4" style="visibility: hidden" required="">
                                                </div>
                                            
                                                <div id="mapping_52_5" class="p-1 ratingkey float-left" name="52" style="max-height: 30px;">
                                                    
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/4_nb.svg" class="smiley_img cursored" id="img_mapping_52_5" width="30">
                                                    <input type="radio" name="mapping_52" class="form_52" id="input_52_5" value="5" style="visibility: hidden" required="">
                                                </div>
                                            
                                    </div>
                                </td>
                            </tr>
                            
                            
                        </tbody></table>

                        
                    </div>
                </div>

            </div>





                    <!--- <div class="col-lg-3 col-md-2 col-sm-3">
                        <div class="card card_module">
                            <a class="btn_action" id="act-2_2_1_1">
                                
                                <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:100px">
                                    <h6 class="text-center mt-2" style="font-size:20px !important">Biologie</h6>
                                    <p align="center">
        
                                        
        
                                    </p>
                                </div>
                            </a>
                        </div>
                    </div>
                        
                    <div class="card card_module">
                        <a class="btn_action" id="act-2_2_1_1">
                            
                            <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:100px">
                                <h6 class="text-center mt-2" style="font-size:20px !important">Culture générale</h6>
                                <p align="center">
        
                                    
        
                                </p>
                            </div>
                        </a>
                    </div> --->

            
            
				
		</div>
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<script>
$(document).ready(function() {
	
	const data = {
    labels: [
        'Writing',
        'Reading',
        'Listening',
        'Speaking : Production',
        'Speaking : Interaction'
    ],
    datasets: [{
        label: 'My First Dataset',
        data: [40, 59, 90, 81, 56],
        fill: true,
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        borderColor: 'rgb(255, 99, 132)',
        pointBackgroundColor: 'rgb(255, 99, 132)',
        pointBorderColor: '#fff',
        pointHoverBackgroundColor: '#fff',
        pointHoverBorderColor: 'rgb(255, 99, 132)',
        tension:0
    },
    {
        label: 'B1',
        data: [50, 50, 50, 50, 50],
        fill: true,
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        borderColor: 'rgb(54, 162, 235)',
        pointBackgroundColor: 'rgb(54, 162, 235)',
        pointBorderColor: '#fff',
        pointHoverBackgroundColor: '#fff',
        pointHoverBorderColor: 'rgb(54, 162, 235)'
    },
    {
        label: 'B2',
        data: [70, 70, 70, 70, 70],
        fill: true,
        backgroundColor: 'rgba(112, 120, 54, 0.2)',
        borderColor: 'rgb(112, 120, 54)',
        pointBackgroundColor: 'rgb(112, 120, 54)',
        pointBorderColor: '#fff',
        pointHoverBackgroundColor: '#fff',
        pointHoverBorderColor: 'rgb(112, 120, 54)'
    }
    <!---, {
        label: 'My Second Dataset',
        data: [28, 48, 40, 19, 96, 27, 100],
        fill: true,
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        borderColor: 'rgb(54, 162, 235)',
        pointBackgroundColor: 'rgb(54, 162, 235)',
        pointBorderColor: '#fff',
        pointHoverBackgroundColor: '#fff',
        pointHoverBorderColor: 'rgb(54, 162, 235)'
    }--->]
    };

    const ctx = document.getElementById('myChart');

    new Chart(ctx, {
        type: 'radar',
        data: data,
        options: {
            scales: {
                y: {
                beginAtZero: true
                }
            },
            plugins: {
                legend: {
                    display: false,
                    labels: {
                        color: 'rgb(255, 99, 132)'
                    }
                }
            }
        }
    });
})
</script>

</body>
</html>
