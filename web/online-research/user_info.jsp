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
    <title>login</title>
    <link rel="stylesheet" type="text/css" href="css/user_info_css.css" />
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
        <div id="home">
         <ul>
                <li>
                    <a href="home_page.jsp" style="text-decoration-line: none" class="an">
                        返回首页
                    </a>

                </li>
            </ul>
        </div>
</div>
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
//        String select_user_info = "select user_name,user_sex,user_age,user_"
%>
<div id="main_right">
    <div id="info">
        <form>
            <table id="user_info">
                <tr>
                    <td colspan="2"><img src="img/use.jpg" id="user_img"></td>
                </tr>
                <tr>
                    <td>昵称</td>
                    <td>xxxxx</td>
                </tr>
                <tr>
                    <td>性别</td>
                    <td>
                        男<input type="radio" name="sex" value="man"/>
                        &nbsp;
                        女<input type="radio" name="sex" value="woman"/>
                    </td>
                </tr>
                <tr>
                    <td>年龄</td>
                    <td>
                        <input type="text" class="user_input"/>
                    </td>
                </tr>
                <tr>
                    <td>地区</td>
                    <td>
                        <input type="text" class="user_input"/>
                    </td>
                </tr>
                <tr>
                    <td>手机号</td>
                    <td>
                        <input type="text" class="user_input"/>
                    </td>
                </tr>
                <tr>
                    <td>邮箱</td>
                    <td>
                        <input type="text" class="user_input"/>
                    </td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td>xxxxx</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="提  交" id="user_sub"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>