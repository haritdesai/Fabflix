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

<h1 align="center">Star</h1>
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
moviesRs = moviesSt.executeQuery("select * from movies, stars_in_movies where movie_id = id  and star_id = " + id);

Statement starsSt = con.createStatement();
ResultSet starsRs;
starsRs = starsSt.executeQuery("select * from stars where id = " + id);

while (starsRs.next()) {
	out.print("<br><br>Name: " + starsRs.getString(2) + " " + starsRs.getString(3));
    out.print("<br>DOB: " + starsRs.getDate(4));
    out.print("<br>Photo URL: <a href=" + starsRs.getString(5) + ">" + starsRs.getString(5) + "</a>");
    out.print("<br>Movies: | ");
    while(moviesRs.next()){
    	out.print("<a href=movie.jsp?id=" + moviesRs.getInt(1) + ">" + 
    				moviesRs.getString(2) + "</a> (" + moviesRs.getInt(3) + ") | ");
    }
}
%>
</div><br>
<a align="center" href="search.jsp">Search</a><br>
<a align="center" href="browse.jsp">Browse</a><br>
<a align="center" href="browseByMovieGenre.jsp">Browse by Movie Genre</a><br>
<a align="center" href="browseByMovieTitle.jsp">Browse by Movie Title</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingcart.jsp">Cart</a><br>

</body>
</html>