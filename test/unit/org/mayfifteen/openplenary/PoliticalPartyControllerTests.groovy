package org.mayfifteen.openplenary



import org.junit.*
import org.mayfifteen.openplenary.PoliticalParty;
import org.mayfifteen.openplenary.PoliticalPartyController;

import grails.test.mixin.*

@TestFor(PoliticalPartyController)
@Mock(PoliticalParty)
class PoliticalPartyControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/party/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.partyInstanceList.size() == 0
        assert model.partyInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.partyInstance != null
    }

    void testSave() {
        controller.save()

        assert model.partyInstance != null
        assert view == '/party/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/party/show/1'
        assert controller.flash.message != null
        assert PoliticalParty.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/party/list'

        populateValidParams(params)
        def party = new PoliticalParty(params)

        assert party.save() != null

        params.id = party.id

        def model = controller.show()

        assert model.partyInstance == party
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/party/list'

        populateValidParams(params)
        def party = new PoliticalParty(params)

        assert party.save() != null

        params.id = party.id

        def model = controller.edit()

        assert model.partyInstance == party
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/party/list'

        response.reset()

        populateValidParams(params)
        def party = new PoliticalParty(params)

        assert party.save() != null

        // test invalid parameters in update
        params.id = party.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/party/edit"
        assert model.partyInstance != null

        party.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/party/show/$party.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        party.clearErrors()

        populateValidParams(params)
        params.id = party.id
        params.version = -1
        controller.update()

        assert view == "/party/edit"
        assert model.partyInstance != null
        assert model.partyInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/party/list'

        response.reset()

        populateValidParams(params)
        def party = new PoliticalParty(params)

        assert party.save() != null
        assert PoliticalParty.count() == 1

        params.id = party.id

        controller.delete()

        assert PoliticalParty.count() == 0
        assert PoliticalParty.get(party.id) == null
        assert response.redirectedUrl == '/party/list'
    }
}
