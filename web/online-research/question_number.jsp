<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/05
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #top{
            width: 100%;
            height: 10%;
            background-color:lightblue;
            position: relative;
            float: left;
        }
        #bottom{
            width: 100%;
            height: 90%;
            /*background-color: darkgreen;*/
            position: relative;
            float: left;
        }
        #logo{
            position: relative;
            width: 10%;
            height: 80%;
            /*background-color: black;*/
            float: left;
            z-index: 2;
            margin-left: 3%;
            margin-top: 5px;
            margin-right: 5%;
        }
        #user{
            height: 0;
            width:15%;
            float: left;
            z-index: 2;
            margin-left: 0;
            border-radius:20px ;
            background-color:#F8F8FF;
            position: relative;
        }
        #div2{
            height: 50px;
            width: 50px;
            background-color: beige;
            margin-left: 60%;
            margin-top: 10px;
            position: relative;
            float: left;
        }
        #main_window{
            width: 100%;
            height: 100%;
            /*background-color: blue;*/
            position: relative;
            float: left;
        }
        #window_center{
            width: 50%;
            height: 50%;
            position: relative;
            top: 10%;
            left: 25%;
        }
        form{
            width: 100%;
            height: 100%;
        }
        table{
            border: black 2px solid;
            text-align: center;
        }
    </style>
</head>
<body>
<div id="top">
    <div id="logo">
        <img alt="" src="img/log.png" width="40" height="40">
        在线调查系统
    </div>
    <div id="div2">
        <span><img alt="" src="../Show_image" width="100%" height="60%" align="center"></span>
    </div>
</div>
<div id="bottom">
    <div id="main_window">
        <div id="window_center">
            <form action="../save_questionnaire_name" name="upload" method="post" enctype="multipart/form-data" >
                <table>
                    <tr>
                        <td>
                            输入问卷名称：
                        </td>
                        <td>
                            <input name="questionnaire_name" type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            上传问卷封面：
                        </td>
                        <td>
                            <input type="file" name="questionnaire_image" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            输入问卷题目数量：
                        </td>
                        <td>
                            <input type="text" name="number"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="确认"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
</body>
</html>
