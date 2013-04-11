
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
                        <g:img file="illustrations/share.png" width="50" /> &nbsp;#${communityInstance?.name}
                        <div class="pull-right">
                            <g:if test="${session?.user?.follow(communityInstance.id)}">
                                <g:link controller="community" action="unsubscribe" id="${communityInstance.id}" >
                                    <input type="button" class="btn btn-small btn-inverse" value="Quitter" />
                                </g:link>
                            </g:if>
                            <g:else>
                                <g:link controller="community" action="subscribe" id="${communityInstance.id}" >
                                    <input type="button" class="btn btn-success" value="S'abonner" />
                                </g:link>
                            </g:else>
                        </div>
                    </h1>
                </div>
            </div>
        </div>


        <g:if test="${flash.message}">
            <div class="alert alert-success">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>${flash.message}</strong>
            </div>
        </g:if>
    <style type="text/css">
        .navigation{
            border-right: 1px solid #ebebeb;
            #background-color: red;
        }
        .menu{
            padding: 20px;
        }
    </style>

    <div class="row">
        <div class="tabbable">
        <div class="span3">
            <div class="navigation">
                <ul class="nav nav-pills nav-stacked menu">
                    <li class="active"><a href="#pane1" data-toggle="tab"><i class="icon-comment"></i> Discussions</a></li>
                    <li><a href="#pane2" data-toggle="tab"><i class="icon-book"></i> Bibliothéques</a></li>
                </ul>
            </div>
        </div>


        <div class="span8">
            <div class="tab-content ">
                <div id="pane1" class="tab-pane active">
                    <p class="pull-right">
                        <h3>Discussions récentes</h3>
                    </p>
                    <p class="pull-right">
                        <a href="#" class="add-question btn btn-primary btn-mini">
                            <i class="icon-plus icon-white"></i> Poser une question
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
                <div id="pane2" class="tab-pane">
                    <h3>Ressources <small>(par niveau) </small></h3>
                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#pane11" data-toggle="tab">Débutant</a></li>
                            <li><a href="#pane22" data-toggle="tab">Intermédiaire</a></li>
                            <li><a href="#pane33" data-toggle="tab">Avancée</a></li>
                        </ul>
                        <div class="tab-content">
                            <p class="pull-right">
                                <a href="#" class="add-resource btn btn-mini btn-primary ">
                                    <i class="icon-plus icon-white"></i> Ajouter
                                </a>
                            </p>

                            <div id="pane11" class="tab-pane active">
                                <br/> <br/>

                                    <g:each in="${resourceInstanceList.asList().sort{it.upvotes.size()}.asList().findAll{ it.niveau == 1}.reverse()}" status="i" var="resourceInstance">
                                        <g:render template="resource" model="['resourceInstance':resourceInstance]" />
                                        <br/>
                                    </g:each>

                                <div class="pagination">
                                    <g:paginate total="${resourceInstanceTotal}" />
                                </div>
                            </div>
                            <div id="pane22" class="tab-pane">
                                <br/> <br/>
                                <table class="table table-hover">
                                    <g:if test="${resourceInstanceList.asList().findAll{ it.niveau == 2}.size() == 0}">
                                        <div class="alert alert-info">
                                            Soyez le premier à publier une ressource et booster votre réputation dans la communauté.
                                            <a href="#" class="add-resource"> Ajouter maintenant ! </a>
                                        </div>
                                    </g:if>
                                    <g:each in="${resourceInstanceList.asList().sort{it.upvotes.size()}.asList().findAll{ it.niveau == 2}.reverse()}" status="i" var="resourceInstance">
                                        <g:render template="resource" model="['resourceInstance':resourceInstance]" />
                                        <br/>
                                    </g:each>
                                </table>
                                <div class="pagination">
                                    <g:paginate total="${resourceInstanceTotal}" />
                                </div>
                            </div>
                            <div id="pane33" class="tab-pane">
                                <br/> <br/>
                                <table class="table table-hover">
                                    <g:each in="${resourceInstanceList.asList().sort{it.upvotes.size()}.asList().findAll{ it.niveau == 3}.reverse()}" status="i" var="resourceInstance">
                                        <g:render template="resource" model="['resourceInstance':resourceInstance]" />
                                        <br/>
                                    </g:each>
                                </table>
                                <div class="pagination">
                                    <g:paginate total="${resourceInstanceTotal}" />
                                </div>
                            </div>
                        </div><!-- /.tab-content -->
                    </div><!-- /.tabbable -->
                </div>
            </div>
        </div>
        </div>
    </div>



        <div class="row">
            <div class="span5">

            </div>
            <div class="offset2 span5">

            </div>
        </div>

        <div class="modal modal-new-resource hide fade">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Nouvelle Ressource</h3>
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
                <h3>Nouvelle Question</h3>
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


        <!--<div class="row">
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

            var old_val = "";
            $('.clicked-like').hover(function(){
                old_val = $(this).find('span').html();
                $(this).find('span').html("<i class='icon-thumbs-up'></i> x");
                console.log('hover');
            }, function(){
                $(this).find('span').html(old_val);
                //console.log(old_val);
            });
        </script>















    </body>
</html>
