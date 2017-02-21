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
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", mysqlPass);

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
<%
	try {
	    String title = request.getParameter("title");
	    String director = request.getParameter("director");
	    int year;
	    if (request.getParameter("year").equals("")) {
	    	year = -1;
	    }
	    else {
			year = Integer.parseInt(request.getParameter("year"));
	    }
	    String banner_url = request.getParameter("banner_url");
	    String trailer_url = request.getParameter("trailer_url");
	    String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String genre = request.getParameter("genre");
		int movie_id;
		int genre_id;
		int star_id;

	    PreparedStatement preparedStmt;
	    ResultSet rs;


		String queryString = "select id, year, director, banner_url, trailer_url from movies where title = ?";
		preparedStmt = con.prepareStatement(queryString);
		preparedStmt.setString(1, title);
		rs = preparedStmt.executeQuery();

		//If movie exists already, update existing movie
		if (rs.next()) {
			movie_id = rs.getInt(1);
			queryString = "update movies set year = ?, director = ?, banner_url = ?, trailer_url = ? where title = ?";
			preparedStmt = con.prepareStatement(queryString);
            if (year != -1) {
            	preparedStmt.setInt(1, year);
            }
            else {
            	preparedStmt.setInt(1, rs.getInt(2));
            }
            if (!director.isEmpty()) {
            	preparedStmt.setString(2, director);
            }
            else {
            	preparedStmt.setString(2, rs.getString(3));
            }
            if (!banner_url.isEmpty()) {
            	preparedStmt.setString(3, banner_url);
            }
            else {
            	preparedStmt.setString(3, rs.getString(4));
            }
			if (!trailer_url.isEmpty()) {
            	preparedStmt.setString(4, trailer_url);
            }
            else {
            	preparedStmt.setString(4, rs.getString(5));
            }
            preparedStmt.setString(5, title);
            preparedStmt.execute();

		}
		//Else if movie does not exist, make it
		else {
			queryString = "insert into movies (title, year, director, banner_url, trailer_url) VALUES (?, ?, ?, ?, ?)";
			preparedStmt = con.prepareStatement(queryString);
			preparedStmt.setString(1, title);
			preparedStmt.setInt(2, year);
			preparedStmt.setString(3, director);
			preparedStmt.setString(4, banner_url);
			preparedStmt.setString(5, trailer_url);
			preparedStmt.execute();
			queryString = "select id, year, director, banner_url, trailer_url from movies where title = ?";
			preparedStmt = con.prepareStatement(queryString);
			preparedStmt.setString(1, title);
			rs = preparedStmt.executeQuery();
			rs.next();
			movie_id = rs.getInt(1);
		}

		//add star
		if (!(lastName.isEmpty() && firstName.isEmpty())) {
			queryString = "select id from stars where first_name = ? and last_name = ?";
			preparedStmt = con.prepareStatement(queryString);
			preparedStmt.setString(1, firstName);
			preparedStmt.setString(2, lastName);
			rs = preparedStmt.executeQuery();
			if (rs.next()) {
				//Check if actor already in movie
				star_id = rs.getInt(1);
				queryString = "select * from stars_in_movies where star_id = ? and movie_id = ?";
				preparedStmt = con.prepareStatement(queryString);
				preparedStmt.setInt(1, star_id);
				preparedStmt.setInt(2, movie_id);
				rs = preparedStmt.executeQuery();
				//If not, add actor in movie
				if (!rs.next()) {
					queryString = "insert into stars_in_movies (star_id, movie_id) values (?, ?)";
					preparedStmt = con.prepareStatement(queryString);
					preparedStmt.setInt(1, star_id);
					preparedStmt.setInt(2, movie_id);
					preparedStmt.execute();
				}
			}
			//Create star if does not exist
			else {
				if (lastName.isEmpty() && !firstName.isEmpty())
			    {
			    	lastName = firstName;
			    	firstName = "";
			    }
			    queryString = "INSERT INTO stars (first_name, last_name) VALUES (?, ?)";
	            preparedStmt = con.prepareStatement(queryString);
	            preparedStmt.setString(1, firstName);
	            preparedStmt.setString(2, lastName);
	            preparedStmt.execute();
	            queryString = "select id from stars where first_name = ? and last_name = ?";
				preparedStmt = con.prepareStatement(queryString);
				preparedStmt.setString(1, firstName);
				preparedStmt.setString(2, lastName);
				rs = preparedStmt.executeQuery();
				if (rs.next()) {
					queryString = "insert into stars_in_movies (star_id, movie_id) values (?, ?)";
					preparedStmt = con.prepareStatement(queryString);
					preparedStmt.setInt(1, rs.getInt(1));
					preparedStmt.setInt(2, movie_id);
					preparedStmt.execute();
				}
			}
		}

		//add genre
		if (!genre.isEmpty()) {
			queryString = "select id from genres where name = ?";
			preparedStmt = con.prepareStatement(queryString);
			preparedStmt.setString(1, genre);
			rs = preparedStmt.executeQuery();
			if (rs.next()) {
				//Check if genre already in movie
				genre_id = rs.getInt(1);
				queryString = "select * from genres_in_movies where genre_id = ? and movie_id = ?";
				preparedStmt = con.prepareStatement(queryString);
				preparedStmt.setInt(1, genre_id);
				preparedStmt.setInt(2, movie_id);
				rs = preparedStmt.executeQuery();
				//If not, add genre into movie
				if (!rs.next()) {
					queryString = "insert into genres_in_movies (genre_id, movie_id) values (?, ?)";
					preparedStmt = con.prepareStatement(queryString);
					preparedStmt.setInt(1, genre_id);
					preparedStmt.setInt(2, movie_id);
					preparedStmt.execute();
				}

				
			}
			//Create genre if doesn't exist
			else {
				queryString = "insert into genres (name) values (?)";
				preparedStmt = con.prepareStatement(queryString);
				preparedStmt.setString(1, genre);
				preparedStmt.execute();

				queryString = "select id from genres where name = ?";
				preparedStmt = con.prepareStatement(queryString);
				preparedStmt.setString(1, genre);
				rs = preparedStmt.executeQuery();
				if (rs.next()) {
					queryString = "insert into genres_in_movies (genre_id, movie_id) values (?, ?)";
					preparedStmt = con.prepareStatement(queryString);
					preparedStmt.setInt(1, rs.getInt(1));
					preparedStmt.setInt(2, movie_id);
					preparedStmt.execute();
				}
			}
		}

	out.println("<span class=\"card-title\">Insertion Confirmed!</span>");
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        out.println("<span class=\"card-title\">Insertion Failed</span>");
    }
%>  
                </div>
            </div>
        </div>
    </div>
</div>

</body>

</html>