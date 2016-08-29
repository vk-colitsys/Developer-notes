<cfsilent>
<cfset datasource="devnotes1">

	<cfparam name="url.delete" default="false">
	<cfparam name="form.insert" default="false">
	<cfparam name="form.update" default="false">
	<cfparam name="url.note_id" default="0">
	<cfparam name="form.addapp" default="0">
	<cfparam name="url.sort" default="">
	<cfparam name="variables.thisNote" default="" />

	<cfif form.insert>
		<cfquery name="addnote" datasource="#datasource#">
		INSERT INTO notes (note, app_id, entry_date)
		VALUES (<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.note#">, <cfqueryparam cfsqltype="cf_sql_integer" value="#form.app_id#">, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">)
		</cfquery>
		<cflocation url="index.cfm" addtoken="false" />
		<cfabort>
	</cfif>
	<cfif form.update>
		<cfquery name="updatenote" datasource="#datasource#">
		UPDATE notes
		SET note=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.note#">, app_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.app_id#">, entry_date=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">
		WHERE note_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.note_id#" />
		</cfquery>
	</cfif>

	<cfif url.delete>
		<cfquery name="deletenote" datasource="#datasource#">
		DELETE from notes
		WHERE note_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.note_id#" />
		</cfquery>
		<cflocation url="index.cfm" addtoken="false" />
		<cfabort>
	</cfif>

	<cfif form.addapp>
		<cfquery name="addapp" datasource="#datasource#">
		INSERT INTO apps (app_name, app_version)
		VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.app_name#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.app_version#">)
		</cfquery>
	</cfif>

	<cfquery name="app" datasource="#datasource#">
	SELECT *
	FROM apps
	ORDER BY app_name
	</cfquery>

	<cfquery name="getnotes" datasource="#datasource#">
	SELECT apps.app_name,apps.app_version, notes.note_id, notes.note, notes.entry_date
	FROM apps
	INNER JOIN notes ON apps.app_id = notes.app_id
	<cfif url.sort is 1>WHERE apps.app_id=#url.app#</cfif>
	ORDER by entry_date desc
	</cfquery>

	<cfif url.note_id GT 0>
		<cfquery name="qNote" datasource="#datasource#">
		SELECT apps.app_id,apps.app_name,apps.app_version, notes.note_id, notes.note, notes.entry_date
		FROM apps
			INNER JOIN notes ON apps.app_id = notes.app_id
		WHERE note_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.note_id#" />
		</cfquery>
		<cfif qNote.recordcount>
			<cfset thisNote = qNote.note />
		</cfif>
	</cfif>

	<!--- Add the CF Window for adding a new application --->
	<cfwindow center="true"
			  modal="true"
			  width="200"
			  height="130"
			  name="pop_new_app" title="New App"
			  initshow="false" draggable="true" resizable="true" closable="true"
			  source="add-app.cfm" />
	<!--- Add the CF Window for app manager --->
	<cfwindow center="true"
			  modal="true"
			  width="400" height="200"
			  name="pop_appman" title="App Manager"
			  initshow="false" draggable="true" resizable="true" closable="true"
			  source="add-app.cfm" />
</cfsilent>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>devnotes</title>
	<cfoutput>
	<link href="css/dark.css" rel="stylesheet" type="text/css"/></cfoutput>
</head>

<body>
	<div id="wrapper">
		<div id="header">
			<img src="images/banner.jpg"
		</div>
		<div id="content">
			<div id="formcontainer">
				<form name="addNoteForm" method="post" action="index.cfm">
					<div>
						<input type="hidden" name="note_id" value="#url.note_id#" />
						<cfif url.note_id>
						<input type="hidden" name="action" value="update" />
						<cfelse>
						<input type="hidden" name="action" value="insert" />
						</cfif>
					</div>
					<fieldset>
						<legend>Select Application</legend>
						<cfoutput>
						<ol>
							<li>
								<label for="app_id">App name</label>
							    <select name="app_id" id="app_id">
									<cfif url.note_id>
								   		<option value="#qNote.app_id#">#qNote.app_name#</option>
									<cfelse>
										<cfloop query="app">
											<option value="#app.app_id#">#app.app_name#</option>
										</cfloop>
									</cfif>
							    </select>
							   [<a href="##" onclick="javascript:ColdFusion.Window.show('pop_new_app')" title="Add a new application">add new</a>]
							</li>
						</ol>
						</cfoutput>
					</fieldset>
					<fieldset>
						<legend>Enter Notes</legend>
						<cfoutput>
						<ol>
							<li class="textarea">
								<label for="note">Note Content</label>
				    			<textarea name="note" id="note">#thisNote#</textarea>
							</li>
						</ol>
						</cfoutput>
					</fieldset>
					<fieldset class="submit">
						<ol>
							<li>
								<input type="submit" name="submit" id="submit" value="post" />
							</li>
						</ol>
					</fieldset>
				</form>
			</div>
			<p>View by app: 
  <select onChange="if(this.selectedIndex!=0)
self.location=this.options[this.selectedIndex].value"
name="sort_app" id="sort_app"><option value="Select..." selected="selected">Select...</option>
        <cfoutput query="app"><option value="index.cfm?sort=1&app=#app_id#">#app.app_name#</option></cfoutput>
  </select>
  <br />
</p>
			<div id="notecontainer">
				<a href="index.cfm">[reload]</a>
				<div id="scrolldiv">
				<cfoutput query="getnotes">
					<div id="notebox">
						<p>
					  		<strong>
						  		#dateformat(getNotes.entry_date, "mm/dd/yyyy")# #timeformat(getNotes.entry_date, "hh:mm tt")#
						  		- App: #app_name# #app_version#
						  		- <a href="index.cfm?delete=1&note_id=#getNotes.note_id#" onclick="confirm('Are you sure you want to delete this note?')">[delete]</a>
						  		- <a href="index.cfm?note_id=#getNotes.note_id#">[edit]</a>
							</strong>
		 				  	<p>#getNotes.note#</p>
						</p>
					</div>
					<br />
				</cfoutput>
				</div>
			</div>
		</div>
	</div>
</body>
</html>