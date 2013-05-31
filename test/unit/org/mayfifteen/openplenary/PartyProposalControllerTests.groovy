package org.mayfifteen.openplenary



import org.junit.*
import grails.test.mixin.*

@TestFor(PartyProposalController)
@Mock(PartyProposal)
class PartyProposalControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/partyVote/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.partyVoteInstanceList.size() == 0
        assert model.partyVoteInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.partyVoteInstance != null
    }

    void testSave() {
        controller.save()

        assert model.partyVoteInstance != null
        assert view == '/partyVote/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/partyVote/show/1'
        assert controller.flash.message != null
        assert PartyProposal.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/partyVote/list'

        populateValidParams(params)
        def partyVote = new PartyProposal(params)

        assert partyVote.save() != null

        params.id = partyVote.id

        def model = controller.show()

        assert model.partyVoteInstance == partyVote
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/partyVote/list'

        populateValidParams(params)
        def partyVote = new PartyProposal(params)

        assert partyVote.save() != null

        params.id = partyVote.id

        def model = controller.edit()

        assert model.partyVoteInstance == partyVote
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/partyVote/list'

        response.reset()

        populateValidParams(params)
        def partyVote = new PartyProposal(params)

        assert partyVote.save() != null

        // test invalid parameters in update
        params.id = partyVote.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/partyVote/edit"
        assert model.partyVoteInstance != null

        partyVote.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/partyVote/show/$partyVote.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        partyVote.clearErrors()

        populateValidParams(params)
        params.id = partyVote.id
        params.version = -1
        controller.update()

        assert view == "/partyVote/edit"
        assert model.partyVoteInstance != null
        assert model.partyVoteInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/partyVote/list'

        response.reset()

        populateValidParams(params)
        def partyVote = new PartyProposal(params)

        assert partyVote.save() != null
        assert PartyProposal.count() == 1

        params.id = partyVote.id

        controller.delete()

        assert PartyProposal.count() == 0
        assert PartyProposal.get(partyVote.id) == null
        assert response.redirectedUrl == '/partyVote/list'
    }
}
