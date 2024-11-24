<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-bar input {
            width: 70%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .search-bar button {
            padding: 10px 18px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .search-bar button:hover {
            background-color: #0056b3;
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
            width: 160px;
            height: 18px; 
            margin-bottom: 18px;
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

        footer {
            background-color: #f1f1f1;
            text-align: center;
            padding: 20px;
            position: relative;
            bottom: 10px;
            width: 100%;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Student List</h1>
        
        <div class="search-bar">
            <form method="get" action="students">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" placeholder="Enter keyword to search..." value="${param.keyword}">
                <button type="submit">Search</button>
            </form>

	    <a href="students?action=new" class="add-student">Add New Student</a>
    </div>

        <table>
            <thead>
                <tr>
                    <th>Student Number</th>
                    <th>Name</th>
                    <th>Major</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="student" items="${students}">
                    <tr>
                        <td>${student.studentNumber}</td>
                        <td>${student.name}</td>
                        <td>${student.major}</td>
                        <td class="actions">
                            <a href="students?action=edit&id=${student.id}">Edit</a>
                            <a href="students?action=delete&id=${student.id}" class="delete" onclick="return confirm('Are you sure you want to delete this student?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <footer>
        <a href="http://8.140.233.102" target="_blank">About</a>
    </footer>

</body>
</html>

