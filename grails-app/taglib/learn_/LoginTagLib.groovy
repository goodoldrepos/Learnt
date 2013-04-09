package learn_

class LoginTagLib {
  def loginControl = {
    if(session.user){
      out << """${link(action:"logout", controller:"user"){"Se déconnecter"}}"""
    } else {
      out << """${link(action:"login", controller:"user"){"Se connecter"}}"""
    }
  }
}
