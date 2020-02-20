<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/04
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <script type="text/javascript">
        function refresh() {
            //IE存在缓存,需要new Date()实现更换路径的作用
            document.getElementById("image").src="image.jsp?"+new Date();
        }
    </script>
    <link rel="stylesheet" type="text/css" href="css/login_css.css"/>
</head>
<body>
<div id=div1>
    <div id="top">
        <div id="logo">
            <img src="img/log.png">
        </div>
        <div id="login">
            <a href="reg.jsp" target="_self"><button class="top-a">注册</button></a>
            &nbsp;&nbsp;
            <a href="home_page.jsp" target="_self"><button class="top-a">首页</button></a>
        </div>
    </div>
    <form action="../servlet_login" name="denglu" method="post">
        <table align=center  >
            <tr><td>用户名：</td>
                <td><input id="user_name" type="text" name="username" class="shuru"/></td>
            </tr>
            <tr>
                <td>密码：</td>
                <td><input id="password" type="password" name="password" class="shuru"/></td>
            </tr>
            <tr>
                <td>
                    验证码：
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="text" id="check"   name="code" class="yanzheng" >
                    <input id="checkma" type="hidden" name="checkma" class="check"/>
                    <canvas id="canvas" width="150px" height="50px"></canvas>
                </td>
            <tr>
                <td colspan="2">
                    用户
                    <input type="radio" name="char" value="user" class="rad" checked="checked"/>
                    &nbsp;&nbsp;
                    管理员
                    <input type="radio" name="char" value="manager" class="rad"/>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="登录" name="dl" id=aniu></td>
            </tr>
        </table>
    </form>
</div>
</body>
<script src="js/login_js.js"></script>
<script src="js/jquery-3.2.1.js"></script>
<script>
    $(document).ready(function () {
        $("#aniu").click(function () {
            var user_name = $("#user_name").val();
            var password = $("#password").val();
            //正确的验证码
            var check_ma = $("#checkma").val();
            //输入的验证码
            var check_code = $("#check").val();
            if (user_name === "" || password === "" || check_code ==="") {
                alert("请完善登录信息！");
                return false;
            }else if (check_code!==check_ma) {
                alert("验证码不正确！");
                return false;
            }else {
                // alert(user_name +" " +password+" "+check_code+" "+check_ma);
                return true;
            }
        });
    });
</script>
</html>
