import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class SubmitComplaintServlet extends HttpServlet{
public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException{
	res.setContentType("text/html");
	PrintWriter out = res.getWriter();

	String c_id = req.getParameter("complaint_id");
        String name = req.getParameter("name");
        String regno = req.getParameter("regno");
        String block_room = req.getParameter("block_room");
        String date = req.getParameter("date");
        String complaint = req.getParameter("complaint");
	String status = req.getParameter("status");
    	if (status == null || status.isEmpty()) {
        	status = "unsolved";
    	}

	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/complaintsdb?useSSL=false","root","1234");
		String q = "insert into complaints(complaint_id, name, regno, block_room, date, complaint, status) values (?,?,?,?,?,?,?)";
		PreparedStatement stm=con.prepareStatement(q);
		
		stm.setString(1, c_id);
            	stm.setString(2, name);
            	stm.setString(3, regno);
            	stm.setString(4, block_room);
            	stm.setString(5, date);
            	stm.setString(6, complaint);
		stm.setString(7, status);

		int x = stm.executeUpdate();
		System.out.println("Date Updated Successfully.."+x);
		if(x > 0){
			res.sendRedirect("success.html");
		}
		else{
			out.println("<html>Not Successfull</html>");
		}
		con.close();
		}
		catch(Exception e){
		System.out.println(e.getMessage());
		}
	}
}