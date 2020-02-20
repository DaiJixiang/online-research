<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/11
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Title</title>
    <script src="//cdn.bootcss.com/Chart.js/2.1.6/Chart.bundle.js"></script>
    <style>
        .canvas{
            width: 200px;
            height: 180px;
        }
    </style>
</head>
<body>
<%
    String questionnaire_id = request.getParameter("questionnaire_id");
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
        String select_question_num = "select questionnaire_num from questionnaire where id='" + questionnaire_id + "'";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(select_question_num);
        int sum = 0;
        while (resultSet.next()) {
            sum = resultSet.getInt("questionnaire_num");
        }
        System.out.println(sum);
//        resultSet.next();
//        int i=1;
        String select_question_name = "select question_name,choice1,choice2,choice3,choice4 from question where questionnaire_id='" + questionnaire_id + "'";
        Statement statement2 = con.createStatement();
        ResultSet resultSet2 = statement2.executeQuery(select_question_name);
        ArrayList<String> list = new ArrayList<>();
        ArrayList<String> list1 = new ArrayList<>();
        ArrayList<String> list2 = new ArrayList<>();
        ArrayList<String> list3 = new ArrayList<>();
        ArrayList<String> list4 = new ArrayList<>();
        while (resultSet2.next()) {
            list.add(resultSet2.getString("question_name"));
            list1.add(resultSet2.getString("choice1"));
            list2.add(resultSet2.getString("choice2"));
            list3.add(resultSet2.getString("choice3"));
            list4.add(resultSet2.getString("choice4"));
        }
        for (int i = 1; i <= sum; i++) {
            int a=0,b=0,c=0,d=0;
            String select_answer_num = "select answer from answer_question where questionnaire_id='" + questionnaire_id + "'and question_id = '" + i + "'";
            System.out.println(select_answer_num);
            Statement statement1 = con.createStatement();
            ResultSet resultSet1 = statement1.executeQuery(select_answer_num);
            while (resultSet1.next()) {
                String answer = resultSet1.getString("answer");
                System.out.println(answer);
                if (answer.contains("A")) {
                    a++;
                }
                if (answer.contains("B")) {
                    b++;
                }
                if (answer.contains("C")) {
                    c++;
                }
                if (answer.contains("D")){
                    d++;
                }
                System.out.println("a:"+a+" b:"+b+" c:"+c+" d:"+d);
            }
            %>
            <input type="hidden" id="a<%=i%>" value="<%=a%>">
            <input type="hidden" id="b<%=i%>" value="<%=b%>">
            <input type="hidden" id="c<%=i%>" value="<%=c%>">
            <input type="hidden" id="d<%=i%>" value="<%=d%>">
            <input type="hidden" id="s" value="<%=sum%>"/>
            <div style="text-align: center">
                <p>第<%=i%>题、<%=list.get(i - 1)%></p>
                <p>A.<%=list1.get(i-1)%> &nbsp;&nbsp;B.<%=list2.get(i-1)%></p>
                <p>C.<%=list3.get(i-1)%> &nbsp;&nbsp;D.<%=list4.get(i-1)%></p>
                <canvas class="canvas" id="myChart<%=i%>" style=" border: 2px solid black;width:200px; height:180px;"></canvas>
            </div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
<script type="text/javascript">
    var s = document.getElementById("s").value;
    // alert(s);
    for (var i =1;i<=s;i++) {
        var a = document.getElementById("a"+i).value;
        var b = document.getElementById("b"+i).value;
        var c = document.getElementById("c"+i).value;
        var d = document.getElementById("d"+i).value;
        // alert(a + b + c + d);
        // 设置参数
        var data = {
            labels: [
                "A",
                "B",
                "C",
                "D"
            ],
            datasets: [
                {
                    data: [a, b, c, d],
                    backgroundColor: [
                        "#FF6384",
                        "#36A2EB",
                        "#FFCE56",
                        "#8347ff"
                    ],
                    hoverBackgroundColor: [
                        "#FF6384",
                        "#36A2EB",
                        "#FFCE56",
                        "#8347ff"
                    ]
                }]
        };
        // Get the context of the canvas element we want to select
        var ctx = document.getElementById("myChart"+i).getContext("2d");
        ctx.width=200;
        ctx.height=200;
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: data
            // options: options
        });
    }
</script>
</html>
