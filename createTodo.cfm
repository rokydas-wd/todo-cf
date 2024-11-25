<cfset todosService = createObject("component", "TodoController")>

<!--- Fetch tasks from the JSON file --->
<cfset tasks = todosService.getTodos()>

<cfif structKeyExists(form, "todoTitle")>
    <cfset todosService.createTodo(form.todoTitle) >
    <cflocation url="index.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Todo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow p-4" style="width: 24rem;">
            <h3 class="card-title text-center mb-4">Create Todo</h3>
            <!-- Form for Creating a Todo -->
            <form action="createTodo.cfm" method="post">
                <div class="mb-3">
                    <label for="todoTitle" class="form-label">Todo Title</label>
                    <input 
                        type="text" 
                        class="form-control" 
                        id="todoTitle" 
                        name="todoTitle" 
                        placeholder="Enter todo title" 
                        required
                    >
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Create Todo</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
