require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe Admin::SubmissionsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Submission. As you add validations to Submission, be sure to
  # adjust the attributes here as well.

  let!(:touchpoint) { FactoryBot.create(:touchpoint) }

  let(:valid_attributes) {
    {
      touchpoint_id: touchpoint.id,
      answer_01: "Test body text",
      answer_02: "Test First Name",
      answer_03: "Test Last name",
      answer_04: "test_email@lvh.me"
    }
  }

  let(:invalid_attributes) {
    {
      answer_01: nil,
      answer_02: "James",
      answer_03: "Madison",
      answer_04: nil
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SubmissionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:admin) { FactoryBot.create(:user, :admin)}

  before do
    sign_in(admin)
  end

  describe "GET #show" do
    it "returns a success response" do
      submission = Submission.create! valid_attributes
      get :show, params: { id: submission.to_param, touchpoint_id: touchpoint.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { touchpoint_id: touchpoint.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      submission = Submission.create! valid_attributes
      get :edit, params: {
        id: submission.to_param,
        touchpoint_id: touchpoint.id
      }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Submission" do
        expect {
          post :create, params: {
            submission: valid_attributes,
            touchpoint_id: touchpoint.id
          }, session: valid_session
        }.to change(Submission, :count).by(1)
      end

      it "redirects to the created submission" do
        post :create, params: {
          submission: valid_attributes,
          touchpoint_id: touchpoint.id
        }, session: valid_session
        expect(response).to redirect_to(touchpoint_submission_path(touchpoint.id, Submission.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { submission: invalid_attributes, touchpoint_id: touchpoint.id }, session: valid_session, format: :json
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq({ "body" => ["can't be blank"] })
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested submission" do
        submission = Submission.create! valid_attributes
        put :update, params: {
          id: submission.to_param,
          submission: new_attributes
        }, session: valid_session
        submission.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the submission" do
        submission = Submission.create! valid_attributes
        put :update, params: {id: submission.to_param, submission: valid_attributes, touchpoint_id: touchpoint.id }, session: valid_session
        expect(response).to redirect_to(admin_submission_path(submission))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        submission = Submission.create! valid_attributes
        expect {
          put :update, params: {id: submission.to_param, submission: invalid_attributes }, session: valid_session
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "returns a success response (i.e. to display the 'edit' template)" do
        submission = Submission.create! valid_attributes
        put :update, params: { id: submission.to_param, submission: invalid_attributes, touchpoint_id: touchpoint.id }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested submission" do
      submission = Submission.create! valid_attributes
      expect {
        delete :destroy, params: {id: submission.to_param, touchpoint_id: touchpoint.id }, session: valid_session
      }.to change(Submission, :count).by(-1)
    end

    it "redirects to the submissions list" do
      submission = Submission.create! valid_attributes
      delete :destroy, params: {id: submission.to_param, touchpoint_id: touchpoint.id }, session: valid_session
      expect(response).to redirect_to(touchpoint_submissions_url(touchpoint))
    end
  end

end
