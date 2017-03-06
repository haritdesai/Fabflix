<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>


<% 
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", mysqlPass);

    String inputText = request.getParameter("movieId");

    Statement moviesSt = con.createStatement();
    ResultSet moviesRs;
    moviesRs = moviesSt.executeQuery("SELECT * FROM movies WHERE id ='" + inputText + "'");

    Statement starsSt = con.createStatement();
    ResultSet starsRs;
    starsRs = starsSt.executeQuery("SELECT * FROM stars, stars_in_movies WHERE movie_id = " + inputText + " and star_id = id");


    String s = "";

    while(moviesRs.next()){
    	s += moviesRs.getInt(1) + "^" + moviesRs.getString(2) + "^" + moviesRs.getInt(3) + "^" + moviesRs.getString(5) + "^"; 	
    }

    while(starsRs.next()){
        s += starsRs.getString(2) + " " + starsRs.getString(3) + "$";
    }

	out.print(s);
%>