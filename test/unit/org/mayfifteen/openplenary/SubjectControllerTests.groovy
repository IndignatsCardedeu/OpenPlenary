package org.mayfifteen.openplenary



import org.junit.*
import org.mayfifteen.openplenary.Subject;
import org.mayfifteen.openplenary.SubjectController;

import grails.test.mixin.*

@TestFor(SubjectController)
@Mock(Subject)
class SubjectControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/subject/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.subjectInstanceList.size() == 0
        assert model.subjectInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.subjectInstance != null
    }

    void testSave() {
        controller.save()

        assert model.subjectInstance != null
        assert view == '/subject/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/subject/show/1'
        assert controller.flash.message != null
        assert Subject.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/subject/list'


        populateValidParams(params)
        def subject = new Subject(params)

        assert subject.save() != null

        params.id = subject.id

        def model = controller.show()

        assert model.subjectInstance == subject
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/subject/list'


        populateValidParams(params)
        def subject = new Subject(params)

        assert subject.save() != null

        params.id = subject.id

        def model = controller.edit()

        assert model.subjectInstance == subject
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/subject/list'

        response.reset()


        populateValidParams(params)
        def subject = new Subject(params)

        assert subject.save() != null

        // test invalid parameters in update
        params.id = subject.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/subject/edit"
        assert model.subjectInstance != null

        subject.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/subject/show/$subject.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        subject.clearErrors()

        populateValidParams(params)
        params.id = subject.id
        params.version = -1
        controller.update()

        assert view == "/subject/edit"
        assert model.subjectInstance != null
        assert model.subjectInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/subject/list'

        response.reset()

        populateValidParams(params)
        def subject = new Subject(params)

        assert subject.save() != null
        assert Subject.count() == 1

        params.id = subject.id

        controller.delete()

        assert Subject.count() == 0
        assert Subject.get(subject.id) == null
        assert response.redirectedUrl == '/subject/list'
    }
}
