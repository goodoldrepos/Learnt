package com.braksa

class User {

	String name
	String email
	String password
	String role = "member"
    Date dateCreated
    Date lastUpdated
	
	static hasMany = [subscriptions : Community, resources: Resource, questions: Question, answers: Answer, upvotes: Upvote]
	static fetchMode = [subscriptions: 'eager', resources: 'eager', questions: 'eager']
	
    static constraints = {
    	name blank: false
    	email email: true, blank: false, unique: true
        password size: 5..15, blank: false, password: true
    }

	Boolean follow(Long idCommunity){
		def community = Community.get(idCommunity)
		def u = User.get(id)
		if(community in u.subscriptions.collect()) return true
		else return false
	}

    static namedQueries = {
        findByAnswer {
            answerId ->
                answers {
                    eq 'id', answerId
                }
        }
        findByQuestion {
            questionId ->
                questions {
                    eq 'id', questionId
                }
        }
    }
	
    String toString(){
    	name
    }
}
