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

@WebServlet(name = "update_questionnaire",value = "/update_questionnaire")
public class update_questionnaire extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
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
            int questionnaire_id = (int) session.getAttribute("questionnaire_id");
            String questionnaire_name = (String) session.getAttribute("questionnaire_name");
            session.setAttribute("questionnaire_id", questionnaire_id);
            session.setAttribute("questionnaire_name", questionnaire_name);
            String select_question_num = "select questionnaire_num from questionnaire where id='" + questionnaire_id + "'";
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(select_question_num);
            resultSet.next();
            int question_num = resultSet.getInt("questionnaire_num");
            for (int i = 1; i <= question_num; i++) {
                String question_name = request.getParameter("question_name" + i);
//                int remark = Integer.parseInt(request.getParameter("remark" + i));
                String A_choice = request.getParameter("A_choice" + i);
                String B_choice = request.getParameter("B_choice" + i);
                String C_choice = request.getParameter("C_choice" + i);
                String D_choice = request.getParameter("D_choice" + i);
                String question_ids = request.getParameter("question" + i);
                int question_id = Integer.parseInt(question_ids);
                String update_question = "update question set question_name=?,choice1=?,choice2=?,choice3=?,choice4=? where questionnaire_id=? and id=?";
                PreparedStatement preparedStatement = con.prepareStatement(update_question);
                preparedStatement.setString(1, question_name);
                preparedStatement.setString(2, A_choice);
                preparedStatement.setString(3, B_choice);
                preparedStatement.setString(4, C_choice);
                preparedStatement.setString(5, D_choice);
                preparedStatement.setInt(6, questionnaire_id);
                preparedStatement.setInt(7, question_id);
                preparedStatement.executeUpdate();
                System.out.println("question " + i + " has been updated!");
            }
            response.sendRedirect("/online-research/online-research/magr_edit.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
