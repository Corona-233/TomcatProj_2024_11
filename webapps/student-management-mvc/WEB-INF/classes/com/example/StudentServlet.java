package com.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class StudentServlet extends HttpServlet {
    private Connection connection;

    @Override
    public void init() throws ServletException {
        try {
            // 设置数据库连接
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(
                    "jdbc:mariadb://localhost:3306/student_db", "root", "123456");
        } catch (Exception e) {
            throw new ServletException("Database connection error.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 查询数据库并返回结果
        List<Student> students = new ArrayList<>();
        try (Statement stmt = connection.createStatement()) {
            String sql = "SELECT * FROM students";
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Student student = new Student(rs.getInt("id"),
                                              rs.getString("student_number"),
                                              rs.getString("name"),
                                              rs.getString("major"));
                students.add(student);
            }
            rs.close();
        } catch (SQLException e) {
            throw new ServletException("Error retrieving students", e);
        }

        // 将学生信息存放到请求属性中
        request.setAttribute("students", students);

        // 将请求转发到 JSP 页面
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/students.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public void destroy() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

