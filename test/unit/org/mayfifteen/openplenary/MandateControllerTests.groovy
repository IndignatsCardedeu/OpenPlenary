package org.mayfifteen.openplenary



import org.junit.*
import grails.test.mixin.*

@TestFor(MandateController)
@Mock(Mandate)
class MandateControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/mandate/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.mandateInstanceList.size() == 0
        assert model.mandateInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.mandateInstance != null
    }

    void testSave() {
        controller.save()

        assert model.mandateInstance != null
        assert view == '/mandate/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/mandate/show/1'
        assert controller.flash.message != null
        assert Mandate.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/mandate/list'

        populateValidParams(params)
        def mandate = new Mandate(params)

        assert mandate.save() != null

        params.id = mandate.id

        def model = controller.show()

        assert model.mandateInstance == mandate
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/mandate/list'

        populateValidParams(params)
        def mandate = new Mandate(params)

        assert mandate.save() != null

        params.id = mandate.id

        def model = controller.edit()

        assert model.mandateInstance == mandate
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/mandate/list'

        response.reset()

        populateValidParams(params)
        def mandate = new Mandate(params)

        assert mandate.save() != null

        // test invalid parameters in update
        params.id = mandate.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/mandate/edit"
        assert model.mandateInstance != null

        mandate.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/mandate/show/$mandate.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        mandate.clearErrors()

        populateValidParams(params)
        params.id = mandate.id
        params.version = -1
        controller.update()

        assert view == "/mandate/edit"
        assert model.mandateInstance != null
        assert model.mandateInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/mandate/list'

        response.reset()

        populateValidParams(params)
        def mandate = new Mandate(params)

        assert mandate.save() != null
        assert Mandate.count() == 1

        params.id = mandate.id

        controller.delete()

        assert Mandate.count() == 0
        assert Mandate.get(mandate.id) == null
        assert response.redirectedUrl == '/mandate/list'
    }
}
