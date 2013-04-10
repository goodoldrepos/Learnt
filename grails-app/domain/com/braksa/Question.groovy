package com.braksa

class Question {

    String content
    Date dateCreated
    Date lastUpdated

    static hasMany = [answers : Answer, upvotes: Upvote]
    static belongsTo = [User, Community]
    static fetchMode = [answers: 'eager']

    static constraints = {
        content(blank: false)
    }
}
