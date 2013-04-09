package com.braksa

import org.springframework.dao.DataIntegrityViolationException

class UserController {

	def beforeInterceptor = [action:this.&auth, except:["login","authenticate","index", "create", "save"]]
	def auth() {
    	if(!session.user) {
      		redirect(controller:"user", action:"login")
     		return false
    	}
  	}

	def login = {}
  
  	def authenticate = {
    	def user = User.findByEmailAndPassword(params.email, params.password)
    	if(user){
      		session.user = user
      		flash.message = "Salut ${user.name}!"
      		redirect(controller:"Community", action:"list")      
    	}else{
      		flash.error = "Sorry, Please try again."
      		redirect(action:"login")
    	}
  	}
  
  	def logout = {
    	flash.message = "Au revoir ${session.user.name}"
    	session.user = null
    	redirect(controller:"User", action:"login")      
  	}  

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
    	if(session?.user){
    		redirect(action: "show", id: session.user.id)
    	}else{
    		redirect(action: "create", params: params)
    	}
    }

    def list(Integer max) {
    	if(!(session?.user?.role == "admin")) {
      		redirect(controller:"user", action:"show", id: session.user.id)
     		return false
    	}
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create() {
        [userInstance: new User(params)]
    }

    def save() {
    	params.role = "member" //make a default
        def userInstance = new User(params)
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        session.user = userInstance
        redirect(action: "show", id: userInstance.id)
    }

    def show(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.name', default: 'User'), id])
            redirect(action: "list")
            return
        }
        [userInstance: userInstance, resourceInstanceList: userInstance.resources.asList()]
    }

    def edit(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update(Long id, Long version) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }
}
