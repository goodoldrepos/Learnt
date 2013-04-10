
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
                    <div class=" page-header">
                        <h1>
                            <g:img file="illustrations/share.png" width="50" /> &nbsp; #${communityInstance?.name}


                            <div class="pull-right">
                                <g:if test="${session?.user?.follow(communityInstance.id)}">
                                    <g:link controller="community" action="unsubscribe" id="${communityInstance.id}" >
                                        <input type="button" class="btn btn-small disabled" value="Quitter" />
                                    </g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="community" action="subscribe" id="${communityInstance.id}" >
                                        <input type="button" class="btn btn-danger" value="Rejoindre" />
                                    </g:link>
                                </g:else>
                            </div>
                        </h1>
                    </div>
                </div>
            </div>


			<g:if test="${flash.message}">
                <div class="alert">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>${flash.message}</strong>
                </div>
            </g:if>

    <br/>



            <div class="row">
                <div class="offset3 span6" >
                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#pane1" data-toggle="tab">Ressources</a></li>
                            <li><a href="#pane2" data-toggle="tab">Questions</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="pane1" class="tab-pane active">
                                <p class="pull-right">
                                    <a href="#" class="add-resource btn btn-primary ">
                                        <i class="fui-plus-16"></i>
                                    </a>
                                </p>
                                <br/> <br/>
                                <table class="table table-hover">
                                    <g:each in="${resourceInstanceList.asList().sort{it.upvotes.size()}.asList().reverse()}" status="i" var="resourceInstance">

                                        <div class="well">
                                            <a  href="${fieldValue(bean: resourceInstance, field: "link")}" target="_blank">${fieldValue(bean: resourceInstance, field: "title")}</a>
                                            <br/>
                                            <div class="pull-right">
                                                <g:link controller="resource" action="upvote" id="${resourceInstance.id}" class="pull-right"><span class="btn"><i class="fui-heart-16"> ${resourceInstance.upvotes.size()} </i></span> </g:link>
                                            </div>
                                            <br/>
                                        </div>

                                    </g:each>
                                </table>
                                <div class="pagination">
                                    <g:paginate total="${resourceInstanceTotal}" />
                                </div>
                            </div>
                            <div id="pane2" class="tab-pane ">
                                <p class="pull-right">
                                    <a href="#" class="add-question btn btn-primary ">
                                        <i class="fui-plus-16"></i>
                                    </a>
                                </p>
                                <br/> <br/>
                                <table class="table table-hover">

                                    <g:each in="${questionInstanceList.asList().sort{it.dateCreated}.asList().reverse()}" status="i" var="questionInstance">
                                        <tr>
                                            <td><g:link controller="question" action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "content")}</g:link></td>
                                        </tr>
                                    </g:each>

                                </table>
                                <div class="pagination">
                                    <g:paginate total="${questionInstanceTotal}" />
                                </div>
                            </div>

                        </div><!-- /.tab-content -->
                    </div><!-- /.tabbable -->
                </div>
            </div>


			<div class="row">
                <div class="offset3 span6">

                </div>
			</div>




            <div class="row">
                <div class="offset3 span6">

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

            <!--
            <div class="row">
                <div class="offset3 span6">
                    <g:if test="${communityInstance?.members}">
                        <h1><small><g:message code="community.members.label" default="Membres" /></small></h1>
                        <g:each in="${communityInstance.members}" var="m">
                            <p class="well well-small"><g:link controller="user" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></p>
                        </g:each>
                    </g:if>
                </div>
            </div>
            -->



			<br/>






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
