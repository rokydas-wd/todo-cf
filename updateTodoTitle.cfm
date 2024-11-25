<cfset todosService = createObject("component", "TodoController")>

<cfif structKeyExists(form, "newTitle")>
    <cfset todosService.updateTodo(taskId, form.newTitle)>
    <cflocation url="index.cfm" addtoken="false">
</cfif>