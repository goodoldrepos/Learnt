<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<g:javascript library="jquery" plugin="jquery"/>
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">

        <g:layoutHead/>
		<r:layoutResources />
		<g:javascript src="bootstrap.js" />		
		
		
	</head>
	<body class="container">
		<script type="text/javascript">
		$(document).ready(function () {
			 $('.dropdown-toggle').dropdown();
		});
		</script>
		<br/>
		<div class="navbar">
  			<div class="navbar-inner">
                  <a class="brand" href="#">learntX</a>
    			<ul class="nav ">
      				<li><g:link controller="pages" action="index" ><i class="icon-home"></i></g:link></li>
      				<g:if test="${session?.user != null }">
                          <li><g:link controller="user" action="show" id="${session?.user?.id }" ><i class="icon-user"></i></g:link></li>
                          <li><g:link controller="pages" action="index" id="${session?.user?.id }" ><i class="icon-th"></i></g:link></li>
                      </g:if>
      				<g:else>
      					<li><g:link controller="user" action="create" >S'inscrire</g:link></li>
      				</g:else>










                </ul>
                      <ul class="nav pull-right">

                      <g:if test="${session?.user?.role == 'admin' }">


                          <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Administration <b class="caret"></b></b></a>
                              <ul class="dropdown-menu">
                                  <li class="dropdown-submenu">
                                      <a tabindex="-1" href="#">Communauté</a>
                                      <ul class="dropdown-menu pull-right">
                                          <li><g:link controller="community" action="create" >Nouvelle Communauté</g:link></li>
                                          <li><g:link controller="community" action="list" >Liste des Communautés</g:link></li>
                                      </ul>
                                  </li>
                                  <li class="dropdown-submenu">
                                      <a tabindex="-1" href="#">Utilisateurs</a>
                                      <ul class="dropdown-menu">
                                          <li><g:link controller="user" action="list" >Liste des utilisateurs</g:link></li>
                                      </ul>
                                  </li>

                              </ul>
                          </li>
                          <li class="divider-vertical"></li>
                        </g:if>
                          <li><g:loginControl/></li>
                      </ul>







              </div>
		</div>
		
		<g:layoutBody/>
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>
