package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.Arrays;

@WebServlet(name = "save_question_answer",value = "/save_question_answer")
public class save_question_answer extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
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
            String user_name = request.getParameter("user_name");
            String select_user_id = "select id  from user_info where user_name = '"+user_name+"'";
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(select_user_id);
            resultSet.next();
            int user_id = resultSet.getInt("id");
            int question_sum = Integer.parseInt(request.getParameter("question_sum"));
            int questionnaire_id = Integer.parseInt(request.getParameter("questionnaire_id"));
            for (int i = 0; i < question_sum; i++) {
                String answer[] = request.getParameterValues(String.valueOf(i+1));
//                System.out.println(answer);
//                String answer[] = request.getParameterValues(Integer.toBinaryString(i+1));
                String answer_all = "";
                System.out.println(answer.length);
                System.out.println(Arrays.toString(answer));
                if (answer == null) {
                    answer_all = request.getParameter(Integer.toBinaryString(i + 1));
                }else {
                    for (int j = 0; j < answer.length; j++) {
                        answer_all = answer_all + answer[j];
                    }
                }
                System.out.println((i+1)+":"+" "+answer_all);
                String sql = "insert into answer_question (user_id, questionnaire_id, question_id, answer) values(?,?,?,?)";
                PreparedStatement preparedStatement = con.prepareStatement(sql);
                preparedStatement.setInt(1,user_id);
                preparedStatement.setInt(2,questionnaire_id);
                preparedStatement.setInt(3,i+1);
                preparedStatement.setString(4,answer_all);
                preparedStatement.executeUpdate();
                System.out.println("save successful");
            }
            HttpSession session = request.getSession();
            session.setAttribute("user_name",user_name);
            response.sendRedirect("/online-research/online-research/show_questionnaire_login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
