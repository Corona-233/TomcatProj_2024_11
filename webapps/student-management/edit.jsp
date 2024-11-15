<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String studentId = request.getParameter("student_number");
    String name = "";
    String major = "";

    // 获取学生信息
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/student_db?characterEncoding=UTF-8", "root", "123456");

        String sql = "SELECT * FROM students WHERE student_number=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, studentId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            major = rs.getString("major");
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<script>alert('获取信息失败：" + e.getMessage() + "'); window.location='index.jsp';</script>");
    }
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>编辑学生</title>
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
                margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>编辑学生信息</h2>
        <form action="update_student.jsp" method="post" accept-charset="UTF-8">
            <input type="hidden" name="student_number" value="<%= studentId %>">
            <label>姓名：</label>
            <input type="text" name="name" value="<%= name %>" required>
            <label>专业：</label>
            <select name="major" required>
                <option value="Software Engineering" <%= "Software Engineering".equals(major) ? "selected" : "" %>>Software Engineering</option>
                <option value="Computer Science and Technology" <%= "Computer Science and Technology".equals(major) ? "selected" : "" %>>Computer Science and Technology</option>
                <option value="Artificial Intelligence" <%= "Artificial Intelligence".equals(major) ? "selected" : "" %>>Artificial Intelligence</option>
            </select>
            <button type="submit" class="button">更新</button>
            <a href="index.jsp" class="button">返回主页</a>
        </form>
    </div>
</body>

</html>
