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
            <img src="img/mag_img.jpg" id="user_img" />
            管理员名称
        </span>
        <nav>
            <ul>
                <li>
                    <a href="magr_page.jsp">添加问卷</a>
                </li>
                <li>
                    <a href="magr_edit.jsp">维护问卷</a>
                </li>
                <li>
                    <a href="">管理用户</a>
                </li>
            </ul>
        </nav>
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
                int i=1;
                String select_questionnaire_name = "select id, questionnaire_name from questionnaire";
                Statement statement = con.createStatement();
                ResultSet resultSet = statement.executeQuery(select_questionnaire_name);
                while (resultSet.next()){
                    String questionnaire_name = resultSet.getString("questionnaire_name");
                    int questionnaire_id = resultSet.getInt("id");
                %>
                <tr>
                    <td><%=i%></td>
                    <td colspan="3">
                        <a href="show_questionnaire_unlogin.jsp?questionnaire_name=<%=questionnaire_name%>" ><%=questionnaire_name%></a>
                    </td>
                    <td>
                        <a href="../delete_questionnaire?questionnaire_id=<%=questionnaire_id%>">删除</a>
                        &nbsp;&nbsp;
                        <a href="update_questionnaire.jsp?questionnaire_id=<%=questionnaire_id%>">修改</a>
                        &nbsp;&nbsp;
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
