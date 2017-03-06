<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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

<%
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();
    br.close();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "testuser", "testpass");

%>

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
    <div class="row">
        <div class="col s12 m6 offset-m3">
            <div class="card white">
                <div class="card-content black-text">
                	<span class="card-title">Insertion Status</span>
<%
	try {
	    String title = request.getParameter("title");
	    if (title.isEmpty()) {
	    	out.println("Title is Empty<br>");
	    }
	    String director = request.getParameter("director");
	    if (director.isEmpty()) {
	    	out.println("Director is Empty<br>");
	    }
	    int year;
	    if (request.getParameter("year").equals("")) {
	    	year = -1;
	    }
	    else {
			year = Integer.parseInt(request.getParameter("year"));
	    }
	    if (year == -1) {
	    	out.println("Year is Empty<br>");
	    }
	    String banner_url = request.getParameter("banner_url");
	    String trailer_url = request.getParameter("trailer_url");
	    String firstName = request.getParameter("firstName");
	    if (firstName.isEmpty()) {
	    	out.println("Star's first name is empty<br>");
	    }
		String lastName = request.getParameter("lastName");
		if (lastName.isEmpty()) {
	    	out.println("Star's last name is empty<br>");
	    }
		String genre = request.getParameter("genre");
		if (genre.isEmpty()) {
	    	out.println("Genre is empty<br>");
	    }

	    out.println("Starting Insertion<br>");
		String query = "{CALL add_movie(?, ?, ?, ?, ?, ?, ?, ?)}";
		CallableStatement stmt = con.prepareCall(query);
		stmt.setString(1, title);
		stmt.setInt(2, year);
		stmt.setString(3, director);
		stmt.setString(4, banner_url);
		stmt.setString(5, trailer_url);
		stmt.setString(6, firstName);
		stmt.setString(7, lastName);
		stmt.setString(8, genre);
		stmt.execute();
		out.println("Insertion Successful :)<br>");
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        out.println("Insertion Failed!");
        out.println(e.getMessage());
    }
%>  
                </div>
            </div>
        </div>
    </div>
</div>

</body>

</html>