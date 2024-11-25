<cfcomponent>  
    <cffunction name="getTodos" access="public" returntype="array" output="false">
      <cfset var todos = []>
      
      <cftry>
          <!--- Query the MariaDB database --->
          <cfquery name="qTodos" datasource="todo_app">
              SELECT id, title, status
              FROM `Todos`;
          </cfquery>
          
          <!--- Loop through query results and build an array --->
          <cfloop query="qTodos">
              <cfset arrayAppend(todos, {
                  "id" = qTodos.id,
                  "title" = qTodos.title,
                  "status" = qTodos.status
              })>
          </cfloop>
          
          <cfcatch>
              <!--- Handle database or query errors --->
              <cfset todos = []>
              <cfthrow message="Error retrieving todos" detail="#cfcatch.message#">
          </cfcatch>
      </cftry>
      
      <!--- Return the array of todos --->
      <cfreturn todos>
  </cffunction>

    <cffunction name="getTodo" access="public" returntype="struct">
      <cfargument name="taskId" type="string" required="true">
      <cfset var todos = []>
      <cfquery name="qTodos" datasource="todo_app">
        SELECT id, title, status
        FROM `Todos`
        WHERE id = <cfqueryparam value="#taskId#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
    
      <!--- Loop through query results and build an array --->
      <cfloop query="qTodos">
        <cfset arrayAppend(todos, {
            "id" = qTodos.id,
            "title" = qTodos.title,
            "status" = qTodos.status
        })>
      </cfloop>

      <cfreturn todos[1]>
      
    </cffunction>

    <cffunction name="updateTodo" access="public">
      <cfargument name="taskId" type="string" required="true">
      <cfargument name="newTitle" type="string" required="true">
      
      <cfquery datasource="todo_app">
        UPDATE Todos
        SET title = <cfqueryparam value="#newTitle#" cfsqltype="CF_SQL_VARCHAR">
        WHERE id = <cfqueryparam value="#taskId#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
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

    <!--- Create TODO --->
    <cffunction name="createTodo" access="public" returntype="boolean">
      <cfargument name="todoTitle" type="string" required="true">
      
      <cfset currentTimestamp = DateFormat(now(), "yyyy-mm-dd") & " " & TimeFormat(now(), "HH:mm:ss")>

      <cfquery datasource="todo_app">
        INSERT INTO Todos (id, title, status)
        VALUES (
            <cfqueryparam value="#currentTimestamp#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#todoTitle#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="Pending" cfsqltype="CF_SQL_VARCHAR">
        )
      </cfquery>
      <cfreturn true>
    </cffunction>

    <!--- Delete TODO --->
    <cffunction name="deleteTodo" access="public" returntype="boolean">
      <cfargument name="taskId" type="string" required="true">
      
      <cfquery datasource="todo_app">
        DELETE FROM Todos
        WHERE id = <cfqueryparam value="#taskId#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfreturn true>
    </cffunction>

    <!--- Delete TODO --->
    <cffunction name="updateTodoStatus" access="public" returntype="boolean">
      <cfargument name="taskId" type="string" required="true">
      <cfargument name="newStatus" type="string" required="true">
      
      <cfquery datasource="todo_app">
        UPDATE Todos
        SET status = <cfqueryparam value="#newStatus#" cfsqltype="CF_SQL_VARCHAR">
        WHERE id = <cfqueryparam value="#taskId#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>

      <cfreturn true>
    </cffunction>
    
  </cfcomponent>
  