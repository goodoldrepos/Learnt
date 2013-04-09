package com.braksa

class Resource {
	
	String title
	String link 
	String type
    Date dateCreated
    Date lastUpdated
	
	static belongsTo = [User, Community]
    static hasMany = [upvotes : Upvote]

    static constraints = {
        type inList: ["Vidéo", "Lien", "Livre"]
    }
}
