
<%@ page import="com.braksa.Resource" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'resource.label', default: 'Resource')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-resource" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-resource" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="type" title="${message(code: 'resource.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'resource.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="link" title="${message(code: 'resource.link.label', default: 'Link')}" />
					
						<g:sortableColumn property="niveau" title="${message(code: 'resource.niveau.label', default: 'Niveau')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'resource.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'resource.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${resourceInstanceList}" status="i" var="resourceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${resourceInstance.id}">${fieldValue(bean: resourceInstance, field: "type")}</g:link></td>
					
						<td>${fieldValue(bean: resourceInstance, field: "title")}</td>
					
						<td>${fieldValue(bean: resourceInstance, field: "link")}</td>
					
						<td>${fieldValue(bean: resourceInstance, field: "niveau")}</td>
					
						<td><g:formatDate date="${resourceInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${resourceInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${resourceInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
