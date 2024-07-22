<%@page import="java.sql.*,java.util.*"%>
<html>
<body>
<%!String usr,pwd;
boolean b;
%>
<%
usr=request.getParameter("username");
pwd=request.getParameter("password");
try{
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/complaintsdb?useSSL=false","root","1234");
Statement stm=con.createStatement();
ResultSet r=stm.executeQuery("select * from studentdb where username='"+usr+"' and  password = '"+pwd+"'");
if (r.next()){
response.sendRedirect("sHome.html");
}
else{
out.println("<html>authentication failed</html>");
}
con.close();
}
catch(Exception e){
out.println(e.getMessage());
}
%>
</body>
</html>