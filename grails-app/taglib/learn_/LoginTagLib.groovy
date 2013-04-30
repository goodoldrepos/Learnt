package learn_

class LoginTagLib {
  def loginControl = {
    if(session.user){
      out << """${link(action:"logout", controller:"user"){"<i class=\"icon-off\"></i>"}}"""
    } else {
      out << """${link(action:"login", controller:"user"){"S'identifier"}}"""
    }
  }
}
