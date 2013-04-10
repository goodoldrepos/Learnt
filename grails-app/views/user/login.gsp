<html>
  <head>
    <meta name="layout" content="main" />
    <title>Login</title>         
  </head>
  <body>
  <div class="row">
      <div class="span12">
          <div class="page-header">
              <h1>Connexion</h1>
          </div>
      </div>
  </div>
  <div class="row">
      <div class="span12">

          <g:if test="${flash.message}">
              <div class="alert alert-success">${flash.message}</div>
          </g:if>
          <g:if test="${flash.error}">
              <div class="alert alert-danger">${flash.error}</div>
          </g:if>
      </div>
  </div>
  <div class="row">
      <div class="offset2 span8">
          <g:form action="authenticate" method="post" class="form-horizontal" >
              <div class="control-group">
                  <label class="control-label">Email:</label>
                  <div class="controls">
                      <input type="text" id="email" name="email"/>
                  </div>
              </div>
              <div class="control-group">
                  <label class="control-label">Mot de passe:</label>
                  <div class="controls">
                      <input type="password" id="password" name="password"/>
                  </div>
              </div>
              <div class="control-group">
                  <div class="controls">
                      <input class="save btn btn-info btn-large" type="submit" value="Se connecter"  />
                  </div>
          </g:form>
      </div>
  </div>










  </body>
</html>