<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>

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
    <title>Fabflix</title>

    
</head>
<body>
    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/materialize.min.js"></script>

<style>
/* Tooltip container */
.modal{
    max-width: 30%;
    color: rgba(0,0,0,0.6);
    text-align: center;
    max-height: 90%;
    background: #e4e4e4;
    border-radius: 32px;
}

}
</style>



<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="logout.jsp">Sign Out</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="browse.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="search.jsp"><i class="material-icons left">search</i>Search</a></li>
                <li class="active"><a href="browse.jsp">Browse</a></li>
<%
                if (session.getAttribute("cart") != null)
                {
                    int quantity = ((HashMap<String,Integer>)session.getAttribute("cart")).size();
                    if (quantity > 0)
                    {
                    out.println("<li><a href=\"shoppingCart.jsp\">Cart<span class=\"new badge teal lighten-1\" data-badge-caption=\"\">"+quantity+"</span></a></li>");
                    }
                    else
                    {
                    out.println("<li><a href=\"shoppingCart.jsp\">Cart</a></li>");
                    }
                    out.println("<li><a class=\"dropdown-button\" data-beloworigin=\"true\" href=\"#!\" data-activates=\"dropdown1\">"+session.getAttribute("firstName")+"<i class=\"material-icons right\">arrow_drop_down</i></a></li>");
                }
                
%>
            </ul>
        </div>
    </nav>
</div>
<br>
<div class="container">
	<div class="collection with-header">
		<li class="collection-header">
			<div class="row">
				<div class="col s2">
					<h4>Movies</h4>
				</div>
