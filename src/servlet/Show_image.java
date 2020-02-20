package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet(name = "Show_image", value="/Show_image")
public class Show_image extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("image/*");
        request.setCharacterEncoding("utf8");
        response.setCharacterEncoding("utf8");
        String url = "jdbc:mysql://129.204.194.69:3306/online_research";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String password = "root";
//        String username = new String(request.getParameter());
        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, userName, password);
            if (!con.isClosed()) {
                System.out.println("connected successful");
            }
            String sql = "select user_img from user_info where id = 1";
//            System.out.println(sql);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                byte[] buffer = rs.getBytes("user_img");
                OutputStream os = response.getOutputStream();
                os.write(buffer);
                System.out.println("取出成功");
            }
            stmt.close();
            rs.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
