<cfset todosService = createObject("component", "TodoController")>

<cfset taskId = form.taskId>
<cfset newStatus = "" />

<cfif form.taskStatus EQ "Pending">
    <cfset newStatus = "In Progress">
<cfelseif form.taskStatus EQ "In Progress">
    <cfset newStatus = "Completed">
<cfelseif form.taskStatus EQ "Completed">
    <cfset newStatus = "DELETE"> 
</cfif> 

<!--- Updating the task status --->

<cfif newStatus EQ "DELETE">
    <cfset todosService.deleteTodo(taskId)>
<cfelse>
    <cfset todosService.updateTodoStatus(taskId, newStatus)>
</cfif>

<!--- Redirecting to home page --->

<cflocation url="index.cfm" addtoken="false">