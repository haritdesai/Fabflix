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

    String inputText = request.getParameter("searchStr");

    String[] inputArray = inputText.split("\\s");

    Statement moviesSt = con.createStatement();
    ResultSet moviesRs;

	String query = "SELECT title FROM movies WHERE MATCH (title) AGAINST ('";

    for(int i = 0; i < inputArray.length; i++){

    	if(i == inputArray.length-1) query += inputArray[i] + "*' IN BOOLEAN MODE)";
    	else query += "+" + inputArray[i] + " ";
	}

    moviesRs = moviesSt.executeQuery(query);

    String s = "";

    while(moviesRs.next()){
    	s += moviesRs.getString(1) + "^";
 	}

	// out.print(query);
	out.print(s);
%>