<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>添加学生</title>
    <style>
        body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                padding: 20px;
        }

        .container {
                max-width: 500px;
                margin: 0 auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
                color: #333;
        }

        .button {
                padding: 8px 12px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                display: inline-block;
                margin: 10px 0;
        }

        .button:hover {
                background-color: #0056b3;
        }

        input[type="text"] {
                width: 96%;
                padding: 8px;
                margin: 10px 0;
        }

        select {
                width: 100%;
                padding: 8px;
                margin: 10px 0;}
    </style>
</head>
<body>
    <div class="container">
        <h2>添加学生信息</h2>
        <form action="add_student.jsp" method="post" accept-charset="UTF-8">
            <label>学号：</label>
            <input type="text" name="student_number" required>
            <label>姓名：</label>
            <input type="text" name="name" required>
            <label>专业：</label>
            <select name="major" required>
                <option value="Software Engineering">Software Engineering</option>
                <option value="Computer Science and Technology">Computer Science and Technology</option>
                <option value="Artificial Intelligence">Artificial Intelligence</option>
            </select>
            <button type="submit" class="button">提交</button>
            <a href="index.jsp" class="button">返回主页</a>
        </form>
    </div>
</body>

</html>
