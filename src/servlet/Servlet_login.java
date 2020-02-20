package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(value="/servlet_login")
public class Servlet_login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://129.204.194.69:3306/online_research";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String password = "root";
        try{
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, userName, password);
            if (!con.isClosed()){
                System.out.println("connected successful");
            }
            String user_name = request.getParameter("username");
            String user_password = request.getParameter("password");
            String user_type = request.getParameter("char");
            System.out.println(user_type);
//            System.out.println(user_name+user_password);
            if (user_type.equals("user")) {
                String sql_check = "select * from user_info where user_name='" + user_name + "' and user_password='" + user_password + "'";
                System.out.println(sql_check);
                Statement statement = con.createStatement();
                ResultSet rs = statement.executeQuery(sql_check);
                HttpSession session = request.getSession();
                if (rs.next()) {
//                System.out.println("ok");
                    session.setAttribute("user_name", user_name);
                    response.sendRedirect("/online-research/online-research/show_questionnaire_login.jsp");
                } else {
                    response.sendRedirect("/online-research/online-research/error.jsp");
                }
            }
            if (user_type.equals("manager")){
                String check_name = "select id from mag_info where mag_name='" + user_name + "'and mag_password='" + user_password + "'";
                Statement statement1 = con.createStatement();
                ResultSet resultSet1 = statement1.executeQuery(check_name);
                HttpSession session = request.getSession();
                if (resultSet1.next()) {
//                System.out.println("ok");
                    session.setAttribute("mag_name", user_name);
                    response.sendRedirect("/online-research/online-research/magr_page.jsp");
                } else {
                    response.sendRedirect("/online-research/online-research/error.jsp");
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
