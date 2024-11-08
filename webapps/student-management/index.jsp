<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>学生信息管理系统</title>
    <style>
        body { 
		font-family: Arial, sans-serif; 
		background-color: #f4f4f4; 
		padding: 20px; 
	}
        
	.container { 
		max-width: 800px; 
		margin: 0 auto; 
		background: white; 
		padding: 20px; 
		border-radius: 8px; 
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
	}
        
	h1 { 
		color: #333; 
	}
        
	.table { 
		width: 100%; 
		border-collapse: collapse;
		margin: 20px 0; 
	}
        
	.table th, .table td { 
		padding: 10px; 
		border: 1px solid #ddd; 
		text-align: left; 
	}
        
	.table th { 
		background-color: #007bff; 
		color: white; 
	}
        
	.button { 
		padding: 8px 12px; 
		background-color: #007bff; 
		color: white; 
		text-decoration: none; 
		border-radius: 5px; 
		display: inline-block; 
		margin: 5px 0; 
	}
        
	.button:hover { 
		background-color: #0056b3; 
	}

	footer {
            background-color: #f1f1f1;
            text-align: center;
            padding: 20px; 
            position: relative; 
            bottom: 10px;
            width: 100%;
        }

    </style>
</head>
<body>
    <div class="container">
        <h1>学生信息管理系统</h1>
        <a href="add.jsp" class="button">添加学生</a>
        <table class="table">
            <thead>
                <tr>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>专业</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Class.forName("org.mariadb.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/student_db?characterEncoding=UTF-8", "root", "123456");

                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM students");
                    while (rs.next()) {
                        String studentId = rs.getString("student_number");
                        String name = rs.getString("name");
                        String major = rs.getString("major");
                %>
                <tr>
                    <td><%= studentId %></td>
                    <td><%= name %></td>
                    <td><%= major %></td>
                    <td>
                        <a href="edit.jsp?student_number=<%= studentId %>" class="button">编辑</a>
                        <a href="delete_student.jsp?student_number=<%= studentId %>" class="button" onclick="return confirm('确认删除？')">删除</a>
                    </td>
                </tr>
                <% 
		    } 
                    rs.close();
                    stmt.close();
                    conn.close();
                %>
            </tbody>
        </table>
    </div>
    <footer>
        <a href="http://8.140.233.102" target="_blank">About</a>
    </footer>
</body>
</html>

