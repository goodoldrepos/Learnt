<%@ page import="com.braksa.Resource" %>



<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="resource.type.label" default="Type" />
		
	</label>
	<g:select name="type" from="${resourceInstance.constraints.type.inList}" value="${resourceInstance?.type}" valueMessagePrefix="resource.type" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'link', 'error')} ">
	<label for="link">
		<g:message code="resource.link.label" default="Link" />
		
	</label>
	<g:textField name="link" value="${resourceInstance?.link}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="resource.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${resourceInstance?.title}"/>
</div>

