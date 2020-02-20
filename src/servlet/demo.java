package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.*;

@WebServlet(name = "demo", value = "/demo")
public class demo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=utf8");
        request.setCharacterEncoding("utf8");
        response.setCharacterEncoding("utf8");
        PrintWriter out = response.getWriter();
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
            ArrayList<FileItem> files = new ArrayList<>();
            DiskFileItemFactory fu = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(fu);
            upload.setHeaderEncoding("utf8");
            try {
                List<FileItem> list = upload.parseRequest(request);
                for (FileItem items : list) {
                    if (items.isFormField()) {
                        if (items.getFieldName().equals("username")) {
                            String name = new String(items.getString().getBytes("ISO-8859-1"));
                            System.out.println(name);
                        }
                        System.out.println(items.getFieldName());
                    } else {
                        files.add(items);
                    }
                }
                String sql = "update user_info set user_img = ? where id = ?";
                PreparedStatement pstmt = con.prepareStatement(sql);
                for (int i = 0; i < files.size(); i++) {
                    FileItem item = (FileItem) files.get(i);
                    String filename = item.getName();
                    InputStream File = item.getInputStream();
                    byte[] buffer = new byte[File.available()];
                    File.read(buffer);
                    pstmt.setBytes(1,buffer);
                    pstmt.setInt(2,1);
                    pstmt.executeUpdate();
                    File.close();
                    System.out.println("图片插入成功");
                    response.sendRedirect("/online-research/online-research/demo_img.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
