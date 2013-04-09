
<%@ page import="com.braksa.Community" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>${communityInstance?.name} - Communauté</title>
	</head>
	<body>
            <div class="row">
                <div class="span12">


                </div>
            </div>

            <div class="row">
                <div class="span12">
                    <div class=" page-header">
                        <h1>
                            <g:img file="illustrations/share.png" width="50" /> &nbsp; #${communityInstance?.name}


                            <div class="pull-right">
                                <g:if test="${session?.user?.follow(communityInstance.id)}">
                                    <g:link controller="community" action="unsubscribe" id="${communityInstance.id}" >
                                        <input type="button" class="btn btn-small disabled" value="Se désabonner" />
                                    </g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="community" action="subscribe" id="${communityInstance.id}" >
                                        <input type="button" class="btn btn-small btn-success" value="S'abonner" />
                                    </g:link>
                                </g:else>
                            </div>
                        </h1>
                    </div>
                </div>
            </div>




			<g:if test="${flash.message}">
			    <div class="message" role="status">${flash.message}</div>
			</g:if>


    <br/>

			<div class="row">
                <div class="span5">
                    <h1><small>Ressources populaires</small> <span data-toggle="tooltip" id="resource-tooltip" title="Ajouter une nouvelle ressource"><a href="#" class="add-resource"><g:img file="icons/glyphicons_190_circle_plus.png" width="20" /></a></span></h1>
                    <table class="table">
                        <thead>
                            <tr>
                            <g:sortableColumn property="title" title="${message(code: 'resource.title.label', default: 'Resource')}" />
                            <g:sortableColumn property="type" title="${message(code: 'resource.type.label', default: 'Type')}" />
                            </tr>
                        </thead>
                        <g:each in="${resourceInstanceList.asList().sort{it.upvotes.size()}.asList().reverse()}" status="i" var="resourceInstance">
                            <tr>
                                <td><a href="${fieldValue(bean: resourceInstance, field: "link")}">${fieldValue(bean: resourceInstance, field: "title")}</a></td>
                                <td>${fieldValue(bean: resourceInstance, field: "type")}</td>
                                <td>[${resourceInstance.upvotes.size()}] <g:link controller="resource" action="upvote" id="${resourceInstance.id}" class="pull-right"> <g:img file="icons/glyphicons_019_heart_empty.png" width="15" /> </g:link></td>
                            </tr>
                        </g:each>
                    </table>
                    <div class="pagination">
                        <g:paginate total="${resourceInstanceTotal}" />
                    </div>
                </div>
                <div class="offset1 span5">
                    <h1><small>Questions récentes</small> <span data-toggle="tooltip" id="question-tooltip" title="Ajouter une nouvelle question"><a href="#" class="add-question"><g:img file="icons/glyphicons_190_circle_plus.png" width="20" /></a></span></h1>
                    <table class="table ">
                        <thead>
                        <tr>
                            <g:sortableColumn property="content" title="${message(code: 'question.content.label', default: 'Question')}" />
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                            <tr>
                                <td><g:link controller="question" action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "content")}</g:link></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <div class="pagination">
                        <g:paginate total="${questionInstanceTotal}" />
                    </div>
                </div>

			</div>


            <div class="modal modal-new-resource hide fade">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3>Ajouter une ressource</h3>
                </div>
                <div class="modal-body">
                    <g:form action="save" controller="resource" >
                        <fieldset class="form text-center">
                            <g:render template="create_resource"/>
                            <g:hiddenField name="idCommunity" value="${communityInstance?.id}" />
                            <g:hiddenField name="idUser" value="${session?.user?.id }" />
                        </fieldset>

                </div>
                <div class="modal-footer">
                <fieldset class="buttons">
                        <g:submitButton name="create" class="save btn btn-primary btn-large btn-block" value="${message(code: 'default.button.create.label', default: 'Creer')}" />
                        </fieldset>
                    </g:form>
                </div>
            </div>





    <div class="modal modal-new-question hide fade">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>Poser une question</h3>
        </div>
    <div class="modal-body">
        <g:form action="save" controller="question" >
            <fieldset class="form">
                <g:render template="create_question"/>
                <g:hiddenField name="idCommunity" value="${communityInstance?.id}" />
                <g:hiddenField name="idUser" value="${session?.user?.id }" />
            </fieldset>


            </div>
            <div class="modal-footer">
            <fieldset class="buttons">
            <g:submitButton name="create" class="save btn btn-primary btn-block btn-large" value="${message(code: 'default.button.create.label', default: 'Creer')}" />
            </fieldset>
        </g:form>
    </div>
    </div>

            <g:if test="${communityInstance?.members}">
                <h1><small><g:message code="community.members.label" default="Membres" /></small></h1>
                <g:each in="${communityInstance.members}" var="m">
                    <p class="well well-small"><g:link controller="user" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></p>
                </g:each>
            </g:if>

			<br/>


            <div class="row">
                <div class="span12">
                    <g:if test="${session?.user?.role == 'admin' }">
                        <g:form>
                            <fieldset class="pull-right">
                                <g:hiddenField name="id" value="${communityInstance?.id}" />
                                <g:link class="edit btn  btn-warning" action="edit" id="${communityInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                                <g:actionSubmit class="delete btn  btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                            </fieldset>
                        </g:form>
                    </g:if>
                </div>
            </div>



            <script type="text/javascript">
                $('.add-resource').click(function(){
                    $(".modal-new-resource").modal();
                });
                $('.add-question').click(function(){
                    $(".modal-new-question").modal();
                });

                $('.add-resource').mouseover(function(){
                    $('#resource-tooltip').tooltip('show')
                })

                $('.add-question').mouseover(function(){
                    $('#question-tooltip').tooltip('show')
                })




            </script>






    </body>
</html>
