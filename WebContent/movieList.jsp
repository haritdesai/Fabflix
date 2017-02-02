<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>

<!DOCTYPE html>
<html>
<head>
  <title>Fabflix</title>
</head>

<body BGCOLOR="#FDF5E6">
<h1 align="center">Welcome to Shitty Netflix</h1>
<div align="center">
<%
    out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
    out.println("You're a bitch");
    
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
	    	out.println("<a href=\"movie.jsp?id=" + entry.getKey() + "\">" + entry.getValue() + "</a><br>");
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
        	out.println("<a href=\"movie.jsp?id=" + rs.getString(1) + "\">" + rs.getString(2) + "</a><br>");
    	}

    } else if (request.getParameter("genre") != null) {
    	String genre = request.getParameter("genre");
    	Statement st = con.createStatement();
        ResultSet rs;
        rs = st.executeQuery("select * from movies inner join genres_in_movies on movies.id=genres_in_movies.movie_id where genres_in_movies.genre_id="+genre);
        while (rs.next()) {
        	out.println("<a href=\"movie.jsp?id=" + rs.getString(1) + "\">" + rs.getString(2) + "</a><br>");
    	}
    }
    
%>
</div><br>
<a align="center" href="search.jsp">Search</a><br>
<a align="center" href="browse.jsp">Browse</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingCart.jsp">Cart</a><br>

</body>
</html>