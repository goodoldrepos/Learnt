package com.braksa

import org.springframework.dao.DataIntegrityViolationException

class QuestionController {

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

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [questionInstanceList: Question.list(params), questionInstanceTotal: Question.count()]
    }

    def create() {
        [questionInstance: new Question(params)]
    }

    def save() {
        def questionInstance = new Question(params)
        if (!questionInstance.save(flush: true)) {
            render(view: "create", model: [questionInstance: questionInstance])
            return
        }

        def userInstance = User.get(params.idUser)
        userInstance.addToQuestions(questionInstance).save(flush:  true)
        def communityInstance = Community.get(params.idCommunity)
        communityInstance.addToQuestions(questionInstance).save(flush: true)
        println 'question added !'

        flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(controller: 'community', action: "show", id: communityInstance.id)
    }

    def show(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance, answerInstanceList: questionInstance.getAnswers(), answerInstanceTotal: questionInstance.answers.size()]
    }

    def edit(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance]
    }

    def update(Long id, Long version) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (questionInstance.version > version) {
                questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'question.label', default: 'Question')] as Object[],
                        "Another user has updated this Question while you were editing")
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            }
        }

        questionInstance.properties = params

        if (!questionInstance.save(flush: true)) {
            render(view: "edit", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "show", id: questionInstance.id)
    }

    def delete(Long id) {
        def questionInstance = Question.get(id)
        println "User_id : " + params.idCommunity
        def community = Community.get(params.idCommunity)
        def user = User.get(params.idUser)
        community.questions.remove(questionInstance); //remove question from community
        community.save(flush: true)
        user.questions.remove(questionInstance); //remove question from user
        user.save(flush: true)

        println 'removing answers by users'
        for(answer in questionInstance.answers){
            def someUser = User.findByAnswer(answer.id).list().get(0)
            someUser.answers.remove(answer)
        }
        println 'answers removed'

        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(controller: "community", action: "show", id: community.id)
            return
        }

        println "trying to remove the question"

        try {
            println "Question removed (before)"
            Question.get(questionInstance.id).delete(flush: true)
            println "Question removed (after)"
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question deleted'), id])
            redirect(controller: "community", action: "show", id: community.id)
        }
        catch (DataIntegrityViolationException e) {
            println("Exception happened")
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'question.label', default: 'Exception'), id])
            redirect(controller: "community", action: "show", id: c.id)
        }
    }
}
