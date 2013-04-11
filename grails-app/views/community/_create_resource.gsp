<%@ page import="com.braksa.Resource" %>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'title', 'error')} ">
    <g:textField name="title" class="input-xlarge" value="${resourceInstance?.title}" placeholder="Nom de votre de ressource" />
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'link', 'error')} ">
	<g:textField name="link" class="input-xlarge" value="${resourceInstance?.link}" placeholder="Votre lien" />
</div>

<div class=" ${hasErrors(bean: resourceInstance, field: 'type', 'error')} ">
    <g:select name="type" class="span3" from="${resourceInstance.constraints.type.inList}" value="${resourceInstance?.type}" valueMessagePrefix="resource.type" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'niveau', 'error')} required">
    <label for="niveau">
        <g:message code="resource.niveau.label" default="Niveau" />
        <span class="required-indicator">*</span>
    </label>
    <g:select name="niveau" from="${resourceInstance.constraints.niveau.inList}" required="" value="${fieldValue(bean: resourceInstance, field: 'niveau')}" valueMessagePrefix="resource.niveau"/>
</div>



