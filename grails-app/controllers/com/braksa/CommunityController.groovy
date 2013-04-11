package com.braksa

import org.springframework.dao.DataIntegrityViolationException

class CommunityController {

	def beforeInterceptor = [action:this.&auth, except:["index","list"]]
  	def auth() {
    	if(!session.user) {
      		redirect(controller:"user", action:"login")
     		return false
    	}
  	}

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [communityInstanceList: Community.list(params), communityInstanceTotal: Community.count()]
    }

    def create() {
        [communityInstance: new Community(params)]
    }

    def save() {
        def communityInstance = new Community(params)
        if (!communityInstance.save(flush: true)) {
            render(view: "create", model: [communityInstance: communityInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'community.name', default: 'Community'), communityInstance.id])
        redirect(action: "show", id: communityInstance.id)
    }

    def show(Long id) {
        def communityInstance = Community.get(id)
        if (!communityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'community.label', default: 'Community'), id])
            redirect(action: "list")
            return
        }
        [communityInstance: communityInstance, resourceInstanceList: communityInstance.resources.collect(), resourceInstanceTotal: communityInstance.resources.size(), questionInstanceList: communityInstance.questions.collect(), questionInstanceTotal: communityInstance.questions.size(), resourceInstance: new Resource(params)]
    }

    def edit(Long id) {
        def communityInstance = Community.get(id)
        if (!communityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'community.label', default: 'Community'), id])
            redirect(action: "list")
            return
        }

        [communityInstance: communityInstance]
    }

    def update(Long id, Long version) {
        def communityInstance = Community.get(id)
        if (!communityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'community.label', default: 'Community'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (communityInstance.version > version) {
                communityInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'community.label', default: 'Community')] as Object[],
                          "Another user has updated this Community while you were editing")
                render(view: "edit", model: [communityInstance: communityInstance])
                return
            }
        }

        communityInstance.properties = params

        if (!communityInstance.save(flush: true)) {
            render(view: "edit", model: [communityInstance: communityInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args:[communityInstance.name])
        redirect(action: "show", id: communityInstance.id)
    }

    def delete(Long id) {
        def communityInstance = Community.get(id)
        def u = User.get(session?.user?.id)
        u.subscriptions.remove(communityInstance)
        u.save(flush: true)

        if (!communityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'community.label', default: 'Community'), id])
            redirect(action: "list")
            return
        }

        try {
            communityInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'community.label', default: 'Community'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'community.label', default: 'Community'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def subscribe(Long id){
		def c = Community.get(id)
		def userInstance = User.get(session?.user?.id)
		userInstance.addToSubscriptions(c) //add the community to the user subscriptions list
		userInstance.save(flush: true) //save the damn instance
	
		redirect(action: 'show', id: id)
	}
	
	def unsubscribe(Long id){
		def c = Community.get(id)
		def userInstance = User.get(session?.user?.id) //get the user by his id
		userInstance.removeFromSubscriptions(c)
		userInstance.save(flush: true)
		
		redirect(action: 'list')
	}
}
