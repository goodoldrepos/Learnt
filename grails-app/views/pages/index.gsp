<html>
  <head>
    <meta name="layout" content="main" />
    <title>Login</title>         
  </head>
  <body>

        <div class="row">
            <div class="span12">
                <div class="page-header">
                    <h1>
                        Communautés <div class="pull-right"><g:img file="illustrations/colors.png" width="50" /></div>
                    </h1>

                </div>

            </div>
        </div>
        <g:each in="${communityInstanceList}" var="community" status="i" >
            <g:if test="${ i % 4 == 0 && i != 0 }">
                </div>
                <br/>
            </g:if>
            <g:if test="${ i % 4 == 0 }">
                <div class="row">
            </g:if>
            <div class="span3">
                <div class="tile">
                    <h3 class="tile-title">${community.name}</h3>
                    <p>Catégorie: ${community.category}</p>
                    <g:link controller="community" action="show" id="${community.id}" class="btn btn-large btn-primary btn-block" >Voir</g:link>
                </div>
            </div>


        </g:each>

    </div>
  </body>
</html>