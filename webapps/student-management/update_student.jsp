<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String studentId = request.getParameter("student_number");
    String name = request.getParameter("name");
    String major = request.getParameter("major");

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/student_db?characterEncoding=UTF-8", "root", "123456");
        
	String sql = "UPDATE students SET name=?, major=? WHERE student_number=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, major);
        stmt.setString(3, studentId);

        int rowsAffected = stmt.executeUpdate(); // 执行更新操作

        stmt.close();
        conn.close();

        if (rowsAffected > 0) {
            response.sendRedirect("index.jsp"); // 更新成功后返回主页面
        } else {
            out.println("<script>alert('更新失败：未找到指定的学生信息'); window.location='edit.jsp?student_number=" + studentId + "';</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('更新失败：" + e.getMessage() + "'); window.location='edit.jsp?student_number=" + studentId + "';</script>");
    }
%>

