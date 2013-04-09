package com.braksa

class Community {

	String name
	String category
    Date dateCreated
    Date lastUpdated

	static hasMany = [members : User, resources: Resource, questions: Question]
    static belongsTo = User

    static fetchMode = [questions: 'eager']

    static constraints = {
		name(blank:false)
		category()
    }

    static namedQueries = {
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
