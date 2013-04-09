package com.braksa

import org.springframework.dao.DataIntegrityViolationException

class AnswerController {

    def beforeInterceptor = [action:this.&auth, except:[]]
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

    def upvote(Long id) {
        def answerInstance = Answer.get(id)
        def upvote = new Upvote(score: 1)
        answerInstance.addToUpvotes(upvote).save(flush: true)
        User.get(session?.user?.id).addToUpvotes(upvote).save(flush: true)
        redirect(controller: 'community', action: 'list')
    }

    def list(Integer max) {
        if(!session || !(session?.user?.role == 'admin') ){
            redirect(controller: 'community', action: 'list')
            return
        }

        params.max = Math.min(max ?: 10, 100)
        [answerInstanceList: Answer.list(params), answerInstanceTotal: Answer.count()]

    }

    def create() {
        if(!session || !(session?.user?.role == 'admin') ){
            redirect(controller: 'community', action: 'list')
            return
        }
        [answerInstance: new Answer(params)]
    }

    def save() {
        def answerInstance = new Answer(params)
        if (!answerInstance.save(flush: true)) {
            render(view: "create", model: [answerInstance: answerInstance])
            return
        }

        def user = User.get(params.idUser)
        def question = Question.get(params.idQuestion)

        user.addToAnswers(answerInstance).save(flush: true)
        question.addToAnswers(answerInstance).save(flush: true)

        println 'answer added'

        flash.message = message(code: 'default.created.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
        redirect(controller:  'question', action: "show", id: question.id)
    }

    def show(Long id) {
        if(!session || !(session?.user?.role == 'admin') ){
            redirect(controller: 'community', action: 'list')
            return
        }

        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
            return
        }

        [answerInstance: answerInstance]
    }

    def edit(Long id) {
        if(!session || !(session?.user?.role == 'admin') ){
            redirect(controller: 'community', action: 'list')
            return
        }

        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
            return
        }

        [answerInstance: answerInstance]
    }

    def update(Long id, Long version) {
        if(!session || !(session?.user?.role == 'admin') ){
            redirect(controller: 'community', action: 'list')
            return
        }

        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (answerInstance.version > version) {
                answerInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'answer.label', default: 'Answer')] as Object[],
                        "Another user has updated this Answer while you were editing")
                render(view: "edit", model: [answerInstance: answerInstance])
                return
            }
        }

        answerInstance.properties = params

        if (!answerInstance.save(flush: true)) {
            render(view: "edit", model: [answerInstance: answerInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
        redirect(action: "show", id: answerInstance.id)
    }

    def delete(Long id) {
        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
            return
        }

        try {
            answerInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'answer.label', default: 'Answer'), id])
            redirect(action: "show", id: id)
        }
    }
}
