<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Student" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
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
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        td a {
            text-decoration: none;
            color: #007bff;
            padding: 5px 10px;
            border-radius: 4px;
            background-color: #e7f1ff;
        }

        td a:hover {
            background-color: #0056b3;
            color: white;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .actions a {
            background-color: #28a745;
            color: white;
            padding: 8px 15px;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
        }

        .actions a:hover {
            background-color: #218838;
        }

        .actions a.delete {
            background-color: #dc3545;
        }

        .actions a.delete:hover {
            background-color: #c82333;
        }

        .add-student {
            display: block;
            width: 180px;
            margin: 20px auto;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
        }

        .add-student:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Student List</h1>
        <a href="students?action=new" class="add-student">Add New Student</a>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Student Number</th>
                    <th>Name</th>
                    <th>Major</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Student> students = (List<Student>) request.getAttribute("students");
                    for (Student student : students) {
                %>
                    <tr>
                        <td><%= student.getId() %></td>
                        <td><%= student.getStudentNumber() %></td>
                        <td><%= student.getName() %></td>
                        <td><%= student.getMajor() %></td>
                        <td class="actions">
                            <a href="students?action=edit&id=<%= student.getId() %>">Edit</a>
                            <a href="students?action=delete&id=<%= student.getId() %>"
                               class="delete" onclick="return confirm('Are you sure you want to delete this student?');">Delete</a>
                        </td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>

