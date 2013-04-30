
<%@ page import="com.braksa.Question" %>
<%@ page import="com.braksa.Community" %>
<%@ page import="com.braksa.User" %>
<%@ page import="com.braksa.Upvote" %>


<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

            <g:if test="${session?.user?.role == 'admin' || (User.findByQuestion(questionInstance.id).list().size() != 0 && User.findByQuestion(questionInstance.id).list().get(0).id == session?.user?.id)  }">
            <div class="row">
                <div class="span12 pull-right">
                    <g:form>
                        <fieldset class="buttons pull-right">
                            <g:hiddenField name="id" value="${questionInstance?.id}" />
                            <g:hiddenField name="idCommunity" value="${Community.findByQuestion(questionInstance.id).get().id}" />
                            <g:hiddenField name="idUser" value="${session?.user?.id }" />
                            <g:link class="edit btn " action="edit" id="${questionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                            <g:actionSubmit class="delete btn" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </fieldset>
                    </g:form>
                </div>
            </div>
            </g:if>

			<g:if test="${flash.message}">
			    <div class="message" role="status">${flash.message}</div>
			</g:if>

            <br/>

            <div class="row">
                <div class="span12">
                    <div class="page-header">
                        <h2>
                            <g:if test="${questionInstance?.content}">
                                <g:fieldValue bean="${questionInstance}" field="content"/>
                            </g:if>

                        </h2>
                    </div>
                </div>
            </div>


            <g:if test="${answerInstanceTotal == 0}">
                <div class="alert alert-info">
                    <h4>Soyez le premier à répondre à cette question !</h4>
                    Et gagner plus de points pour booster votre réputation dans la communauté.
                </div>
            </g:if>

            <g:each in="${answerInstanceList.asList().sort{it.upvotes.size()}.reverse()}" status="i" var="answerInstance">
                <div class="row">
                    <div class="span1">
                        <span class="pull-right">
                            <br/>
                            <%
                                def cond = true
                                List userUpvotes = User.get(session?.user?.id).upvotes.toList()
                                List answerUpvotes = answerInstance.upvotes.toList()
                                for(upvote in userUpvotes){
                                    if(answerUpvotes.contains(upvote)) cond = false
                                }
                            %>
                            <g:if test="${cond == true}">
                                <g:link controller="answer" action="upvote" id="${answerInstance.id}" class="btn btn-primary pull-right"><i class="icon-thumbs-up icon-white"></i></g:link>
                            </g:if>
                            <g:else>
                                <input type="button" class="btn btn-inverse pull-right disabled" value=" ${answerInstance.upvotes.size()}pts" />
                            </g:else>
                        </span>
                    </div>
                    <div class="span11">
                        <div class="well">
                            <g:set var="u" value="${User.findByAnswer(answerInstance.id).list().get(0)}" />
                             ${fieldValue(bean: answerInstance, field: "content")}
                            <span class="pull-right"><g:link controller="user" action="show" id="${u.id}" >${u.name}</g:link></span>
                        </div>
                    </div>
                </div>
            </g:each>
            <div class="pagination">
                <g:paginate total="${answerInstanceTotal}" />
            </div>

            <g:form controller="answer" action="save" >
                <fieldset class="form">
                    <g:render template="create_answer"/>
                    <g:hiddenField name="idQuestion" value="${questionInstance?.id}" />
                    <g:hiddenField name="idUser" value="${session?.user?.id }" />
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>



	</body>
</html>
