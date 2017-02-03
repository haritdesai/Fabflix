<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
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
	<div class="collection with-header">
		<li class="collection-header"><h4>Movies</h4></li>
<%
    // out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
    // out.println("You're a bitch");
    
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", mysqlPass);
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    
    if (request.getParameter("search") != null) {
    	Map<Integer,String> movieID = new HashMap<Integer,String>();
	    String title = request.getParameter("title");
		String director = request.getParameter("director");
		String year = request.getParameter("year");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		
		boolean notFirst = false;
	    Statement st = con.createStatement();
	    ResultSet rs;
	    String sqlQuery = "SELECT * FROM movies ";
	    
	    //DONT FORGET TO DO SUBSTRING MATCHING W/LIKE
	    if (!firstName.equals("") && !lastName.equals("")) {
			sqlQuery += "inner join stars_in_movies on movies.id = stars_in_movies.movie_id where stars_in_movies.star_id in (Select id from stars where first_name like " + "'" + firstName + "%" +
						"'" + " and last_name like " + "'" + lastName + "%" + "'";
			notFirst = true;
		} else if (!firstName.equals("") && lastName.equals("")) {
			sqlQuery += "inner join stars_in_movies on movies.id = stars_in_movies.movie_id where stars_in_movies.star_id in (Select id from stars where first_name like " + "'" + firstName + "%" + "'"; 
			notFirst = true;
		} else if (!lastName.equals("") && firstName.equals("")) {
			sqlQuery += "inner join stars_in_movies on movies.id = stars_in_movies.movie_id where stars_in_movies.star_id in (Select id from stars where last_name like " + "'" + lastName + "%" + "'";
			notFirst = true;
		}
	    
	    if (!title.equals("") && notFirst) {
	    	sqlQuery += " AND title like " + "'" + title + "%" + "'";
	    } else if (!title.equals("") && !notFirst) {
	    	sqlQuery += " WHERE title like " + "'" + title + "%" + "'";
	    	notFirst = true;
	    }
	    if (!director.equals("") && notFirst) {
	    	sqlQuery += " AND director like " + "'" + director + "%" + "'";
	    } else if (!director.equals("") && !notFirst) {
	    	sqlQuery += " WHERE director like " + "'" + director + "%" + "'";
	    	notFirst = true;
	    }
		if (!year.equals("") && notFirst) {
			sqlQuery += " AND year = " + "'" + year + "'";
	    } else if (!year.equals("") && !notFirst) {
	    	sqlQuery += "  WHERE year = " + "'" + year + "'";
	    	notFirst = true;
	    }
		
		if (!firstName.equals("") || !lastName.equals("")) {
			sqlQuery += ")";
		}
		
	    //out.println(sqlQuery);
	    //out.println();
		rs = st.executeQuery(sqlQuery);
	    while(rs.next()) {
	 		movieID.put(rs.getInt("id"), rs.getString("title"));
	    }
	    for (Map.Entry<Integer,String> entry: movieID.entrySet()) {
	    	out.println("<a href=\"movie.jsp?id=" + entry.getKey() + "\" class=\"collection-item\">" + entry.getValue() + "</a>");
	    }
	    
    } else if  (request.getParameter("title") != null){
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
        	out.println("<a href=\"movie.jsp?id=" + rs.getString(1) + "\" class=\"collection-item\">" + rs.getString(2) + "</a>");
    	}

    } else if (request.getParameter("genre") != null) {
    	String genre = request.getParameter("genre");
    	Statement st = con.createStatement();
        ResultSet rs;
        rs = st.executeQuery("select * from movies inner join genres_in_movies on movies.id=genres_in_movies.movie_id where genres_in_movies.genre_id="+genre);
        while (rs.next()) {
        	out.println("<a href=\"movie.jsp?id=" + rs.getString(1) + "\" class=\"collection-item\">" + rs.getString(2) + "</a>");
    	}
    }
    
%>
	</div>
</div>
</body>
</html>