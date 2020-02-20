<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/04
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script type="text/javascript">
        function refresh() {
            //IE存在缓存,需要new Date()实现更换路径的作用
            document.getElementById("image").src="image.jsp?"+new Date();
        }
    </script>
    <link rel="stylesheet" type="text/css" href="css/reg_css.css" />
</head>
<body>
<div id=div1>
    <div id="top">
        <div id="logo">
            <img src="img/log.png" height="40" width="40"  />
        </div>
        <div id="login">
            <a href="login.jsp" target="_self"><button class="top-a">登录</button></a>
            &nbsp;&nbsp;
            <a href="home_page.jsp" target="_self"><button class="top-a">首页</button></a>
        </div>
    </div>
    <form action="" name="denglu" method="post">
        <table align=center >
            <tr>
                <td>用户名：</td>
                <td><input id="user_name" type="text" name="username" class="shuru"/></td>
            </tr>
            <tr>
                <td>密码：</td>
                <td><input id="password1" type="password" name="password1" class="shuru"/></td>
            </tr>
            <tr>
                <td>确认密码：</td>
                <td><input id="password2" type="password" name="password2" class="shuru"/></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="注册" name="dl" id="aniu"></td>
            </tr>
        </table>
    </form>
</div>
</body>
<script src="js/jquery-3.2.1.js"></script>
<script>
    $(document).ready(function () {
        $("#aniu").click(function () {
            var user_name = $("#user_name").val();
            var password1 = $("#password1").val();
            var password2 = $("#password2").val();
            if (user_name===""){
                alert("输入用户名");
                return false;
            } else if (password1 === password2) {
                $.ajax({
                    url: "../u_name",
                    type: "get",
                    data: "&user_name=" + user_name + "&password=" + password1,
                    dataType: "text",
                    async: false,
                    success: function (result) {
                        alert(result)
                    }
                    });
            } else {
                alert("密码不符");
                return false;
            }
        });
    });
</script>
</html>
