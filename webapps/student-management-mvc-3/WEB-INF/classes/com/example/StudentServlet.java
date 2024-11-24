package com.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class StudentServlet extends HttpServlet {
    private Connection connection;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/student_db", "root", "123456");
            studentDAO = new StudentDAO(connection);
        } catch (Exception e) {
            throw new ServletException("Database connection error.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("new".equals(action)) {
                request.getRequestDispatcher("/WEB-INF/jsp/student-form.jsp").forward(request, response);
            } 
	    else if ("edit".equals(action)) {
                String id = request.getParameter("id");
                if (id != null) {
                    Student student = studentDAO.getStudentById(Integer.parseInt(id));
                    request.setAttribute("student", student);
                    request.getRequestDispatcher("/WEB-INF/jsp/student-form.jsp").forward(request, response);
                }
            } 
	    else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                if (id != null) {
                    studentDAO.deleteStudent(Integer.parseInt(id));
                }
                response.sendRedirect("students");
            } 
	    else if ("search".equals(action)) {
                String keyword = request.getParameter("keyword");
                List<Student> students = studentDAO.searchStudents(keyword);
                request.setAttribute("students", students);
                request.setAttribute("keyword", keyword); // Preserve the search keyword
                request.getRequestDispatcher("/WEB-INF/jsp/students.jsp").forward(request, response);
            }
	    else {
                List<Student> students = studentDAO.getAllStudents();
                request.setAttribute("students", students);
                request.getRequestDispatcher("/WEB-INF/jsp/students.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("save".equals(action)) {
                String id = request.getParameter("id");
                String studentNumber = request.getParameter("student_number");
                String name = request.getParameter("name");
                String major = request.getParameter("major");

                if (id != null && !id.isEmpty()) {
                    studentDAO.updateStudent(Integer.parseInt(id), studentNumber, name, major);
                } 
		else {
                    studentDAO.addStudent(studentNumber, name, major);
                }

                response.sendRedirect("students");
	    }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
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

