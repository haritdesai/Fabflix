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

<!-- <h1 align="center">Welcome to Shitty Netflix</h1> -->
<%
String file = application.getRealPath("/") + "pass.txt";
BufferedReader br = new BufferedReader(new FileReader(file));
String mysqlPass = br.readLine();



Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
        "root", mysqlPass);

    // out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
    // out.println("You're a bitch");
%>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="/mywebapp/browse.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="search.jsp"><i class="material-icons left">search</i>Search</a></li>
                <li class="active"><a href="browse.jsp">Browse</a></li>
                <!-- <li><a href="movieList.jsp">Movie List</a></li>
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
        <div class="col s6 m6">
            <div class="container collection with-header"> 
                <li class="collection-header"><h4>Genre</h4></li>
<%
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from genres");
    while (rs.next()) {
        out.println("<a href=\"movieList.jsp?genre=" + rs.getString(1) + "\" class=\"collection-item\">" + rs.getString(2) + "</a>");
        //out.print(" | ");
    }
%>
            </div>
        </div>
        <div class="col s6 m6">
            <div class="container collection with-header">
                <li class="collection-header"><h4>Alphanumeric</h4></li>
<%

    for(char alphabet = 'A'; alphabet <= 'Z'; alphabet++) 
	{
    	out.print("<a href= \"movieList.jsp?title=" + alphabet + "\" class=\"collection-item\">" + alphabet + "</a>");
	}
	out.println("<a href=\"movieList.jsp?title=0\" class=\"collection-item\">#</a>");
%>
            </div>
        </div>
    </div>
</div>
</body>
</html>