<cfset todosService = createObject("component", "getTodos")>

<cfset taskId = form.taskId>
<cfset newStatus = "" />

<cfif form.taskStatus EQ "Pending">
    <cfset newStatus = "In Progress">
<cfelseif form.taskStatus EQ "In Progress">
    <cfset newStatus = "Completed">
<cfelseif form.taskStatus EQ "Completed">
    <cfset newStatus = "DELETE">
</cfif>

<!--- <cfoutput>#taskId#</cfoutput>
<cfoutput>#form.taskStatus#</cfoutput> --->

<!--- Updating the task status --->
<cfset todosService.updateTaskStatus(taskId, newStatus)>

<!--- Redirecting to home page --->



<cflocation url="index.cfm" addtoken="false">