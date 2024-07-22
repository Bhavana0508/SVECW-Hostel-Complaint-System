<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/complaintsdb?useSSL=false", "root", "1234");

    String status = request.getParameter("status");
    String id = request.getParameter("id");

    String query = "update complaints set status = ? where complaint_id = ?";
    PreparedStatement statement = con.prepareStatement(query);
    statement.setString(1, status);
    statement.setString(2, id);
    int rowsUpdated = statement.executeUpdate();

    if (rowsUpdated > 0) {
        response.sendRedirect("dataRetrieval.jsp");
    } else {
        out.println("Status update failed");
    }

    statement.close();
    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
