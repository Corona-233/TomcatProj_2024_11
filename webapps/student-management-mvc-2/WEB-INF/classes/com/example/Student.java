package com.example;

public class Student {
    private int id;
    private String studentNumber;
    private String name;
    private String major;

    public Student(int id, String studentNumber, String name, String major) {
        this.id = id;
        this.studentNumber = studentNumber;
        this.name = name;
        this.major = major;
    }

    public int getId() {
        return id;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public String getName() {
        return name;
    }

    public String getMajor() {
        return major;
    }
}

