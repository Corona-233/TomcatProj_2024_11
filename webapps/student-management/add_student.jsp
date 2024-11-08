<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String studentNumber = request.getParameter("student_number");
    String name = request.getParameter("name");
    String major = request.getParameter("major");

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/student_db?characterEncoding=UTF-8", "root", "123456");

        String sql = "INSERT INTO students (student_number, name, major) VALUES (?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, studentNumber);
        stmt.setString(2, name);
        stmt.setString(3, major);

        stmt.executeUpdate();
        stmt.close();
        conn.close();

        response.sendRedirect("index.jsp"); // 添加成功后返回主页面
    } catch (Exception e) {
        out.println("<script>alert('添加失败：" + e.getMessage() + "'); window.location='add.jsp';</script>");
    }
%>

