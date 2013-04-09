import com.braksa.User

class BootStrap {

    def init = { servletContext ->
		
		def admin = new User(email:"admin@braksa.com",
			password:"foobar",
			name:"Admin Braksa",
			role:"admin")
		admin.save()
		
		def user = new User(email:"zakaria@braksa.com",
			password:"foobar",
			name:"Zakaria Braksa",
			role:"member")
		user.save()
			
    }
    def destroy = {
    }
}
