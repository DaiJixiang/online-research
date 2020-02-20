<%--
  Created by IntelliJ IDEA.
  User: 11980
  Date: 2019/09/05
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="//cdn.bootcss.com/Chart.js/2.1.6/Chart.bundle.js"></script>
    <style>

    </style>
</head>
<body>
<!-- 展示canvas -->
<div style="width: 500px;">
    <canvas id="myChart" style="width:400px; height:800px;"></canvas>
</div>


<!--引入 chartjs-->



<script type="text/javascript">
    // 设置参数
    var data = {
        labels: [
            "Red",
            "Blue",
            "Yellow",
            "green"
        ],
        datasets: [
            {
                data: [300, 50, 100,200],
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
    var ctx = document.getElementById("myChart").getContext("2d");
    var myBarChart = new Chart(ctx, {
        type: 'bar',
        data: data
        // options: options
    });
</script>
</body>
</html>
