<cfcomponent>  
    <!--- Function to read the todo tasks from the JSON file --->
    <cffunction name="getTodos" access="public" returntype="array">
      <cfset var tasks = []>
      <cfset var todosJson = "todos.json">
      
      <!--- Check if the JSON file exists --->
      <cfif fileExists(todosJson)>
        <cfset tasks = deserializeJSON(fileRead(todosJson))>
      <cfelse>
        <cfset tasks = []>
      </cfif>
      
      <cfreturn tasks>
    </cffunction>

    <cffunction name="getTodo" access="public" returntype="struct">
      <cfargument name="taskId" type="string" required="true">
      <cfset var tasks = []>
      <cfset var todosJson = "todos.json">
      
      <!--- Check if the JSON file exists --->
      <cfif fileExists(todosJson)>
        <cfset tasks = deserializeJSON(fileRead(todosJson))>
      <cfelse>
        <cfset tasks = []>
      </cfif>

      <cfloop array="#tasks#" index="task">
        <cfif task.id EQ taskId>
          <cfreturn task>
        </cfif>
      </cfloop>
      
    </cffunction>

    <cffunction name="updateTodo" access="public">
      <cfargument name="taskId" type="string" required="true">
      <cfargument name="newTitle" type="string" required="true">
      <cfset var tasks = []>
      <cfset var todosJson = "todos.json">
      
      <!--- Check if the JSON file exists --->
      <cfif fileExists(todosJson)>
        <cfset tasks = deserializeJSON(fileRead(todosJson))>
      <cfelse>
        <cfreturn>
      </cfif>

      <cfloop array="#tasks#" index="task">
        <cfif task.id EQ taskId>
          <cfset task.task = newTitle>
        </cfif>
      </cfloop>

      <cfset fileWrite("todos.json", serializeJSON(tasks))>
      <cfreturn>
      
    </cffunction>
    
    <!--- Function to update a task's status in the JSON file --->
    <cffunction name="updateTaskStatus" access="public" returntype="boolean">
      <cfargument name="taskId" type="string" required="true">
      <cfargument name="newStatus" type="string" required="true">
      
      <cfset var tasks = getTodos()>
      
      <!--- Find the task and update its status --->
      <cfloop array="#tasks#" index="task">
        <cfif task.id EQ arguments.taskId>
          <cfif arguments.newStatus EQ "DELETE">
            <!--- Remove the task from the array --->
            <cfset arrayDeleteAt(tasks, arrayFind(tasks, task))>
        <cfelse>
            <!--- Update the task status --->
            <cfset task.status = arguments.newStatus>
        </cfif>
        <!--- Break out of the loop once the task is found --->
        <cfbreak>
        </cfif>
      </cfloop>
      
      <!--- Save the updated tasks back to the JSON file --->
      <cfset fileWrite("todos.json", serializeJSON(tasks))>
      
      <cfreturn true>
    </cffunction>
    
  </cfcomponent>
  