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
    
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", mysqlPass);
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    
    String title = request.getParameter("title");
	String director = request.getParameter("director");
	String year = request.getParameter("year");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String sort = request.getParameter("sort");
	String pageStr = request.getParameter("page");
	String genre = request.getParameter("genre");
	
    int pageNumber = 1;
    if (pageStr != null) pageNumber = Integer.parseInt(pageStr);
	
	Statement moviesSt = con.createStatement();
    ResultSet moviesRs;
    String query = "select * from movies ";
    String parameters = "";
	
    if(genre != null){ //try genre first
    	query += ", genres_in_movies where id=movie_id and genre_id=" + genre + " ";
    }
    else{ // not by genre
    	
        boolean and = false;
    
    
        if((firstName != null && firstName != "") || (lastName != null && lastName != "")) {
        	and = true;
        	        	
        	query += ", stars_in_movies where id=movie_id ";
        	
            if(firstName != null && firstName != ""){
            	Statement starsSt = con.createStatement();
            	ResultSet starsRs;
            	starsRs = starsSt.executeQuery("select id from stars where first_name like '" + firstName + "%' ");
            	
            	query += "and (";
            	while(starsRs.next()){
            		query += "star_id=" + starsRs.getInt(1) + " or ";
            	}
            	query = query.substring(0,query.length()-3) + ") ";
            	parameters += "&firstName=" + firstName;
            }
            if(lastName != null && lastName != ""){
            	Statement starsSt = con.createStatement();
            	ResultSet starsRs;
            	starsRs = starsSt.executeQuery("select id from stars where last_name like '" + lastName + "%' ");
            	
            	query += "and (";
            	while(starsRs.next()){
            		query += "star_id=" + starsRs.getInt(1) + " or ";
            	}
            	query = query.substring(0,query.length()-3) + ") ";
            	parameters += "&lastName=" + lastName;
            }
        } 

        if(title != null && title != "") {
        	if (and) query += "and ";
        	else and = true;
        	if(!query.contains("where")) query += "where ";
        	query += "title like '" + title + "%' ";
        	parameters += "&title=" + title;
        }
        if(director != null && director != ""){
        	if (and) query += "and ";
        	else and = true;
        	if(!query.contains("where")) query += "where ";
        	query += "director like '" + director + "%' ";
        	parameters += "&director=" + director;
        }
        if(year != null && year != ""){
        	if (and) query += "and ";
        	else and = true;
        	if(!query.contains("where")) query += "where ";
        	query += "year like '" + year + "%' ";
        	parameters += "&year=" + year;
        }	
    }
    

    
    
    
    /* sorting header */
    
    out.print("<br><br>");
    if(Objects.equals(sort,"desc")){
    	out.print("Sort: <a href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + "&sort=asc >" +
    			"Z-A ^</a>  |  ");
    	out.print("<a href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + "&sort=yearDesc >" +
    			"Year v</a>");
    	query += "order by title desc ";
    	parameters += "&sort=desc";
    } 
    else if(Objects.equals(sort,"yearDesc")){
    	out.print("Sort: <a href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + "&sort=desc >" +
    			"A-Z v</a>  |  ");
    	out.print("<a href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + "&sort=yearAsc >" +
    			"Year ^</a>");
    	query += "order by year desc ";
    	parameters += "&sort=desc";
    } 
    else if(Objects.equals(sort,"yearAsc")){
    	out.print("Sort: <a href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + "&sort=desc >" +
    			"A-Z v</a>  |  ");
    	out.print("<a href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + "&sort=yearDesc >" +
    			"Year v</a>");
    	query += "order by year asc ";
    	parameters += "&sort=yearAsc";
    }
    else {
    	out.print("Sort: <a href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + "&sort=desc >" +
    			"A-Z v</a>  |  ");
    	out.print("<a href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + "&sort=yearDesc >" +
    			"Year v</a>");
    	query += "order by title asc";
    }
    
    /* end sorting header */
    
    
    /* run query */
    // System.out.println(query);
    moviesRs = moviesSt.executeQuery(query);	
    
    
    
    /* store results in arrayList */
    
    ArrayList<String> resultList = new ArrayList<String>();
    while(moviesRs.next()){
    	resultList.add("<a href=movie.jsp?id=" + moviesRs.getInt(1) + " class=\"collection-item\">" + moviesRs.getString(2) + "</a>");
    }
    
    /* end store results in arrayList */
    
    /* movie results */
    
    out.print("<br><br>");
    for(int i = (pageNumber*10 - 10); i < pageNumber*10; i++){
    	if (i < resultList.size())
    		out.print(resultList.get(i));
    }
    
    /* end movie results */
    
    /* pagination footer */
    
    int lastPage = resultList.size()/10 + 1;
    
    out.print("<br><br>");
    out.print("<ul align=\"center\" class=\"pagination\">");
    if(pageNumber == 1){ // start case 
    	for(int i = 1; (i <= lastPage) && i < 11; i++){
    		if(i == pageNumber){
    			out.print("<li class=\"active\"><a href=\"#!\">1</li>");
    		} else {
    			out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(i) + parameters + ">" + Integer.toString(i) +
            			"</a></li>");
    		}
    	}
    	if(lastPage != 1){
        	out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(pageNumber+1) + parameters + ">" +
        			"<i class=\"material-icons\">chevron_right</i></a></li>");
        	out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(lastPage) + parameters + ">" +
        			"<i class=\"material-icons\">fast_forward</i></a></li>");
    	}
    }
    else if(pageNumber == lastPage){ // end case
    	out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=1" + parameters + ">" +
    			"<i class=\"material-icons\">fast_rewind</i></a></li>");
    	out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(pageNumber-1) + parameters + ">" +
    			"<i class=\"material-icons\">chevron_left</i></a></li>");
    	for(int i = (lastPage-11 < 1 ? 1 : lastPage-11); (i <= lastPage); i++){
    		if(i == pageNumber){
    			out.print("<li class=\"active\"><a href=\"#!\">"+ Integer.toString(i) +"</li>");
    		} else {
    			out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(i) + parameters + ">" + Integer.toString(i) +
            			"</a></li>");
    		}
    	}
    }
    else{ // middle cases
    	out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=1" + parameters + ">" +
    			"<i class=\"material-icons\">fast_rewind</i></a></li>");
    	out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(pageNumber-1) + parameters + ">" +
    			"<i class=\"material-icons\">chevron_left</i></a></li>");
    	
    	for(int i = (pageNumber-5 < 1 ? 1 : pageNumber-4); (i < pageNumber+6) && (i <= lastPage); i++){
    		if(i == pageNumber){
    			out.print("<li class=\"active\"><a href=\"#!\">"+ Integer.toString(i) +"</li>");
    		} else {
    			out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(i) + parameters + ">" + Integer.toString(i) +
            			"</a></li>");
    		}
    	}
    	out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(pageNumber+1) + parameters + ">" +
    			"<i class=\"material-icons\">chevron_right</i></a></li>");
    	out.print("<li class=\"waves-effect\"><a href=movieList.jsp?page=" + Integer.toString(lastPage) + parameters + ">" +
    			"<i class=\"material-icons\">fast_forward</i></a></li>");
    }
    out.print("</ul>");
    /* end pagination footer */
%>
	</div>
</div>
</body>
</html>