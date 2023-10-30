<cfif isdefined("mp_id")>
<style>
    #modal_content_div {
  max-height: 500px; /* Adjust as needed */
  overflow: auto;
  padding: 10px;
}

#mapping_explanation_long {
  max-height: 100%;
  overflow-y: auto;
  word-wrap: break-word;
}

</style>
    
    <cfset lang=url.lang>
    <cfquery name="get_mapping_single" datasource="#SESSION.BDDSOURCE#">
    SELECT mapping_id, mapping_name_#lang# as mapping_name, description_#lang# as description, mapping_explanation_long_#lang# as mapping_explanation_long 
    FROM lms_mapping
    WHERE mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mp_id#">
    </cfquery>
    

    <div id="modal_id">
        <div id="modal_content_div">
          <div id="mapping_explanation_long" >
            <cfoutput>  #get_mapping_single.mapping_explanation_long#</cfoutput>
          </div>
        </div>
      </div>
      
   
     
    
  
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

      <script>
        $(document).ready(function(){
          // Access the editable div
          var contentDiv = $('#mapping_explanation_long');
          
          // Apply fun styles to different tags
          contentDiv.find('p').css({
            'line-height': '1.5',
            'text-align': 'center',
            'margin-top': '5pt',
            'margin-bottom': '5pt',
            'font-family': "'Comic Sans MS', cursive, sans-serif",
            'color': '#4B0082',
            'border-radius': '10px'
          });
      
          contentDiv.find('span').css({
            'font-size': '16pt',
            'font-family': "'Comic Sans MS', cursive, sans-serif",
            'color': '#FF4500',
            'border-radius': '5px'
          });
      
        

          contentDiv.find('li').css({
            'font-size': '14pt',
            'font-family': "'Comic Sans MS', cursive, sans-serif",
            'color': '#8A2BE2',
            'padding': '5px',
            'border-radius': '5px',
            'margin-bottom': '5px'
            }).prepend('🌟');
                
          contentDiv.find('ul, ol').css({
            'margin-top': '5pt',
            'padding-inline-start': '20px',
            'background-color': '#E6E6FA',
            'border-radius': '10px',
            'padding': '10px'
          });
      
          contentDiv.find('div').css({
            'margin-left': '10pt',
            'background-color': '#FFF0F5',
            'padding': '10px',
            'border-radius': '10px'
          });
      
          contentDiv.find('table').css({
            'border': '2px solid #8A2BE2',
            'border-collapse': 'separate',
            'border-spacing': '10px',
            'background-color': '#FFFACD',
            'border-radius': '10px',
            'padding': '10px'
          });
      
          contentDiv.find('tr').css({
            'background-color': '#ADD8E6',
            'border-radius': '5px'
          });
      
          contentDiv.find('td').css({
            'vertical-align': 'middle',
            'padding': '10pt',
            'background-color': '#F0FFF0',
            'border-radius': '5px'
          });
      
          contentDiv.find('strong').css({
            'font-weight': 'bolder',
            'color': '#FF1493',
            'font-family': "'Comic Sans MS', cursive, sans-serif"
          });
      
          // Similarly add styles for other elements if any
          // ...

           // Hide empty span elements
            contentDiv.find('p').each(function(){
            if($(this).text().trim() === '') {
                $(this).css('display', 'none');
            }
             });

             contentDiv.find('table').each(function(){
            if($(this).text().trim() === '') {
                $(this).css('display', 'none');
            }
             });
             contentDiv.find('div').each(function(){
            if($(this).text().trim() === '') {
                $(this).css('display', 'none');
            }
             });
        });
      </script>
      
     
    
    
    </cfif>