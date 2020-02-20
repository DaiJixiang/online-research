<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/08
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String questionnaire_name = (String) session.getAttribute("questionnaire_name");
    System.out.println("questionnaire_name is "+questionnaire_name);
%>
<p>问卷添加完毕！</p>
<p><a href="show_questionnaire.jsp?questionnaire_name=<%=questionnaire_name%>">点击查看详情</a></p>
</body>
</html>
