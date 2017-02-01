<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Fabflix</title>
</head>

<body BGCOLOR="#FDF5E6">

<div>
<%
out.println("Current session: " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
%>
</div>

<h1 align="center">Movie</h1>
<div align="center">
<%  
String file = application.getRealPath("/") + "pass.txt";
BufferedReader br = new BufferedReader(new FileReader(file));
String mysqlPass = br.readLine();



Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
        "root", mysqlPass);
    
    String id = request.getParameter("id");
    Statement moviesSt = con.createStatement();
    ResultSet moviesRs;
    moviesRs = moviesSt.executeQuery("select * from movies where id = "+ id);
    
    Statement starsSt = con.createStatement();
    ResultSet starsRs;
    starsRs = starsSt.executeQuery("select * from stars, stars_in_movies where movie_id = " + id + " and star_id = id");
    
    while (moviesRs.next()) {
    	out.print("<br><br>Title: " + moviesRs.getString(2));
        out.print("<br>Year: " + moviesRs.getInt(3));
        out.print("<br>Director: " + moviesRs.getString(4));
        out.print("<br>Stars: | ");
        while(starsRs.next()){
        	out.print("<a href=star.jsp?id=" + starsRs.getInt(1) + ">" + 
        			starsRs.getString(2) + " " + starsRs.getString(3) + "</a>" + " | ");
        }
        out.print("<br>Banner: <a href=" + moviesRs.getString(5) + ">" + moviesRs.getString(5) + "</a>");
        out.print("<br>Trailer URL: <a href=" + moviesRs.getString(6) + ">" + moviesRs.getString(6) + "</a>");
    }

%>
</div><br>
<a align="center" href="search.jsp">Search</a><br>
<a align="center" href="browse.jsp">Browse</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingcart.jsp">Cart</a><br>

</body>
</html>