<%@ page import="com.braksa.Resource" %>
<%@ page import="com.braksa.User" %>


<style type="text/css">
    .foot{
        #background-color: gray;
        position: relative;
    }
    .like-button{
        margin: 5px;
        position: absolute;
        bottom: 0px;
        right: 0px;
    }

</style>

<div class="thumbnail tile">
    <div class="caption">
        <h4 class="tile-title">
            <a  href="${fieldValue(bean: resourceInstance, field: "link")}" target="_blank">${fieldValue(bean: resourceInstance, field: "title")}</a>
        </h4>
        <p>${new URI(resourceInstance.link).host}</p>
    </div>
    <p>

    </p>
    <div class="foot" >
        <%
            def didntVote = true
            List userUpvotes = User.get(session?.user?.id).upvotes.toList()
            List resourcesUpvotes = resourceInstance.upvotes.toList()
            for(upvote in userUpvotes){
                if(resourcesUpvotes.contains(upvote)) didntVote = false
            }
        %>
        <g:if test="${didntVote == true}">
            <div class="like-button">
                <g:if test="${User.findByResource(resourceInstance.id)}" >
                    <span class="btn">
                        <i class="icon-edit"></i>
                    </span>
                    <span class="btn">
                        <i class="icon-remove"></i>
                    </span>
                </g:if>
                <g:link controller="resource" action="upvote" id="${resourceInstance.id}">

                    <span class="btn">
                        <i class="icon-thumbs-up"></i> ${resourceInstance.upvotes.size()}
                    </span>

                </g:link>
            </div>
        </g:if>
        <g:else>
        <br/>
            <div class=" like-button">
                <g:if test="">
                    <span class="btn">
                        <i class="icon-edit"></i>
                    </span>
                    <span class="btn">
                        <i class="icon-remove"></i>
                    </span>
                </g:if>

                <span class="clicked-like">
                    <span class="btn disabled "><i class="icon-thumbs-up"></i> ${resourceInstance.upvotes.size()}</span>
                </span>
            </div>

        </g:else>

    </div>
</div>

