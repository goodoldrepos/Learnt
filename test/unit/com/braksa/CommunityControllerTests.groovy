package com.braksa



import org.junit.*
import grails.test.mixin.*

@TestFor(CommunityController)
@Mock(Community)
class CommunityControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/community/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.communityInstanceList.size() == 0
        assert model.communityInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.communityInstance != null
    }

    void testSave() {
        controller.save()

        assert model.communityInstance != null
        assert view == '/community/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/community/show/1'
        assert controller.flash.message != null
        assert Community.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/community/list'

        populateValidParams(params)
        def community = new Community(params)

        assert community.save() != null

        params.id = community.id

        def model = controller.show()

        assert model.communityInstance == community
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/community/list'

        populateValidParams(params)
        def community = new Community(params)

        assert community.save() != null

        params.id = community.id

        def model = controller.edit()

        assert model.communityInstance == community
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/community/list'

        response.reset()

        populateValidParams(params)
        def community = new Community(params)

        assert community.save() != null

        // test invalid parameters in update
        params.id = community.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/community/edit"
        assert model.communityInstance != null

        community.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/community/show/$community.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        community.clearErrors()

        populateValidParams(params)
        params.id = community.id
        params.version = -1
        controller.update()

        assert view == "/community/edit"
        assert model.communityInstance != null
        assert model.communityInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/community/list'

        response.reset()

        populateValidParams(params)
        def community = new Community(params)

        assert community.save() != null
        assert Community.count() == 1

        params.id = community.id

        controller.delete()

        assert Community.count() == 0
        assert Community.get(community.id) == null
        assert response.redirectedUrl == '/community/list'
    }
}
