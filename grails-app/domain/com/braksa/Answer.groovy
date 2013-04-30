package com.braksa

class Answer {

    String content
    Date dateCreated
    Date lastUpdated

    static belongsTo = [User, Question]
    static hasMany = [upvotes : Upvote]

    static constraints = {
        content(blank: false, maxSize: 1000)
    }

    static mapping = {
        sort dateCreated: 'asc'
    }

}
