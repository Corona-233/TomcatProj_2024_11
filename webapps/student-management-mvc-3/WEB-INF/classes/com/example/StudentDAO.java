package com.example;

import java.sql.*;
import java.util.*;
import com.example.Student;

public class StudentDAO {
    private Connection connection;

    public StudentDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        try (Statement stmt = connection.createStatement()) {
            String sql = "SELECT * FROM students";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Student student = new Student(rs.getInt("id"), rs.getString("student_number"), rs.getString("name"), rs.getString("major"));
                students.add(student);
            }
        }
        return students;
    }

    public Student getStudentById(int id) throws SQLException {
        Student student = null;
        try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM students WHERE id = ?")) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                student = new Student(rs.getInt("id"), rs.getString("student_number"), rs.getString("name"), rs.getString("major"));
            }
        }
        return student;
    }

    public void addStudent(String studentNumber, String name, String major) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement("INSERT INTO students (student_number, name, major) VALUES (?, ?, ?)")) {
            stmt.setString(1, studentNumber);
            stmt.setString(2, name);
            stmt.setString(3, major);
            stmt.executeUpdate();
        }
    }

    public void updateStudent(int id, String studentNumber, String name, String major) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement("UPDATE students SET student_number = ?, name = ?, major = ? WHERE id = ?")) {
            stmt.setString(1, studentNumber);
            stmt.setString(2, name);
            stmt.setString(3, major);
            stmt.setInt(4, id);
            stmt.executeUpdate();
        }
    }

    public void deleteStudent(int id) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement("DELETE FROM students WHERE id = ?")) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Student> searchStudents(String keyword) throws SQLException {
        List<Student> students = new ArrayList<>();
	try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM students WHERE student_number LIKE ? OR name LIKE ? OR major LIKE ?")) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student(
                            rs.getInt("id"),
                            rs.getString("student_number"),
                            rs.getString("name"),
                            rs.getString("major")
                    );
                    students.add(student);
                }
            }
        } 
        return students;
    }

}

