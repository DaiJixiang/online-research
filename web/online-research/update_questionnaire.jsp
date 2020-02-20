<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
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
            /*height: 90%;*/
            padding-bottom: 200px;
            /*background-color: darkgreen;*/
            position: relative;
            float: left;
            text-align: center;
        }
        #logo{
            position: relative;
            width: 10%;
            height: 80%;
            background-color: black;
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
        form{
            width: 50%;
            /*border: blue 2px solid;*/
            position: relative;
            float: left;
            left: 25%;
            text-align: center;
            top: 30px;
        }
        #questions{
            width: 100%;
            text-align: center;
            border: black 2px solid;
            position: relative;
            float: left;
        }
    </style>
</head>
<body>
<%
//    int num = Integer.parseInt((String) session.getAttribute("questions_num"));
//    System.out.println(num);
//    String questionnaire_ids = (String)session.getAttribute("questionnaire_id");
//    System.out.println(questionnaire_ids);
    int questionnaire_id = Integer.parseInt(request.getParameter("questionnaire_id"));
    System.out.println(questionnaire_id);
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
        String select_questions = "select id,questionnaire_name, questionnaire_num from questionnaire where id='"+questionnaire_id+ "'";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(select_questions);
        int question_id=0;
        int num=0;
        String questionnaire_name = "";
        while (resultSet.next()) {
//            question_id = resultSet.getInt("id");
            num = resultSet.getInt("questionnaire_num");
            questionnaire_name = resultSet.getString("questionnaire_name");
        }
//        System.out.println(question_id);
        System.out.println(num);
//        String questionnaire_name = resultSet.getString("questionnaire_name");
//        int questionnaire_id = resultSet.getInt("id");
        session.setAttribute("questionnaire_name",questionnaire_name);
//        session.setAttribute("question_id",question_id);
        session.setAttribute("questionnaire_id",questionnaire_id);
%>
<div id="top">
    <div id="logo">
        <img src="img/log.png" width="40" height="40">
    </div>
</div>
<div id="bottom">
    <form action="../update_questionnaire" method="post" name="add_question">
        <table id="questions">
            <tr>
                <td colspan="2" style="font-size: xx-large;height: 25px"><%= questionnaire_name%>
                </td>
            </tr>
            <%
                String select_question_choice = "select id, question_name,remark,choice1,choice2,choice3,choice4 from question where questionnaire_id='" + questionnaire_id + "'";
                Statement statement1 = con.createStatement();
                ResultSet resultSet1 = statement1.executeQuery(select_question_choice);
                for (int i = 0; i < num; i++) {
                    resultSet1.next();
                    question_id = resultSet1.getInt("id");
            %>
            <tr>
                <td colspan="2">输入第<%= i + 1%>题题目：&nbsp;<input name="question_name<%=i+1%>" value="<%=resultSet1.getString("question_name")%>"/>
                    <input type="hidden" name="question<%=i+1%>" value="<%=question_id%>" />
                </td>
            </tr>
            <tr>
                <td>
                    A.<input type="text" name="A_choice<%=i+1%>" value="<%=resultSet1.getString("choice1")%>"/>
                </td>
                <td>
                    B.<input type="text" name="B_choice<%=i+1%>" value="<%=resultSet1.getString("choice2")%>"/>
                </td>
            </tr>
            <tr>
                <td>
                    C.<input type="text" name="C_choice<%=i+1%>" value="<%=resultSet1.getString("choice3")%>"/>
                </td>
                <td>
                    D.<input type="text" name="D_choice<%=i+1%>" value="<%=resultSet1.getString("choice4")%>"/>
                </td>
            </tr>
            <tr style="height: 60px"></tr>
            <%
                }
            %>
            <tr>
                <td colspan="2">
                    <button>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
<script src="js/jquery-3.2.1.js"></script>
<script>
    function prve() {
        // alert("0");
        var index = $("form .current").index();
        if (index > 0) {
            $("form div").eq(index-1).addClass("current").siblings().removeClass("current");
            // $("form div").eq(index -1).show().siblings().hide();
        }
    }
    function next(){
        // alert("1");
        var len = $("form").children().length;
        var index = $("form .current").index();
        // alert(len + " " + index);
        if(index < len - 1){
            $("form div").eq(index+1).addClass("current").siblings().removeClass("current");
            // $("form div").eq(index + 1).show().siblings().hide();
        }
    }
</script>
</html>