<%
	if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
	  response.sendRedirect("index.jsp");
	}
    
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();
    br.close();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "testuser", "testpass");

    
    String title = request.getParameter("title");
	String director = request.getParameter("director");
	String year = request.getParameter("year");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String sort = request.getParameter("sort");
	String pageStr = request.getParameter("page");
	String genre = request.getParameter("genre");
	String resnum = request.getParameter("resnum");

    if(title == null || title =="") title =request.getParameter("searchField");
	
    int pageNumber = 1;
    if (pageStr != null) pageNumber = Integer.parseInt(pageStr);
    
    if(resnum == null) resnum = "10";
	
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
        	boolean first = false;
            if(firstName != null && firstName != ""){
            	Statement starsSt = con.createStatement();
            	ResultSet starsRs;
            	starsRs = starsSt.executeQuery("select id from stars where first_name like '" + firstName + "%' ");

            	if (starsRs.next()) {    
                    query += ", stars_in_movies where id=movie_id and (";
                    first = true;
                    do {
                        query += "star_id=" + starsRs.getInt(1) + " or ";
                    } while(starsRs.next());
                    query = query.substring(0,query.length()-3) + ") ";
                    parameters += "&firstName=" + firstName; 
                } 
            	
            }
            if(lastName != null && lastName != ""){
            	Statement starsSt = con.createStatement();
            	ResultSet starsRs;
            	starsRs = starsSt.executeQuery("select id from stars where last_name like '" + lastName + "%' ");
            	
                if (starsRs.next()) { 
                    if(!first) 
                        query += ", stars_in_movies where id=movie_id ";
                	query += "and (";
                	do {
                		query += "star_id=" + starsRs.getInt(1) + " or ";
                	} while(starsRs.next());
                	query = query.substring(0,query.length()-3) + ") ";
                	parameters += "&lastName=" + lastName;
                }
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
%>
    

<div class="col s9 offset-s3">  

<%
out.print("<div class=\"fixed-action-btn\">" +
				"<a class=\"waves-effect waves-light btn\">" +
  					"Res/Pg<i class=\"large material-icons right\">arrow_drop_down</i>" +
				"</a>" +
				"<ul>" +
  					"<li><a href=movieList.jsp?resnum=10" + parameters + " class=\"waves-effect waves-light btn\">10</a></li>" +
  					"<li><a href=movieList.jsp?resnum=25" + parameters + " class=\"waves-effect waves-light btn\">25</a></li>" +
  					"<li><a href=movieList.jsp?resnum=50" + parameters + " class=\"waves-effect waves-light btn\">50</a></li>" +
  					"<li><a href=movieList.jsp?resnum=100" + parameters + " class=\"waves-effect waves-light btn\">100</a></li>" +
					"</ul>" + 
			"</div>");
%>
</div>
</div>
<table class ="bordered striped">
    <thead>
        <tr>
            <th>id</th>
            <th style="width:250px;">
                <%
                    String titleHref = "";
                    String yearHref = "";

                    if (resnum != null) parameters += "&resnum=" + resnum;

                    if(Objects.equals(sort,"desc")){
                        titleHref = "&sort=asc >";
                        yearHref = "&sort=yearDesc >";
                    } 
                    else if(Objects.equals(sort,"yearDesc")){
                        titleHref = "&sort=desc >";
                        yearHref = "&sort=yearAsc >";
                    }
                    else if(Objects.equals(sort,"yearAsc")){
                        titleHref = "&sort=desc >";
                        yearHref = "&sort=yearDesc >";
                    }
                    else {
                        titleHref = "&sort=desc >";
                        yearHref = "&sort=yearDesc >";
                    }

                    out.print(      "<a class=\"chip\" href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + titleHref + "title</a>" +
                                "</th>" + 
                                "<th style=\"width:100px;\">" +
                                    "<a class=\"chip\" href=movieList.jsp?page=" + Integer.toString(pageNumber) + parameters + yearHref + "year</a>");

                    if(Objects.equals(sort,"desc")){
                        query += "order by title desc ";
                        parameters += "&sort=desc";
                    } 
                    else if(Objects.equals(sort,"yearDesc")){
                        query += "order by year desc ";
                        parameters += "&sort=desc";
                    }
                    else if(Objects.equals(sort,"yearAsc")){
                        query += "order by year asc ";
                        parameters += "&sort=yearAsc";
                    }
                    else {
                        query += "order by title asc ";
                    }
                %>
            </th>
            <th>director</th>
            <th>genres</th>
            <th>stars</th>
        </tr>
    </thead>
    <tbody>  
        <%  
            /* run query */
            moviesRs = moviesSt.executeQuery(query);

            /* store results in arrayList */
            ArrayList<String> resultList = new ArrayList<String>();

            int mCounter = 0;

            while(moviesRs.next()){
           		Statement starsSt = con.createStatement();
           		ResultSet starsRs;
           	    starsRs = starsSt.executeQuery("select * from stars, stars_in_movies where movie_id = " + moviesRs.getInt(1) + " and star_id = id");
            	    
           	    Statement genreSt = con.createStatement();
         	    ResultSet genreRs;
                genreRs = genreSt.executeQuery("select * from genres, genres_in_movies where movie_id = " + moviesRs.getInt(1) + " and genre_id = id");
            	    
            	
            	String genreList = "";
                String starList = "";

                while(starsRs.next()){
                	starList += "<a class=\"chip\" href=star.jsp?id=" + starsRs.getInt(1) + ">" + starsRs.getString(2) + " " + starsRs.getString(3) + "  </a>";
                }
                
                while(genreRs.next()){
                	genreList += "<a class=\"chip\" href=movieList.jsp?genre=" + genreRs.getInt(1) + ">" + genreRs.getString(2) + "  </a>";
                }
                
            	resultList.add( "<tr>" + 
                                    "<th>" + 
                                        "<a class=\"chip\" href=\"#modal"+mCounter+"\">" + moviesRs.getInt(1) + "</a>" +
                                        "<div class=\"popUp\" id=\"" + moviesRs.getInt(1) + "\">" +
                                            "<div id=\"modal" + mCounter + "\" class=\"modal\">" +
                                                "<div class=\"modal-content\"></div>" +
                                            "</div>" +
                                        "</div>" + 
                                    "</th>" +
                                    "<th><a class=\"chip\" href=\"movie.jsp?id=" + moviesRs.getInt(1) + "\">" +  moviesRs.getString(2) + "</a></th>" +
                                    "<th>" +  moviesRs.getInt(3) + "</th>" +
                                    "<th>" +  moviesRs.getString(4) + "</th>" +
                                    "<th>" +  genreList + "</th>" +
                                    "<th>" +  starList + "</th>" +
                                "</tr>");

                mCounter++;
            }

            int lastPage = resultList.size()/Integer.parseInt(resnum) + 1;
            /* end store results in arrayList */

            /* movie results */
            
            for(int i = (pageNumber*Integer.parseInt(resnum) - Integer.parseInt(resnum)); i < pageNumber*Integer.parseInt(resnum); i++){
            	if (i < resultList.size())
            		out.print(resultList.get(i));
            }
            
            /* end movie results */
        %>
    </tbody>
</table>

<div class="row">
	<div align="center" class="col s12"> 
<%

    /* pagination footer */
    
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
	</div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $(".modal").modal({
            ready: function(){
                $.post("fetchMovie.jsp", {"movieId": $(this).parent().attr("id")}, function(data, status){
                    var dataArr = data.split("^");
                    var starArr = dataArr[4].split("$");

                    $(".popUp .modal-content").append("<h5>" + dataArr[1] + " (" + dataArr[2] + ")</h5><br><img src=\"" + dataArr[3] + "\" style=\"width:333px;height:500px;\"><br>Staring:<br>");
                    
                    for(var i = 0; i < starArr.length; i++){
                        if(i == starArr.length-1)
                            $(".popUp .modal-content").append(starArr[i]);
                        else
                            $(".popUp .modal-content").append(starArr[i] + "<br>");  
                    }


                    $(".popUp .modal-content").append("<br><a class=\"waves-effect waves-light btn\" href=\"addToCart.jsp?id=" +  dataArr[0] + "\">Add to Cart<i class=\"material-icons right\">shopping_cart</i></a>");
                });
            },
            complete: function(){
                $(".popUp .modal-content").empty();
            }
        });
    });

</script>

</body>


</html>