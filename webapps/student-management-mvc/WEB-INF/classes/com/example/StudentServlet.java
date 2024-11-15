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
// link DB ------------------------------------------------------------------------------------------------------------------------------------------
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/student_db", "root", "123456");
        } catch (Exception e) {
            throw new ServletException("Database connection error.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("new".equals(action)) {
// new ---------------------------------------------------------------------------------------------------------------------------------------------- 
            request.getRequestDispatcher("/WEB-INF/jsp/student-form.jsp").forward(request, response);
        } 
	else if ("edit".equals(action)) {
// edit ---------------------------------------------------------------------------------------------------------------------------------------------
            String id = request.getParameter("id");
            if (id != null) {
                Student student = getStudentById(Integer.parseInt(id));
                request.setAttribute("student", student);
                request.getRequestDispatcher("/WEB-INF/jsp/student-form.jsp").forward(request, response);
            }
        } 
	else if ("delete".equals(action)) {
// delete -------------------------------------------------------------------------------------------------------------------------------------------
            String id = request.getParameter("id");
            if (id != null) {
                deleteStudent(Integer.parseInt(id));
            }
            response.sendRedirect("students");
        } 
	else {
// show all info -------------------------------------------------------------------------------------------------------------------------------------
            List<Student> students = getAllStudents();
            request.setAttribute("students", students);
            request.getRequestDispatcher("/WEB-INF/jsp/students.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("save".equals(action)) {
// new or edit --------------------------------------------------------------------------------------------------------------------------------------
            String id = request.getParameter("id");
            String studentNumber = request.getParameter("student_number");
            String name = request.getParameter("name");
            String major = request.getParameter("major");

            if (id != null && !id.isEmpty()) {

                updateStudent(Integer.parseInt(id), studentNumber, name, major);
            } 
	    else {
        
                addStudent(studentNumber, name, major);
            }

            response.sendRedirect("students");
        }
    }

    private List<Student> getAllStudents() throws ServletException {
        List<Student> students = new ArrayList<>();
        try (Statement stmt = connection.createStatement()) {
            String sql = "SELECT * FROM students";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Student student = new Student(rs.getInt("id"), rs.getString("student_number"), rs.getString("name"), rs.getString("major"));
                students.add(student);
            }
        } catch (SQLException e) {
            throw new ServletException("Error retrieving students", e);
        }
        return students;
    }

    private Student getStudentById(int id) throws ServletException {
        Student student = null;
        try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM students WHERE id = ?")) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                student = new Student(rs.getInt("id"), rs.getString("student_number"), rs.getString("name"), rs.getString("major"));
            }
        } catch (SQLException e) {
            throw new ServletException("Error retrieving student by ID", e);
        }
        return student;
    }

    private void addStudent(String studentNumber, String name, String major) throws ServletException {
        try (PreparedStatement stmt = connection.prepareStatement("INSERT INTO students (student_number, name, major) VALUES (?, ?, ?)")) {
            stmt.setString(1, studentNumber);
            stmt.setString(2, name);
            stmt.setString(3, major);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Error adding student", e);
        }
    }

    private void updateStudent(int id, String studentNumber, String name, String major) throws ServletException {
        try (PreparedStatement stmt = connection.prepareStatement("UPDATE students SET student_number = ?, name = ?, major = ? WHERE id = ?")) {
            stmt.setString(1, studentNumber);
            stmt.setString(2, name);
            stmt.setString(3, major);
            stmt.setInt(4, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Error updating student", e);
        }
    }

    private void deleteStudent(int id) throws ServletException {
        try (PreparedStatement stmt = connection.prepareStatement("DELETE FROM students WHERE id = ?")) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Error deleting student", e);
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

