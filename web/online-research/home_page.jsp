<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/02
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>主页</title>
    <link rel="stylesheet" type="text/css" href="css/home_page_css.css" />
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
    <div id="research">
        <span id="research_img"><img src="img/fangdajing.png" height="25" width="30" ></span>
        <input id="research_input" name="research">
        <span>×</span>
    </div>
    <%--login and reg--%>
    <div id="login">
        <ul style="list-style-type: none">
            <li>
                <a href="login.jsp" style="text-decoration-line: none" class="an">
                    登录
                </a>
                |
                <i></i>
                <a href="reg.jsp" style="text-decoration-line: none" class="an ">
                    注册
                </a>
            </li>
        </ul>
    </div>
</div>
<div id="main">
    <%--<div id="main_sider">--%>
        <%--<ul>--%>
            <%--<li>--%>
                <%--<a href="">我的问卷</a>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<a href="">调查资讯</a>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<a href="">帮助中心</a>--%>
            <%--</li>--%>
        <%--</ul>--%>
    <%--</div>--%>
    <div id="main_right">
        <ul>
        <%
            String url = "jdbc:mysql://129.204.194.69:3306/online_research";
            String driver = "com.mysql.jdbc.Driver";
            String userName = "root";
            String password = "root";
            try {
                Class.forName(driver);
                Connection con = DriverManager.getConnection(url, userName, password);
                if (!con.isClosed()) {
                    System.out.println("connected successful");
                }
                String select_questionnaire_text = "select id, questionnaire_name,questionnaire_num from questionnaire";
                int num = 0;
                Statement statement1 = con.createStatement();
                ResultSet resultSet1 = statement1.executeQuery(select_questionnaire_text);
                while (resultSet1.next()) {
                    int questionnaire_id = resultSet1.getInt("id");
                    num = resultSet1.getInt("questionnaire_num");
                    String questionnaire_name = resultSet1.getString("questionnaire_name");
                    String select_questionnaire_info = "select count(*) count1 from answer_question where questionnaire_id = '" + questionnaire_id + "'";
                    Statement statement2 = con.createStatement();
                    ResultSet resultSet2 = statement2.executeQuery(select_questionnaire_info);
                    resultSet2.next();
                    int people_number = (resultSet2.getInt("count1"))/num;
        %>
            <li>
                <div class="content-box" style="background-color: whitesmoke">
                    <a href="login.jsp" target="_self">
                        <img src="../show_home_page_image?questionnaire_id=<%=questionnaire_id%>" height="130" width="100">
                    </a>
                    <div class="title" style="background-color: white">
                        <%=questionnaire_name%>
                    </div>
                    <div class="bu-on" style="background-color: white">
                        <span>填写人数：<%=people_number%>人</span>
                    </div>
                </div>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</div>
<%
    } catch (Exception e) {
                e.printStackTrace();
    }
%>
</body>
</html>