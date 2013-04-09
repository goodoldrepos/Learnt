<%@ page import="com.braksa.Community" %>



<div class="fieldcontain ${hasErrors(bean: communityInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="community.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${communityInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: communityInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="community.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${communityInstance?.category}"/>
</div>




