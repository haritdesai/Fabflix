<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html>
<head>
	<!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
    <!-- Import fabflix.css -->
    <link type="text/css" rel="stylesheet" href="css/fabflix.css"/>
    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<title>Employee Login</title>
	<style>
		body {
			/*background-image: url("images/movies.jpg");*/
		}
		.my-container {
			padding-top: 250px;
		}
	    .parallax-container {
	      height: 1000px;
	    }
	</style>
</head>

<body>
	<!--Import jQuery before materialize.js-->
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="js/materialize.min.js"></script>

	<div class="navbar-fixed">
	    <nav>
	        <div class="nav-wrapper container">
	            <a class="brand-logo brand-logo-small">
	                <span class="bold">Fabflix (Employee)</span>
	            </a>
	        </div>
	    </nav>
	</div>

  <div class="parallax-container">
    <div class="parallax"><img src="images/movies.jpg"></div>
	<div class="row my-container">
		<div class="col m4"></div>
		<div class="col s12 m4">
			<div class="card white">
				<div class="card-content">
					<div class="row">
						<h3 align="center">Sign In</h3>
					<form class="col s12" action="employeeLogin.jsp" method="post">
<%
    if(null!=request.getAttribute("errorMessage"))
    {
        out.println(request.getAttribute("errorMessage"));
    }
%>
						<div class="row">
							<div class="input-field col s12">
								<input id="email" type="email" name="email" class="validate">
								<label for="email">Email</label>
							</div>
						</div>
						<div class="row">
					        <div class="input-field col s12">
					          <input id="password" type="password" class="validate" name="password">
					          <label for="password">Password</label>
					        </div>
					    </div>
				        <button class="btn waves-effect waves-light" type="submit" name="action">Submit
						    <i class="material-icons right">send</i>
						</button>
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
  </div>


<footer class="page-footer">
	<div class="container">
		<div class="row">
			<div class="col l6 s12">
				<h5 class="grey-text text-darken-4">Credits:</h5>
				<p class="grey-text text-darken-4">Harit Desai</p>
				<p class="grey-text text-darken-4">Norman Ettedgui</p>
				<p class="grey-text text-darken-4">Ryan Jew</p>
			</div>
		</div>
	</div>
	<div class="footer-copyright">
		<div class="container">
© 2017 Copyright Text
		</div>
	</div>
</footer>	

</body>

<script>
    $(document).ready(function(){
      $('.parallax').parallax();
    });
</script>

</html>