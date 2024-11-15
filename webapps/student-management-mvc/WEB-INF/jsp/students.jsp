<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Student" %>
<html>
<head>
    <title>Student List</title>
</head>
<body>
    <h1>Student List</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Student Number</th>
                <th>Name</th>
                <th>Major</th>
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
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>

