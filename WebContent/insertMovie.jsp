<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
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
    <title>Dashboard</title>
</head>
<body>
    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/materialize.min.js"></script>

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="logout.jsp">Sign Out</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="dashboard.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix - Dashboard</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="insertStar.jsp">Insert Star</a></li>
                <li class="active"><a href="insertMovie.jsp">Insert Movie</a></li>
                <li><a href="displayMetadata.jsp">Display Metadata</a></li>
                <li><a href="employeeLogout.jsp">Sign Out</a></li>
            </ul>
        </div>
    </nav>
</div>
<br>
<div class="container">
<%
  if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
	  response.sendRedirect("employee.jsp");
  }
%>

</body>
</html>