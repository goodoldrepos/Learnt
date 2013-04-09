
<%@ page import="com.braksa.Community" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'community.label', default: 'Community')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	
		<div id="list-community" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			    <div class="alert alert-success" role="status">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    ${flash.message}
                </div>
			</g:if>
			<table class="table">
				<thead>
					<tr>
						<g:sortableColumn property="name" title="${message(code: 'community.name.label', default: 'Name')}" />
						<g:sortableColumn property="category" title="${message(code: 'community.category.label', default: 'Category')}" />
					</tr>
				</thead>
				<tbody>
				<g:each in="${communityInstanceList}" status="i" var="communityInstance">
					<tr>
						<td><g:link action="show" id="${communityInstance.id}">${fieldValue(bean: communityInstance, field: "name")}</g:link></td>
						<td>${fieldValue(bean: communityInstance, field: "category")}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${communityInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
