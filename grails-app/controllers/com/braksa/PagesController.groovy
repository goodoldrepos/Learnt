package com.braksa

class PagesController {

    def index() {
        params.max = 10
        [communityInstanceList: Community.list(params), communityInstanceTotal: Community.count()]
    }
}
