package com.braksa

class Resource {
	
	String title
	String link 
	String type
    Integer niveau
    Date dateCreated
    Date lastUpdated
	
	static belongsTo = [User, Community]
    static hasMany = [upvotes : Upvote]

    static constraints = {
        type inList: ["Vidéo", "Lien", "Livre"]
        title blank: false
        link blank: false
        niveau inList: [1,2,3]
    }
}
