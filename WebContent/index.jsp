<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html>
<head>
	<!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<title>Login</title>
	<style>
		body {
			background-image: url("images/doge.png");
		}
	</style>
</head>

<body>
	<!--Import jQuery before materialize.js-->
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="js/materialize.min.js"></script>

 	<div class="row">
 		<div class="col m4"></div>
 		<div class="col s12 m4">
 			<div class="card white">
 				<div class="card-content">
 					<div class="row">
 						<h3 align="center">Sign In</h3>
						<form class="col s12" action="login.jsp" method="post">
							<div class="row">
								<div class="input-field col s12">
									<input id="email" type="email" name="email">
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
</body>
</html>