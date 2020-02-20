package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet(name = "Show_user_info",value = "/Show_user_info")
public class Show_user_info extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("image/*");
        request.setCharacterEncoding("utf8");
        response.setCharacterEncoding("utf8");
        String url = "jdbc:mysql://129.204.194.69:3306/online_research";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String password = "root";
        HttpSession session = request.getSession();
        String user_name = (String)session.getAttribute("user_name");
        String user_password = (String) session.getAttribute("user_password");
//        String username = new String(request.getParameter());
        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, userName, password);
            if (!con.isClosed()) {
                System.out.println("connected successful");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        }
}
