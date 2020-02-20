package servlet;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = "/save_questionnaire_name")
public class save_questionnaire_name extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=utf8");
        request.setCharacterEncoding("utf8");
        response.setCharacterEncoding("utf8");
        PrintWriter out = response.getWriter();
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
            ArrayList<FileItem> files = new ArrayList<>();
            DiskFileItemFactory fu = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(fu);
            String q_name = "";
            String num = "";
            upload.setHeaderEncoding("utf8");
            try {
                List<FileItem> list = upload.parseRequest(request);
                System.out.println("list size is"+list.size());
                for (FileItem items : list) {
                    if (items.isFormField()) {
                        if (items.getFieldName().equals("questionnaire_name")) {
                            q_name = items.getString("utf8");
                            System.out.println(q_name);
                        } else if (items.getFieldName().equals("number")) {
                            num = items.getString("utf8");
                            System.out.println(num);
                        }
                        System.out.println(items.getFieldName());
                    } else {
                        files.add(items);
                    }
                }
                String sql = "insert into questionnaire (questionnaire_name,questionnaire_image,questionnaire_num) values (?, ?,?)";
                PreparedStatement prepareStatement = con.prepareStatement(sql);
                for (int i = 0; i < files.size(); i++) {
                    FileItem item = (FileItem) files.get(i);
                    String filename = item.getName();
                    InputStream File = item.getInputStream();
                    byte[] buffer = new byte[File.available()];
                    File.read(buffer);
                    prepareStatement.setString(1, q_name);
                    prepareStatement.setBytes(2,buffer);
                    prepareStatement.setInt(3, Integer.parseInt(num));
                    prepareStatement.executeUpdate();
                    File.close();
                    System.out.println("图片等插入成功");
                    HttpSession session = request.getSession();
                    session.setAttribute("questions_num", num);
                    session.setAttribute("questionnaire_name",q_name);
                    response.sendRedirect("/online-research/online-research/add_questions.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
