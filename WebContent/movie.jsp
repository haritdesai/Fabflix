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

<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="/mywebapp/browse.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="search.jsp"><i class="material-icons left">search</i>Search</a></li>
                <li><a href="browse.jsp">Browse</a></li>
<!--                 <li><a href="movieList.jsp">Movie List</a></li>
                <li><a href="movie.jsp">Movie</a></li>
                <li><a href="star.jsp">Star</a></li> -->
                <li><a href="shoppingCart.jsp">Cart</a></li>
            </ul>
        </div>
    </nav>
</div>
<br>

<div class="container">
    <div class="row">
        <div class="col s12 m6">
            <div class="card white">
                <div class="card-content black-text">
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
    	out.print("<span class=\"card-title\">" + moviesRs.getString(2) + "</span>");
        out.print("<br>Year: " + moviesRs.getInt(3));
        out.print("<br>Director: " + moviesRs.getString(4));
        out.print("<br>Stars: | ");
        while(starsRs.next()){
        	out.print("<a href=star.jsp?id=" + starsRs.getInt(1) + ">" + 
        			starsRs.getString(2) + " " + starsRs.getString(3) + "</a>" + " | ");
        }
        out.print("<br><img src=\"" + moviesRs.getString(5) + "\" alt=\"Missing Photo\">");
        out.print("<br>Trailer URL: <a href=" + moviesRs.getString(6) + ">" + moviesRs.getString(6) + "</a>");
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