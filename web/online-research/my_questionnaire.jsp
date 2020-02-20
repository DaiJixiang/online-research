<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/9/4
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>manage</title>
    <link rel="stylesheet" type="text/css" href="css/magr_edit_css.css" />
    <%--<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>--%>
    <%--<script type="text/javascript" src="login.js"></script>--%>
</head>
<body>

<div id="top">
    <%--logo--%>
    <div id="logo">
        <img src="img/log.png" width="40" height="40">
        在线调查系统
    </div>
</div>
<div id="main">
    <div id="main_sider">
        <span id="user">
            <%--<img src="img/mag_img.jpg" id="user_img" />--%>
            <%
                String user_name = request.getParameter("user_name");
                session.setAttribute("user_name",user_name);
            %>
            <a href="show_questionnaire_login.jsp"><%=user_name%></a>
        </span>
    </div>
    <div id="main_right">
        <div class="table-wrapper">
            <table class="fl-table">
                <thead>
                <tr>
                    <th width="10%">序号</th>
                    <th colspan="3">问卷名</th>
                    <th width="20%">操作</th>
                </tr>
                </thead>
                <tbody>
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
                int user_id=0;
                String find_user_id = "select id from user_info where user_name='"+user_name+"'";
                Statement statement1 = con.createStatement();
                ResultSet resultSet1 = statement1.executeQuery(find_user_id);
                while (resultSet1.next()){
                    user_id = resultSet1.getInt("id");
                }
                int i=1;
                String select_questionnaire_name = "select distinct questionnaire.id, questionnaire_name from questionnaire join answer_question on questionnaire.id = answer_question.questionnaire_id where user_id = '"+user_id+"'";
                Statement statement = con.createStatement();
                ResultSet resultSet = statement.executeQuery(select_questionnaire_name);
                while (resultSet.next()){
                    String questionnaire_name = resultSet.getString("questionnaire_name");
                    int questionnaire_id = resultSet.getInt("questionnaire.id");
                %>
                <tr>
                    <td><%=i%></td>
                    <td colspan="3">
                        <a href="show_questionnaire_unlogin.jsp?questionnaire_name=<%=questionnaire_name%>" ><%=questionnaire_name%></a>
                    </td>
                    <td>
                        <a href="show_question_result.jsp?questionnaire_id=<%=questionnaire_id%>">查看</a>
                    </td>
                </tr>
                    <%
                    i++;
                }
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                %>
                <tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
