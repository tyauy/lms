
    
<script>

<cfif not isdefined("picker")>
<cfset picker = dateformat(now(),"yyyy-mm-dd")>
</cfif>

var avail_choice = "remove";
var currentTimezone = "UTC";


$(document).ready(function() {

    
function renderCalendar() {
    
$('#calendar').fullCalendar({

    /**************COMMON****************/
    /*schedulerLicenseKey: '0542611006-fcs-1459164489',*/
    /*themeSystem: 'bootstrap4',*/
    /*nowIndicator:true,*/
    /*eventConstraint: "blocker",*/
    
    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
    defaultDate: '<cfoutput>#picker#</cfoutput>',	
    timeFormat: 'H:mm',
    hiddenDays: [0,6],
    lang:'<cfoutput>#lcase(SESSION.LANG_CODE)#</cfoutput>',
    axisFormat: 'HH:mm',
    allDaySlot: true,	
    defaultEventMinutes:30,
    timezone: currentTimezone,
    defaultView: 'month',
    selectHelper: false,	
    firstDay: 1,
        
    minTime: '10:00:00',
    maxTime: '19:00:00',

    displayEventTime:false,
    
    slotDuration: '00:05:00',
    navLinks: true,
    editable: false,
    eventStartEditable: false,
    eventResizableFromStart: false,
    eventDurationEditable: false,
    droppable: false,
    
    aspectRatio: 1.5,
    
        
    header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek'
        
    },		

        
        /**************SOURCE****************/	
        eventSources: [
            <cfoutput query="get_tp_user">
                "./calendar/get_data_lms_calendar.cfm?get_virtual_lesson=1&tp_id=#tp_id#&is_subscribed=1",
            </cfoutput>
            <cfoutput query="get_tp_virtual">
                <cfif not listfind(tp_list,get_tp_virtual.tp_id)>
                "./calendar/get_data_lms_calendar.cfm?get_virtual_lesson=1&tp_id=#tp_id#",
                </cfif>
            </cfoutput>
            
        ],
        /**************END SOURCE****************/

        
        eventClick: function(event) {

            if($.isNumeric(event.id))
            {
                // alert(event.tp_id);
                $('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_book_confirm'))#</cfoutput>");
                $('#window_item_xl').modal({keyboard: true});
                $('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=vc&l_id="+event.id+"&tp_id="+event.tp_id+"##lesson_"+event.id, function() {})
            }
            
        },
            
   
        eventRender: function(event, element) {

            var calendar_item = "<div class='p-2'><div class='d-flex justify-content-between'>";
            calendar_item += "<div><h5 class='mb-2'><span class='badge badge-pill bg-white mr-2' style='color:"+event.tp_color+"'>"+event.timeday+" - "+event.timehour+"</span></h5></div>";
            <!----calendar_item += "<div><img src='https://lms.wefitgroup.com/assets/user/"+event.planner_id+"/photo.jpg' width='30' style='border-radius:50%; '><img src='./assets/img/training_"+event.formation_code+".png' width='33'><img src='./assets/img_level/"+event.tplevel_alias+".svg' width='30'></div>";--->
            <!--- calendar_item += "<div><img src='./assets/img_formation/"+event.formation_id+".png' width='27' class='mr-1'><img src='./assets/img_level/"+event.tplevel_alias+".svg' width='30'></div>";--->
            calendar_item += "<div><img src='./assets/img_level/"+event.tplevel_alias+".svg' width='30'></div>";
            calendar_item += "</div><div class='d-flex'>";
            if(event.is_outdated == "1")
            {
                calendar_item += "<div><i class='fa-thin d-none d-lg-block  "+event.tp_icon+" fa-2x mr-2'></i></div><div>"+event.title+"</div>";
            }
            else
            {
                calendar_item += "<div><i class='fa-thin d-none d-lg-block  "+event.tp_icon+" fa-2x mr-2'></i></div><div>"+event.title+"<br><span><strong><cfoutput>#obj_translater.get_translate('vc_btn_remaining_seats')#</cfoutput> : "+event.seats_remaining+"</strong></span></div>";
            }
            calendar_item += "</div></div>";
            
            <!---element.find(".fc-title").html ("<span class='lang-sm' lang='en'></span> "+event.title+"<br><img src='https://lms.wefitgroup.com/assets/user/"+event.planner_id+"/photo.jpg' width='40' style='border-radius:50%; border: 2px solid #8A2128 !important;'><br>Places restantes : "+event.seats_total);--->
           <!--- element.find(".fc-title").html ("<h5 class='mb-2'><span class='badge badge-pill badge-"+event.tplevel_css+" mr-2'>"+event.timeday+" - "+event.timehour+"</span></h5> <img width='80' src='./assets/img_tp/"+event.tp_id+".jpg' align='left' class='mr-2'>"+event.title+"<br>Places restantes : "+event.seats_total);--->

            element.find(".fc-title").html (calendar_item);
            
        },


});

    
}

renderCalendar();

});
</script>