
<%@ page import="com.braksa.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

        <div class="row">
            <div class="span6">
                <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            </div>
            <div class="span6">
                <g:form>
                    <fieldset class="pull-right">
                        <g:hiddenField name="id" value="${userInstance?.id}" />
                        <g:link class="edit btn btn-warning" action="edit" id="${userInstance?.id}"><g:message code="default.button.edit.label" default="Modifier" /></g:link>
                        <g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Supprimer')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Est ce que vous etes sure?')}');" />
                    </fieldset>
                </g:form>
            </div>
        </div>

        <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
        </g:if>

        <div class="row">
            <div class="span12">
                <h1><small>Vos informations</small></h1>

                <g:if test="${userInstance?.name}">
                    <p><h5>Nom <small><g:fieldValue bean="${userInstance}" field="name"/></small> </h5></p>
                </g:if>
                <g:if test="${userInstance?.email}">
                    <p><h5>Email<small> <g:fieldValue bean="${userInstance}" field="email"/></small></h5></p>
                </g:if>
            </div>
        </div>




		<g:if test="${userInstance?.subscriptions}">
			<h1><small>Vos abonnements</small></h1>
			<g:each in="${userInstance.subscriptions}" var="s">
				<li><g:link controller="community" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
			</g:each>
		</g:if>
					




        <h1><small>Vos ressources</small></h1>
		        <table class="table">
					<thead>
						<tr>
							<g:sortableColumn property="link" title="${message(code: 'resource.link.label', default: 'Link')}" />
							<g:sortableColumn property="title" title="${message(code: 'resource.title.label', default: 'Title')}" />
							<g:sortableColumn property="type" title="${message(code: 'resource.type.label', default: 'Type')}" />
						</tr>
					</thead>
					<tbody>
					<g:each in="${resourceInstanceList}" status="i" var="resourceInstance">
						<tr>
							<td><g:link action="show" id="${resourceInstance.id}">${fieldValue(bean: resourceInstance, field: "link")}</g:link></td>
							<td>${fieldValue(bean: resourceInstance, field: "title")}</td>
							<td>${fieldValue(bean: resourceInstance, field: "type")}</td>
						</tr>
					</g:each>
					</tbody>
				</table>

	</body>
</html>
