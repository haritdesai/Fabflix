<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URL" %>
<%@ page import="javax.net.ssl.HttpsURLConnection" %>
<%@ page import="javax.json.Json" %>
<%@ page import="javax.json.JsonObject" %>
<%@ page import="javax.json.JsonReader" %>

<% /* need the javax lib in the lib folder under WEB-INF */ %>

<%
    String email = request.getParameter("email");    
    String password = request.getParameter("password");
    session.setAttribute("email", email);
    session.setAttribute("password", password);
    Class.forName("com.mysql.jdbc.Driver").newInstance();

    String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
	//System.out.println("gRecaptchaResponse=" + gRecaptchaResponse);
	boolean valid = false;
	String SITE_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";
	
	if (gRecaptchaResponse == null || gRecaptchaResponse.length() == 0) {
    	valid = false;
    } else {
    	valid = true;
    }
    
	try {
		URL verifyUrl = new URL(SITE_VERIFY_URL);
		
		// Open Connection to URL
        HttpsURLConnection conn = (HttpsURLConnection) verifyUrl.openConnection();

		// Add Request Header
        conn.setRequestMethod("POST");
        conn.setRequestProperty("User-Agent", "Mozilla/5.0");
        conn.setRequestProperty("Accept-Language", "en-US,en;q=0.5");


        // Data will be sent to the server.
        String postParams = "secret=" + "6Ldx5hUUAAAAAFi1MXymM78Ln2CA4BfCjeXVJY_N" + "&response=" + gRecaptchaResponse;

        // Send Request
        conn.setDoOutput(true);
        
        // Get the output stream of Connection
        // Write data in this stream, which means to send data to Server.
        OutputStream outStream = conn.getOutputStream();
        outStream.write(postParams.getBytes());

        outStream.flush();
        outStream.close();

        // Response code return from server.
        int responseCode = conn.getResponseCode();
        System.out.println("responseCode=" + responseCode);


        // Get the InputStream from Connection to read data sent from the server.
        InputStream is = conn.getInputStream();

        JsonReader jsonReader = Json.createReader(is);
        JsonObject jsonObject = jsonReader.readObject();
        jsonReader.close();

        // ==> {"success": true}
        System.out.println("Response: " + jsonObject);

        valid = jsonObject.getBoolean("success");
	} catch (Exception e) {
		valid = false;
	}
	
	
    if (!valid) {
    	session.invalidate();
        request.setAttribute("errorMessage", "ReCaptcha Failed");
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);   
    }
    
    //change to your own password
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();

    /*	For use in shopping cart	*/
	HashMap<String,Integer> cart = new HashMap<String,Integer>();
	session.setAttribute("cart", cart);

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", mysqlPass);
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from customers where email='" + email + "' and password='" + password + "'");
    if (rs.next()) {
        session.setAttribute("userid", rs.getString(1));
        session.setAttribute("firstName", rs.getString(2));
        session.setAttribute("lastName", rs.getString(3));
        response.sendRedirect("browse.jsp");
    } else {
    	session.invalidate();
        request.setAttribute("errorMessage", "Invalid email or password");
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);       
    }
%>