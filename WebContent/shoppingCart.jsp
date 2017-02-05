<<<<<<< HEAD
<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
=======
<%@ page import="java.util.*"%>
>>>>>>> aca1ea09570059e0d7fece38a623899d7a9dfdff
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

<<<<<<< HEAD
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

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="/mywebapp">Sign Out</a></li>
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
                <!-- <li><a href="movieList.jsp">Movie List</a></li>
                <li><a href="movie.jsp">Movie</a></li>
                <li><a href="star.jsp">Star</a></li> -->
                <li><a href="shoppingCart.jsp">Cart</a></li>
<%
                out.println("<li><a class=\"dropdown-button\" href=\"#!\" data-activates=\"dropdown1\">"+session.getAttribute("firstName")+"<i class=\"material-icons right\">arrow_drop_down</i></a></li>");
%>
            </ul>
        </div>
    </nav>
</div>
<br>
=======
<body BGCOLOR="#FDF5E6">
<h1 align="center">Shopping Cart</h1>
<div align="center">
<%
	if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
	  response.sendRedirect("index.jsp");
	}

    out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
    out.println("<br></br>");
    out.println("Movies:");
    
    Map<String,Integer> cart = (HashMap<String,Integer>)session.getAttribute("cart");
    
    if (!cart.isEmpty()) {
	    for (Map.Entry<String,Integer> entry: cart.entrySet())
	    	out.println("<br></br>" + entry.getKey() + ": " + entry.getValue());
    }
    
%>

</div><br>
<a align="center" href="search.jsp">Search</a><br>
<a align="center" href="browse.jsp">Browse</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingCart.jsp">Cart</a><br>
>>>>>>> aca1ea09570059e0d7fece38a623899d7a9dfdff

</body>
</html>