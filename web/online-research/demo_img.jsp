<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/05
  Time: 9:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="../demo" name="upload" method="post" enctype="multipart/form-data">
    <p>选择图片url</p>
    <input type="file" name="img"/>
    <input type="submit" value="upload" />
    <a id="a" href="show_image.jsp">show image</a>
</form>
</body>
</html>
