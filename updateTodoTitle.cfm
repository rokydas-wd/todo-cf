<cfset todosService = createObject("component", "getTodos")>

<cfif structKeyExists(form, "newTitle")>
    <cfset todosService.updateTodo(taskId, form.newTitle)>
    <cflocation url="index.cfm" addtoken="false">
</cfif>