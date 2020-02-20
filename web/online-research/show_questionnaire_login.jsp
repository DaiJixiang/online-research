<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/09
  Time: 23:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>主页</title>
    <%--<link rel="stylesheet" type="text/css" href="css/home_page_css.css" />--%>
    <style>
        #top{
            width: 100%;
            height: 10%;
            background-color:lightblue;
            position: relative;
        }
        #main{
            width: 100%;
            height: 90%;
            background-color: blueviolet;
            position: relative;
            z-index: 2;
        }
        #logo{
            width: 15%;
            height: 80%;
            background-color:lightblue;
            float: left;
            position: relative;
            z-index: 1;
            margin-left: 2%;
            margin-top: 5px;
            margin-right: 1%;
            font-family: 幼圆, Serif;
            font-size:20px;
            font-weight: bolder;
            color: aliceblue;

        }
        #research{
            width: 35%;
            height: 80%;
            background-color: rgba(255, 255, 255, 0);
            float: left;
            position: relative;
            z-index: 1;
            margin-top: 10px;
            margin-left: 18%;
            margin-right: 5%;
        }
        #research_input{
            width: 80%;
            height: 70%;
            background-color: rgba(255, 255, 255, 0);
            border:0;
            border-bottom: darkgray 1.5px solid;
            outline-style: none;
        }
        #research_img{
            margin-top: 5px;
        }
        #main_right{
            width: 100%;
            /*height: 100%;*/
            padding-bottom: 100px;
            position: relative;
            background-color:white;
            float: left;
            z-index: 2;
            /*padding-top: 50px;*/
        }
        #main_sider a{
            text-decoration-line: none;
        }
        #main_sider ul {
            list-style-type: none;
            line-height: 300%;
            width: 100%;
            height: 20%;
            /*width:1000px;*/
            margin:0 auto;
        }
        #main_sider ul li{
            position: relative;
            width:250px;
            text-align:center;
            line-height:60px;
            font-size:20px;
            color:#fff;
            cursor:pointer;
        }
        #main_sider ul li::before {
            content:"";
            position:absolute;
            /* 重点 */
            left:0;
            /* 重点 */
            bottom:0;
            /* 重点 */
            width:0;
            /* 重点 */
            height:2px;
            background:darkgray;
            transition:width .5s;
        }
        #main_sider ul li:hover::before {
            width:250px;
        }
        .content-box{
            width: 180px;
            height: 200px;
            position: relative;
            z-index: 6;
            float: left;
            text-align: center;
            margin-left: 15%;
            /*margin-right: 20%;*/
            margin-top: 10%;
            box-shadow: 2px 2px 5px gainsboro ;
        }
        .title{
            width: 180px;
            height: 40px;
            position: relative;
            z-index: 2;
            padding-bottom: 0;
            float: left;
            font-size: 20px;
        }
        .bu-on{
            width: 180px;
            height: 30px;
            position: relative;
            float: left;
            z-index: 2;
            font-size: 15px;
            color: darkgrey;
        }
        #main_right ul{
            float: left;
            list-style-type: none;
            width: 100%;
            position: relative;
            z-index: 3;
            /*background-color: black;*/
        }
        #main_right ul li{
            float: left;
            width: 33%;
            /*background-color: #FFE300;*/
        }
        #user_center{
            width: 20%;
            height: 80%;
            position: relative;
            float: left;
        }
    </style>
    <%--<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>--%>
    <%--<script type="text/javascript" src="login.js"></script>--%>
</head>
<body>
<%
    String user_name = (String) session.getAttribute("user_name");
%>
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
    <div id="user_center">
        <a href="user_info.jsp">用户中心</a>
        <a href="my_questionnaire.jsp?user_name=<%=user_name%>">我的问卷</a>
        <a href="login.jsp" target="_self">退出登录</a>
    </div>
</div>
<div id="main">
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
                    <a href="answer_questionnaire.jsp?questionnaire_name=<%=questionnaire_name%>&user_name=<%=user_name%>" target="_self">
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