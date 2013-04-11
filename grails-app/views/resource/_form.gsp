<%@ page import="com.braksa.Resource" %>



<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="resource.type.label" default="Type" />
		
	</label>
	<g:select name="type" from="${resourceInstance.constraints.type.inList}" value="${resourceInstance?.type}" valueMessagePrefix="resource.type" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="resource.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${resourceInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'link', 'error')} required">
	<label for="link">
		<g:message code="resource.link.label" default="Link" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="link" required="" value="${resourceInstance?.link}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'niveau', 'error')} required">
	<label for="niveau">
		<g:message code="resource.niveau.label" default="Niveau" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="niveau" from="${resourceInstance.constraints.niveau.inList}" required="" value="${fieldValue(bean: resourceInstance, field: 'niveau')}" valueMessagePrefix="resource.niveau"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'upvotes', 'error')} ">
	<label for="upvotes">
		<g:message code="resource.upvotes.label" default="Upvotes" />
		
	</label>
	<g:select name="upvotes" from="${com.braksa.Upvote.list()}" multiple="multiple" optionKey="id" size="5" value="${resourceInstance?.upvotes*.id}" class="many-to-many"/>
</div>

