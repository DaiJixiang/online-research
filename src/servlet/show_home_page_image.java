package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

@WebServlet(name = "show_home_page_image", value = "/show_home_page_image")
public class show_home_page_image extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://129.204.194.69:3306/online_research";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String password = "root";
        int questionnaire_id = Integer.parseInt(request.getParameter("questionnaire_id"));
        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, userName, password);
            if (!con.isClosed()) {
                System.out.println("connected successful");
            }
            String select_image = "select questionnaire_image from questionnaire where id = '" + questionnaire_id + "'";
            System.out.println(select_image);
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(select_image);
            resultSet.next();
            byte[] bytes = resultSet.getBytes("questionnaire_image");
            OutputStream os = response.getOutputStream();
            os.write(bytes);
            System.out.println("取出成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
