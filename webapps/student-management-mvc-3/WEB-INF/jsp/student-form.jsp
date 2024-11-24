<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.Student" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Student Form</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        .container {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
            display: inline-block;
        }

        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #007bff;
            outline: none;
        }

        .form-header {
            text-align: center;
            font-size: 24px;
            margin-bottom: 30px;
            color: #333;
        }

        .back-link {
            text-decoration: none;
            color: #007bff;
            display: block;
            text-align: center;
            margin-top: 15px;
        }

        .back-link:hover {
            color: #0056b3;
        }

        .reandonly {
	    background-color: #f9f9f9;
            border: 1px solid #ddd;    
            color: #aaa;           
            cursor: not-allowed;
	}

	.readonly:focus {
            border-color: #ddd;
            outline: none;
        }

        .readonly-icon {
            background: url('https://img.icons8.com/ios-filled/50/000000/lock.png') no-repeat right center;
            background-size: 15px 15px;
            padding-right: 40px; 
        }
    </style>
</head>
<body>

    <div class="container">
        <h1 class="form-header">
            <%= request.getAttribute("student") == null ? "Add New Student" : "Edit Student" %>
        </h1>

        <form action="students" method="post">
            <input type="hidden" name="action" value="save">
            <% if (request.getAttribute("student") != null) { %>
                <input type="hidden" name="id" value="<%= ((Student) request.getAttribute("student")).getId() %>">
            <% } %>

<!-- Student Number  -------------------------------------------------------------------------------------------------------------------------------->
            <div class="form-group">
                <label for="student_number">Student Number:</label>
                <input type="text" id="student_number" name="student_number" 
                    value="<%= request.getAttribute("student") == null ? "" : ((Student) request.getAttribute("student")).getStudentNumber() %>" 
                    <%= request.getAttribute("student") != null ? "readonly class='readonly readonly-icon'" : "" %> required>
            </div>

<!-- Namee ------------------------------------------------------------------------------------------------------------------------------------------>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" 
                    value="<%= request.getAttribute("student") == null ? "" : ((Student) request.getAttribute("student")).getName() %>" required>
            </div>

<!-- Majorr ----------------------------------------------------------------------------------------------------------------------------------------->
            <div class="form-group">
                <label for="major">Major:</label>
                <select id="major" name="major" required>
                    <option value="Software Engineering" 
                        <%= "Software Engineering".equals(request.getAttribute("student") != null ? ((Student) request.getAttribute("student")).getMajor() : "") ? "selected" : "" %>>
                        Software Engineering
                    </option>
                    <option value="Computer Science and Technology" 
                        <%= "Computer Science and Technology".equals(request.getAttribute("student") != null ? ((Student) request.getAttribute("student")).getMajor() : "") ? "selected" : "" %>>
                        Computer Science and Technology
                    </option>
                    <option value="Artificial Intelligence" 
                        <%= "Artificial Intelligence".equals(request.getAttribute("student") != null ? ((Student) request.getAttribute("student")).getMajor() : "") ? "selected" : "" %>>
                        Artificial Intelligence
                    </option>
                </select>
            </div>

            <!-- Submit Button -->
            <button type="submit">Save</button>
        </form>

        <a href="students" class="back-link">Back to Student List</a>
    </div>

</body>
</html>

