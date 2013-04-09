package learn_

class SubscribeTagLib {
	def SubscribeControl = {
		if(session.user){
			out << """${link(action:"logout", controller:"user"){"Logout"}}"""
		} else {
      		out << """${link(action:"login", controller:"user"){"Login"}}"""      
		}
	  }
}
