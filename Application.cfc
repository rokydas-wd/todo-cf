<cfcomponent displayname="TodoApp" output="false">

    <!--- Application Settings --->
    <cfset this.name = "TodoApp">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)> <!--- Session timeout (30 minutes) --->
    <cfset this.applicationTimeout = createTimeSpan(0, 1, 0, 0)> <!--- Application timeout (1 hour) --->
  
    <!--- Set the path for the tasks JSON file --->
    <cfset this.taskFilePath = expandPath("./todos.json")>
  
    <!--- Initialize or load tasks from the file if exists --->
    <cffunction name="onApplicationStart" returntype="boolean">
      <cfset var fileExists = fileExists(this.taskFilePath)>
      
      <!--- If the tasks file does not exist, create it with an empty array --->
      <cfif not fileExists>
        <cfset fileWrite(this.taskFilePath, '[]')>
      </cfif>
      
      <cfreturn true>
    </cffunction>
  
    <!--- Function to retrieve tasks from the JSON file --->
    <cffunction name="getTasks" returntype="array" access="public">
      <cfset var tasks = []>
      <cfif fileExists(this.taskFilePath)>
        <cfset tasks = deserializeJSON(fileRead(this.taskFilePath))>
      </cfif>
      <cfreturn tasks>
    </cffunction>
  
    <!--- Function to update tasks in the JSON file --->
    <cffunction name="updateTasks" returntype="void" access="public">
      <cfargument name="tasks" type="array" required="true">
      
      <!--- Save the updated tasks back to the JSON file --->
      <cfset fileWrite(this.taskFilePath, serializeJSON(arguments.tasks))>
    </cffunction>
  
  </cfcomponent>
  