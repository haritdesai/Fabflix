<%@ page import ="java.sql.*" %>
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
<div class="container">
<%
  if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
	  response.sendRedirect("index.jsp");
  }

  out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
  out.println("You can search for movies by title, director, year, or star.");
  out.println("Begin your search by entering information below!");
%>
<br>

  <form action="movieList.jsp"
        method="post">
    <div align="center">Title <input type="text" name="title"></div><br>

    <div align="center">Director <input type="text" name="director"></div><br>
    <div align="center">Year <input type="text" name="year"></div><br>
    <div align="center">Star's First Name <input type="text" name="firstName"></div><br>
    <div align="center">Star's Last Name <input type="text" name="lastName"></div><br>
    <button class="btn waves-effect waves-light" type="submit" name="search" value="Search">Submit
      <i class="material-icons right">send</i>
    </button>
  </form>
</div>
</body>
</html>