
<!--- Set the API key and meeting variables --->
<cfset api_key = "JZBFyZ6VDL5DntY5bmCDWNdix6gTctR8pkyIePXc">
<cfset meeting_name = "My Meeting">
<cfset meeting_id = "emi-nsy-llx-0kh">
<cfset attendee_pw = form.password>
<cfset moderator_pw = form.password>

<!--- USER CREATION --->

<!--- Create form to allow users to create accounts --->
<form action="create_user.cfm" method="post">
    <label for="fullname">Full Name:</label>
    <input type="text" id="fullname" name="fullname" required>
    <br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>
    <br>
    <input type="submit" value="Create Account">
  </form>
  
  <!--- Process form submission to create user and insert into database --->
  <cfif isDefined("form.fullname") AND isDefined("form.password")>
    <!--- Send API request to create user in BigBlueButton --->
    <cfset user_name = form.fullname>
    <cfset user_password = form.password>
    <cfhttp url="https://visio4.wefitgroup.com/bigbluebutton/api/createUser?fullName=<cfoutput>#user_name#</cfoutput>&meetingID=my-meeting-id&password=<cfoutput>#user_password#</cfoutput>&userID=jdoe&redirect=false&apiKey=your-api-key" method="post" result="response">
    
    <!--- Check response status code and insert user into database if successful --->
    <cfif response.statusCode EQ 200>
      <!--- Insert user into database --->
      <cfquery name="insertUser" datasource="postgrebdd">
        INSERT INTO users (fullname, password)
        VALUES (
          <cfoutput>'#user_name#'</cfoutput>,
          <cfoutput>'#user_password#'</cfoutput>
        )
      </cfquery>
      
    
    <!--- Send API request to create meeting in BigBlueButton --->
    <cfhttp url="https://visio4.wefitgroup.com/bigbluebutton/api/create?name=<cfoutput>#meeting_name#</cfoutput>&meetingID=<cfoutput>#meeting_id#</cfoutput>&attendeePW=<cfoutput>#attendee_pw#</cfoutput>&moderatorPW=<cfoutput>#moderator_pw#</cfoutput>&apiKey=<cfoutput>#api_key#</cfoutput>" method="post" result="response">
    
      <!--- Check response status code and insert meeting into database if successful --->
      <cfif response.statusCode EQ 200>
        <!--- Insert meeting into database --->
        <cfquery name="insertMeeting" datasource="#SESSION.BDDSOURCE#">
          INSERT INTO meetings (name, meeting_id, attendee_pw, moderator_pw)
          VALUES (
            <cfoutput>'#meeting_name#'</cfoutput>,
            <cfoutput>'#meeting_id#'</cfoutput>,
            <cfoutput>'#attendee_pw#'</cfoutput>,
            <cfoutput>'#moderator_pw#'</cfoutput>
          )
        </cfquery>
        
        <p>User and meeting created successfully!</p>
      <cfelse>
        <p>Error creating meeting: <cfoutput>#response.fileContent#</cfoutput></p>
      </cfif>
    <cfelse>
      <p>Error creating user: <cfoutput>#response.fileContent#</cfoutput></p>
    </cfif>
  </cfif>
  