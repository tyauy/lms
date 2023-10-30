<cfhttp url="https://visio4.wefitgroup.com/bigbluebutton/api/getRecordings?meetingID=dia-mnu-wgs-z7s&recordID=7b316a14412f42382c5b46af5234e7d4ac988374-1689670531851&checksum=fd6eb8bea5477b48fa1e2d0b3e007277f998f80a" method="get">
</cfhttp>
<!---https://visio4.wefitgroup.com/bigbluebutton/api/getMeetingInfo?meetingID=dia-mnu-wgs-z7s&password=mp&checksum=8b2f37b6858e8afa231d8f10b6dba71a260b67cb 

https://visio4.wefitgroup.com/bigbluebutton/api/getRecordings?meetingID=dia-mnu-wgs-z7s&recordID=7b316a14412f42382c5b46af5234e7d4ac988374-1689670531851&checksum=fd6eb8bea5477b48fa1e2d0b3e007277f998f80a--->

<!--- Remove any potential BOM or other invisible characters --->
<cfset responseContent = Replace(cfhttp.fileContent, Chr(65279), "", "ALL")>

<!--- Parse the XML response --->
<cfset xmlResponse = XmlParse(responseContent)>


<!--- Access the data in the XML --->
<cfset recordID = xmlResponse.response.recordings.recording.recordID.xmlText>
<cfset meetingID = xmlResponse.response.recordings.recording.meetingID.xmlText>
<cfset name = xmlResponse.response.recordings.recording.name.xmlText>
<cfset playbackURL = xmlResponse.response.recordings.recording.playback.format.url.xmlText>
<cfset startTime = xmlResponse.response.recordings.recording.startTime.xmlText>
<cfset endTime = xmlResponse.response.recordings.recording.endTime.xmlText>
<cfset participants = xmlResponse.response.recordings.recording.participants.xmlText>
<cfset images = xmlResponse.response.recordings.recording.playback.format.preview.images.image>


<!--- Convert Unix timestamp to ColdFusion date/time object --->
<cfset startTimeDate = DateAdd("s", startTime / 1000, "1970/01/01")>
<cfset endTimeDate = DateAdd("s", endTime / 1000, "1970/01/01")>

<!--- Format date/time object as dd-mm-yyyy HH:nn:ss --->
<cfset startTimeFormatted = DateTimeFormat(startTimeDate, "dd-mm-yyyy HH:nn:ss")>
<cfset endTimeFormatted = DateTimeFormat(endTimeDate, "dd-mm-yyyy HH:nn:ss")>





<!--- Output the data --->
<cfoutput>
    Record ID: #recordID#<br>
    Meeting ID: #meetingID#<br>
    Name: #name#<br>
    Playback URL: #playbackURL#<br>
    Start Time: #startTimeFormatted#<br>
    End Time: #endTimeFormatted#<br>
    Participants: #participants#<br>
    Images:<br>
    <cfloop array="#images#" index="i">
        <img src="#i.xmlText#" alt="#i.xmlAttributes.alt#"><br>
    </cfloop>
</cfoutput>