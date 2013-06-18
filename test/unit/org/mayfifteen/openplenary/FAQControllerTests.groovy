package org.mayfifteen.openplenary



import org.junit.*
import grails.test.mixin.*

@TestFor(FAQController)
@Mock(FAQ)
class FAQControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/FAQ/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.FAQInstanceList.size() == 0
        assert model.FAQInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.FAQInstance != null
    }

    void testSave() {
        controller.save()

        assert model.FAQInstance != null
        assert view == '/FAQ/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/FAQ/show/1'
        assert controller.flash.message != null
        assert FAQ.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/FAQ/list'

        populateValidParams(params)
        def FAQ = new FAQ(params)

        assert FAQ.save() != null

        params.id = FAQ.id

        def model = controller.show()

        assert model.FAQInstance == FAQ
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/FAQ/list'

        populateValidParams(params)
        def FAQ = new FAQ(params)

        assert FAQ.save() != null

        params.id = FAQ.id

        def model = controller.edit()

        assert model.FAQInstance == FAQ
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/FAQ/list'

        response.reset()

        populateValidParams(params)
        def FAQ = new FAQ(params)

        assert FAQ.save() != null

        // test invalid parameters in update
        params.id = FAQ.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/FAQ/edit"
        assert model.FAQInstance != null

        FAQ.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/FAQ/show/$FAQ.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        FAQ.clearErrors()

        populateValidParams(params)
        params.id = FAQ.id
        params.version = -1
        controller.update()

        assert view == "/FAQ/edit"
        assert model.FAQInstance != null
        assert model.FAQInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/FAQ/list'

        response.reset()

        populateValidParams(params)
        def FAQ = new FAQ(params)

        assert FAQ.save() != null
        assert FAQ.count() == 1

        params.id = FAQ.id

        controller.delete()

        assert FAQ.count() == 0
        assert FAQ.get(FAQ.id) == null
        assert response.redirectedUrl == '/FAQ/list'
    }
}
