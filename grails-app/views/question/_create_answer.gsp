<%@ page import="com.braksa.Answer" %>


<div class="fieldcontain  ${hasErrors(bean: answerInstance, field: 'content', 'error')} required">
    <g:textArea name="content" class="span10" cols="40" rows="10" maxlength="1000" required="" placeholder="poster une réponse" value="${answerInstance?.content}"/>
</div>