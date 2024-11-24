<cfset todosService = createObject("component", "getTodos")>

<!--- Fetch tasks from the JSON file --->
<cfset tasks = todosService.getTodos()>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Todo App</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card {
      margin: 10px;
      max-width: 300px;
    }
  </style>
</head>
<body>
  <div class="container mt-5">
	<div class="d-flex justify-content-center">
		<div class="mb-4">
			<cfoutput>
				<form action="createTodo.cfm" method="get">
					<button type="submit" class="btn btn-primary">Create Todo</button>
				</form>
			</cfoutput>
		</div>
	</div>
	
    <div class="row justify-content-center">
      <!--- Loop through tasks and display them --->
      <cfloop array="#tasks#" index="task">
        <div class="col-md-4">
          <div class="card text-center" id="todo#task.id#" style="background-color: 
            <cfif task.status EQ 'Pending'>#f8d7da#<cfelseif task.status EQ 'In Progress'>#fff3cd#<cfelse>#d4edda#</cfif>;">
            <div class="card-body">
				<cfif task.status EQ "Completed">
					<s><h5 class="card-title"><cfoutput>#task.task#</cfoutput></h5></s>
					<cfelse>
						<h5 class="card-title"><cfoutput>#task.task#</cfoutput></h5>
				</cfif>
            	
            	<p class="card-text">Status: <cfoutput>#task.status#</cfoutput></p>
            	<form method="POST" action="updateStatus.cfm">
					<cfoutput>
						<input type="hidden" name="taskId" value="#task.id#">
					</cfoutput>
					<cfoutput>
						<input type="hidden" name="taskStatus" value="#task.status#">
					</cfoutput>
					<button type="submit" class="btn 
						<cfif task.status EQ 'Pending'>btn-success<cfelseif task.status EQ 'In Progress'>btn-warning<cfelse>btn-danger</cfif>">
						<cfif task.status EQ 'Pending'>Start Task<cfelseif task.status EQ 'In Progress'>Complete Task<cfelse>Delete Todo</cfif>
					</button>	
            	</form>
				<form method="POST" action="updateTodo.cfm" class="mt-2">
					<cfoutput>
						<input type="hidden" name="taskId" value="#task.id#">
					</cfoutput>
					<button type="submit" class="btn btn-primary">
						Update Task
					</button>	
            	</form>
            </div>
          </div>
        </div>
      </cfloop>
      
    </div>
  </div>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
