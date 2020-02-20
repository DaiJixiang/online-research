package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "delete_questionnaire",value = "/delete_questionnaire")
public class delete_questionnaire extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            String questionnaire_id = request.getParameter("questionnaire_id");
            String delete = "delete from questionnaire where id ='"+questionnaire_id+ "'";
            PreparedStatement preparedStatement = con.prepareStatement(delete);
            preparedStatement.executeUpdate();
            System.out.println("delete is OK!");
            response.sendRedirect("/online-research/online-research/magr_edit.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
