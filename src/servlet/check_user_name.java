package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "check_user_name",value = "/u_name")
public class check_user_name extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_name = request.getParameter("user_name");
        String user_password = request.getParameter("password");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url = "jdbc:mysql://129.204.194.69:3306/online_research";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String password = "root";
        PrintWriter out = response.getWriter();
        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, userName, password);
            if (!con.isClosed()) {
                System.out.println("connected successful");
            }
            String select_user_name = "select user_name from user_info where user_name = '" + user_name + "'";
            System.out.println(select_user_name);
            Statement statement1 = con.createStatement();
            ResultSet resultSet1 = statement1.executeQuery(select_user_name);
            if (resultSet1.next()){
                out.write("用户名已存在，请重新输入！");
                resultSet1.close();
                statement1.close();
//                response.sendRedirect("/online-research/online-research/reg.jsp");
            }else {
                String save_user_info = "insert into user_info (user_name, user_sex, user_age, user_area, user_phone_number, user_QQ_mail, user_password, user_img) values(?,?,?,?,?,?,?,?)";
                PreparedStatement preparedStatement = con.prepareStatement(save_user_info);
                preparedStatement.setString(1,user_name);
                preparedStatement.setString(2,null);
                preparedStatement.setString(3,null);
                preparedStatement.setString(4,null);
                preparedStatement.setString(5,null);
                preparedStatement.setString(6,null);
                preparedStatement.setString(7,user_password);
                preparedStatement.setString(8,null);
                preparedStatement.executeUpdate();
                out.write("注册成功，请登录！");
//                response.sendRedirect("/online-research/online-research/login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
