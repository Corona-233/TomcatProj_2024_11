<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String studentId = request.getParameter("student_number");

    if (studentId != null && !studentId.isEmpty()) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/student_db?characterEncoding=UTF-8", "root", "123456");
            
	    String sql = "DELETE FROM students WHERE student_number=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, studentId);

            stmt.executeUpdate();
            stmt.close();
            conn.close();

            response.sendRedirect("index.jsp"); // 删除成功后返回主页面
        } catch (Exception e) {
            out.println("<script>alert('删除失败：" + e.getMessage() + "'); window.location='index.jsp';</script>");
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>

