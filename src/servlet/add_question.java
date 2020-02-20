package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "add_question",value = "/add_question")
public class add_question extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            HttpSession session = request.getSession();
            int questionnaire_id = 0;
            String questionnaire_name = (String) session.getAttribute("questionnaire_name");
            String select_questionnaire_id = "select id from questionnaire where questionnaire_name ='"+questionnaire_name+"'";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(select_questionnaire_id);
            while (rs.next()) {
                questionnaire_id = Integer.parseInt(rs.getString("id"));
            }
            session.setAttribute("questionnaire_id",questionnaire_id);
            session.setAttribute("questionnaire_name", questionnaire_name);
            int question_num = Integer.parseInt((String) session.getAttribute("questions_num"));
            for (int i = 1; i <= question_num; i++) {
                String question_name = request.getParameter("question_name"+i);
                int remark = Integer.parseInt(request.getParameter("remark"+i));
                String A_choice = request.getParameter("A_choice" + i);
                String B_choice = request.getParameter("B_choice" + i);
                String C_choice = request.getParameter("C_choice" + i);
                String D_choice = request.getParameter("D_choice" + i);
                String save_question = "insert into question (question_name,questionnaire_id,remark,choice1,choice2,choice3,choice4) values(?,?,?,?,?,?,?)";
                PreparedStatement preparedStatement = con.prepareStatement(save_question);
                preparedStatement.setString(1,question_name);
                preparedStatement.setInt(2,questionnaire_id);
                preparedStatement.setInt(3,remark);
                preparedStatement.setString(4, A_choice);
                preparedStatement.setString(5,B_choice);
                preparedStatement.setString(6,C_choice);
                preparedStatement.setString(7,D_choice);
                preparedStatement.executeUpdate();
                System.out.println("question "+i+" has been saved!");
            }
            response.sendRedirect("/online-research/online-research/add_questionnaire_successful.jsp");
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
