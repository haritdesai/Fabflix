<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Fabflix</title>
</head>

<body BGCOLOR="#FDF5E6">
<h1 align="center">Welcome to Shitty Netflix</h1>
<div align="center">
<%
String file = application.getRealPath("/") + "pass.txt";
BufferedReader br = new BufferedReader(new FileReader(file));
String mysqlPass = br.readLine();



Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
        "root", mysqlPass);
    out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
    out.println("You're a bitch");
%>
</div><br>
<a align="center" href="search.jsp">Search</a><br>
<a align="center" href="browse.jsp">Browse</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingcart.jsp">Cart</a><br>
<br>
<%
	String title = request.getParameter("title");
	Statement st = con.createStatement();
    ResultSet rs;
    if (title.equals("0")) {
        rs = st.executeQuery("select * from movies where title REGEXP '^[[:digit:]].*$'");
    }
    else {
        rs = st.executeQuery("select * from movies where title like '" + title + "%'");
    }
    while (rs.next()) {
    	out.println("<a href=\"movie.jsp?id=" + rs.getString(1) + "\">" + rs.getString(2) + "</a><br>");
	}
%>
</body>
</html>