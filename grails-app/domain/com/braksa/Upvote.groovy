package com.braksa

class Upvote {

    Integer score
    Date dateCreated
    Date lastUpdated

    static belongsTo = [User, Answer]
    static hasOne = [Answer, Resource]

    static constraints = {
    }
}
