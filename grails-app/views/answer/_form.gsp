<%@ page import="com.braksa.Answer" %>



<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="answer.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="content" cols="40" rows="5" maxlength="1000" required="" value="${answerInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'upvotes', 'error')} ">
	<label for="upvotes">
		<g:message code="answer.upvotes.label" default="Upvotes" />
		
	</label>
	<g:select name="upvotes" from="${com.braksa.Upvote.list()}" multiple="multiple" optionKey="id" size="5" value="${answerInstance?.upvotes*.id}" class="many-to-many"/>
</div>

