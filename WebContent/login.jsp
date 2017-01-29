<%@ page import ="java.sql.*" %>
<%
    String email = request.getParameter("email");    
    String password = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver").newInstance();

    //change to your own password
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", "ryanjew");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from customers where email='" + email + "' and password='" + password + "'");
    if (rs.next()) {
        session.setAttribute("userid", rs.getString(1));
        session.setAttribute("firstName", rs.getString(2));
        session.setAttribute("lastName", rs.getString(3));
        response.sendRedirect("browse.jsp");
    } else {
    	out.println(email);
    	out.println(password);
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
%>