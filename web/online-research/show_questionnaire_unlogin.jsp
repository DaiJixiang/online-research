<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/08
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #top{
            width: 100%;
            height: 10%;
            background-color:lightblue;
            position: relative;
            float: left;
        }
        #bottom{
            width: 100%;
            /*height: 90%;*/
            padding-bottom: 200px;
            /*background-color: darkgreen;*/
            position: relative;
            float: left;
            text-align: center;
        }
        #logo{
            position: relative;
            width: 10%;
            height: 80%;
            /*background-color: black;*/
            float: left;
            z-index: 2;
            margin-left: 3%;
            margin-top: 5px;
            margin-right: 5%;
        }
        #user{
            height: 0;
            width:15%;
            float: left;
            z-index: 2;
            margin-left: 0;
            border-radius:20px ;
            background-color:#F8F8FF;
            position: relative;
        }
        #div2{
            height: 50px;
            width: 50px;
            background-color: beige;
            margin-left: 60%;
            margin-top: 10px;
            position: relative;
            float: left;
        }
        table{
            border: black 2px solid;
            width: 50%;
            position: relative;
            float: left;
            left: 25%;
            top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div id="top">
    <div id="logo">
        <img src="img/log.png" width="40" height="40">
    </div>
</div>
<div id="bottom">
<%
    String url = "jdbc:mysql://129.204.194.69:3306/online_research?characterEncoding=utf-8";
    String driver = "com.mysql.jdbc.Driver";
    String userName = "root";
    String password = "root";
    try {
        Class.forName(driver);
        Connection con = DriverManager.getConnection(url, userName, password);
        if (!con.isClosed()) {
            System.out.println("connected successful");
        }
        String questionnaire_name = request.getParameter("questionnaire_name");
        String select_questionnaire_id = "select id from questionnaire where questionnaire_name='" + questionnaire_name + "'";
        Statement statement = con.createStatement();
        ResultSet rs = statement.executeQuery(select_questionnaire_id);
        int questionnaire_id = 0;
        while (rs.next()) {
            questionnaire_id = rs.getInt("id");
        }
        String select_all = "select question_name, questionnaire_id, remark, choice1,choice2,choice3,choice4 from question where questionnaire_id = '" + questionnaire_id + "'";
        Statement statement1 = con.createStatement();
        ResultSet rs1 = statement1.executeQuery(select_all);
        int i=1;
    %>
    <table id="main_table">
        <tr>
            <td><%=questionnaire_name%></td>
        </tr>
    <%
        while (rs1.next()) {
    %>
        <tr>
            <td><%=i%>、<%=rs1.getString("question_name")%></td>
        </tr>
        <%
            if (rs1.getInt("remark") == 1) {
        %>
                <tr>
                    <td>
                        <input type="radio" name="<%=i%>" /><%= rs1.getString("choice1")%>
                        &nbsp;&nbsp;
                        <input type="radio" name="<%=i%>" /><%= rs1.getString("choice2")%>
                        &nbsp;&nbsp;
                        <input type="radio" name="<%=i%>" /><%= rs1.getString("choice3")%>
                        &nbsp;&nbsp;
                        <input type="radio" name="<%=i%>" /><%= rs1.getString("choice4")%>
                    </td>
                </tr>
        <%
            }else {
        %>
            <tr>
                <td>
                    <input type="checkbox" name="a<%=i%>" /><%= rs1.getString("choice1")%>
                    <input type="checkbox" name="b<%=i%>" /><%= rs1.getString("choice2")%>
                    <input type="checkbox" name="c<%=i%>" /><%= rs1.getString("choice3")%>
                    <input type="checkbox" name="d<%=i%>" /><%= rs1.getString("choice4")%>
                </td>
            </tr>
        <%
            }
            i++;
        %>
<%
        }
%>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
    </table>
</div>
</body>
</html>
