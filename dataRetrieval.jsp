<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/complaintsdb?useSSL=false", "root", "1234");

    String status = request.getParameter("status");

    String query = "select * from complaints where status = ?";
    PreparedStatement statement = con.prepareStatement(query);
    statement.setString(1, status);
    ResultSet resultSet = statement.executeQuery();

    out.println("<style>");
    out.println("table {");
    out.println("    width: 80%;");
    out.println("    margin: 0 auto;"); // Align the table at the center
    out.println("    border-collapse: collapse;");
    out.println("}");
    out.println("th, td {");
    out.println("    border: 1px solid black;");
    out.println("    padding: 8px;");
    out.println("}");
    out.println("</style>");

    out.println("<table>");
    out.println("<tr><th>Complaint ID</th><th>Student Name</th><th>Registration Number</th><th>Hostel/Room</th><th>Date</th><th>Complaint</th><th>Status</th><th>Action</th></tr>");
    while (resultSet.next()) {
        String complaintId = resultSet.getString(1);
        String studentName = resultSet.getString(2);
        String regNumber = resultSet.getString(3);
        String hostelRoom = resultSet.getString(4);
        String date = resultSet.getString(5);
        String complaint = resultSet.getString(6);
        String complaintStatus = resultSet.getString(7);

        out.println("<tr>");
        out.println("<td>" + complaintId + "</td>");
        out.println("<td>" + studentName + "</td>");
        out.println("<td>" + regNumber + "</td>");
        out.println("<td>" + hostelRoom + "</td>");
        out.println("<td>" + date + "</td>");
        out.println("<td>" + complaint + "</td>");
        out.println("<td>");
        out.println("<select onchange=\"updateStatus(this.value, '" + complaintId + "')\">");
        out.println("<option value=\"unsolved\" " + (complaintStatus.equals("unsolved") ? "selected" : "") + ">Unsolved</option>");
        out.println("<option value=\"in_progress\" " + (complaintStatus.equals("in_progress") ? "selected" : "") + ">In-progress</option>");
        out.println("<option value=\"solved\" " + (complaintStatus.equals("solved") ? "selected" : "") + ">Solved</option>");
        out.println("</select>");
        out.println("</td>");
        out.println("<td><button onclick=\"updateDatabase('" + complaintId + "')\">Update</button></td>");
        out.println("</tr>");
    }
    out.println("</table>");

    resultSet.close();
    statement.close();
    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>

<script>
function updateStatus(status, complaintId) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log("Status updated successfully");
        }
    };
    xhttp.open("GET", "updateStatus.jsp?status=" + status + "&id=" + complaintId, true);
    xhttp.send();
}
</script>
