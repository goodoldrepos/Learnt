<%@ page import="com.braksa.Resource" %>
<%@ page import="com.braksa.User" %>
<%@  page import="grails.converters.*" %>


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
    <%
        if(resourceInstance.type == "Livre"){

            def str = "https://www.googleapis.com/books/v1/volumes?key=AIzaSyCqHK7Rp-d792JGjNTGVrMKTq55TaIOiXk&q=" + java.net.URLEncoder.encode(resourceInstance.title)

            def data = str.toURL().text
            //println str
            def userJson = JSON.parse(data)
            if(userJson.items.get(0).volumeInfo.imageLinks?.thumbnail){
                println "<img src='" + userJson.items.get(0).volumeInfo.imageLinks.thumbnail + "'/>"
            }else{
                def thebook =  userJson.items.findAll{ w -> w.volumeInfo.title.toLowerCase().trim() == resourceInstance.title.toLowerCase().trim() }
                println "<img src='" + thebook.volumeInfo.imageLinks.thumbnail.get(0) + "'/>"
            }

        }
    %>
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
                <g:link controller="resource" action="upvote" id="${resourceInstance.id}">
                    <span class="btn btn-success">
                        <i class="icon-thumbs-up icon-white"></i> ${resourceInstance.upvotes.size()}
                    </span>
                </g:link>
                <g:if test="${User.findByResource(resourceInstance.id).list().get(0).id == session?.user?.id}" >
                    <span class="btn">
                        <i class="icon-edit"></i>
                    </span>
                    <span class="btn">
                        <i class="icon-trash"></i>
                    </span>
                </g:if>
            </div>
        </g:if>
        <g:else>
        <br/>
            <div class="like-button">
                <g:if test="${User.findByResource(resourceInstance.id).list().get(0).id == session?.user?.id}">
                    <span class="btn">
                        <i class="icon-edit"></i>
                    </span>
                    <span class="btn">
                        <i class="icon-trash"></i>
                    </span>
                </g:if>

                <span class="clicked-like">
                    <span class="btn disabled "><i class="icon-thumbs-up"></i> ${resourceInstance.upvotes.size()}</span>
                </span>
            </div>

        </g:else>

    </div>
</div>

