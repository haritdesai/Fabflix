<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
    <!--Import fabflix.css-->
    <link type="text/css" rel="stylesheet" href="css/fabflix.css"/>
    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Fabflix</title>
</head>
<body>
    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/materialize.min.js"></script>

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="/mywebapp/logout.jsp">Sign Out</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="/mywebapp/browse.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="search.jsp"><i class="material-icons left">search</i>Search</a></li>
                <li class="active"><a href="browse.jsp">Browse</a></li>
                <li><a href="shoppingCart.jsp">Cart</a></li>
<%
                out.println("<li><a class=\"dropdown-button\" data-beloworigin=\"true\" href=\"#!\" data-activates=\"dropdown1\">"+session.getAttribute("firstName")+"<i class=\"material-icons right\">arrow_drop_down</i></a></li>");
%>
            </ul>
        </div>
    </nav>
</div>
<br>

<div class="container">
    <div class="row">
        <div class="col s12 m6 offset-m3">
            <div class="card white">
                <div class="card-content black-text">
<%
if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
	  response.sendRedirect("index.jsp");
}

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
	out.print("<span class=\"card-title\">" + starsRs.getString(2) + " " + starsRs.getString(3) + "</span>");
    out.print("<br>DOB: " + starsRs.getDate(4));
    out.print("<br><img src=\"" + starsRs.getString(5) + "\" alt=\"Missing Photo\">");
    out.print("<br>Movies: | ");
    while(moviesRs.next()){
    	out.print("<a href=movie.jsp?id=" + moviesRs.getInt(1) + ">" + 
    				moviesRs.getString(2) + "</a> (" + moviesRs.getInt(3) + ") | ");
    }
}
%>

                </div>
                <div class="card-action">
                    <a href="#">This is a link</a>
                    <a href="#">This is a link</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>