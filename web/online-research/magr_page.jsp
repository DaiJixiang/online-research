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
    <link rel="stylesheet" type="text/css" href="css/magr_page_css.css" />
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
            管理员：<%=session.getAttribute("mag_name")%>
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
                    <a href="user_mag.jsp">管理用户</a>
                </li>
            </ul>
        </nav>
    </div>
    <div id="main_right">
        <ul>
            <li>
                <div class="content-box" style="background-color: white" >
                    <a href="question_number.jsp" target="_self">
                    <div id="first" class="buttonBox">

                            <img src="img/add_question.png" id="add_question"  height="200" width="180">

                        <div class="border"></div>
                        <div class="border"></div>
                    </div>
                    </a>
                </div>
            </li>
            <%
                int k=1;
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
                    while (k<=5) {
                        resultSet1.next();
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
                    <div id="fourth">
                        <div class="border"></div>
                        <div class="border"></div>
                        <div class="border"></div>.
                        <div class="border"></div>
                        <a href="show_questionnaire_unlogin.jsp?questionnaire_name=<%=questionnaire_name%>" target="_self">
                            <img src="../show_home_page_image?questionnaire_id=<%=questionnaire_id%>" height="130" width="100">
                        </a>
                        <div class="title" style="background-color: white"><%=questionnaire_name%></div>
                        <div class="bu-on" style="background-color: white">
                            <span>填写人数：<%=people_number%>人</span>
                        </div>
                    </div>
                </div>
            </li>
            <%
                    k++;
                }
            %>
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </ul>
    </div>
</div>
</body>
</html>
