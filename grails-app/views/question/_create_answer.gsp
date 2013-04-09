<%@ page import="com.braksa.Answer" %>


<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'content', 'error')} required">
    <g:textArea name="content" cols="40" rows="5" maxlength="1000" required="" placeholder="poster une réponse" value="${answerInstance?.content}"/>
</div>