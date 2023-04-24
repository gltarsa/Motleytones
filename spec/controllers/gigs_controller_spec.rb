# frozen_string_literal: true

require 'rails_helper'
require 'controllers/shared_examples/sign_in_required_examples.rb'
require 'controllers/shared_examples/admin_required_examples.rb'

RSpec.shared_examples_for "gig#create tests" do
  context 'when called as an admin user' do
    before do
      sign_in admin_user
      @new_gig = FactoryBot.attributes_for(:gig)
    end

    it 'creates a new gig' do
      starting_gig_count = Gig.count
      response
      ending_gig_count = Gig.count
      expect(ending_gig_count).to eql(starting_gig_count + 1)
    end

    it 'redirects to the new gig\'s show page' do
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(gig_url(Gig.last.id))
    end

    it 'displays a flash message containing "New gig added"' do
      response
      expect(flash[:notice]).to match(I18n.t('gig.added', count: Gig.count))
    end
  end
end

RSpec.shared_examples_for "gig#update tests" do
  context 'when called as an admin user' do
    it 'updates the gig' do
      sign_in admin_user
      @new_note = Faker::Lorem.sentence(word_count: 6)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(gig_url(gig.id))
      gig.reload
      expect(gig.note).to eq(@new_note)
    end
  end
end

RSpec.describe GigsController, type: :controller do
  let!(:user)      { FactoryBot.create(:user, name: "Ordinary User") }
  let(:admin_user) { FactoryBot.create(:user, :admin, name: "Admin User") }
  let!(:gig)       { FactoryBot.create(:gig) }

  describe 'GET #show' do
    let(:response) { get :show, params: { id: gig.id } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"

    context 'when logged in as an admin' do
      before do
        sign_in admin_user
        response
      end

      it 'responds with http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates an @gig variable' do
        expect(assigns(:gig)).to eq(gig)
      end
    end
  end

  describe 'GET #index' do
    let(:response) { get :index }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"

    context 'when logged in as an admin' do
      before do
        sign_in admin_user
        response
      end

      it 'responds with http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates @active_gigs with an array of gigs that are all now or in the future' do
        expect(assigns(:active_gigs)).to eq(Gig.active.ascending)
      end

      it 'populates @expired_gigs with an array of gigs that are all in the past' do
        expect(assigns(:expired_gigs)).to eq(Gig.expired.descending)
      end

      it 'renders the :index view' do
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #new' do
    let(:response) { get :new }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"

    context 'when logged in as an admin user' do
      before do
        sign_in admin_user
        response
      end

      it 'responds with success' do
        expect(response).to have_http_status(:success)
      end

      it 'creates an empty gig' do
        expect(assigns(:gig)).to be_a_new(Gig)
      end
    end
  end

  describe 'POST #create' do
    let(:response) { post :create, params: { gig: @new_gig } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"
    it_behaves_like "gig#create tests"
  end

  describe 'GET #create' do
    before do
      puts "------------ Why do any GET #create calls succeed? ---"
    end
    let(:response) { get :create, params: { gig: @new_gig } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"
    it_behaves_like "gig#create tests"
  end

  describe 'GET #edit' do
    let(:response) { get :edit, params: { id: gig.id } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"

    context 'when called as an admin user' do
      it 'allows me to edit the gig' do
        sign_in admin_user
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH #update' do
    let(:response) { patch :update, params: { id: gig.id, gig: { note: @new_note } } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"
    it_behaves_like "gig#update tests"
  end

  describe 'PUT #update' do
    let(:response) { put :update, params: { id: gig.id, gig: { note: @new_note } } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"
    it_behaves_like "gig#update tests"
  end

  describe 'DELETE #destroy' do
    let(:response) { delete :destroy, params: { id: gig.id } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"

    context 'when called as an admin user' do
      before do
        sign_in admin_user
      end

      it 'deletes the specified gig' do
        starting_gig_count = Gig.count
        response
        ending_gig_count = Gig.count
        expect(ending_gig_count).to eql(starting_gig_count - 1)
      end

      it 'sets flash message to contain "Gig deleted."' do
        response
        expect(flash[:notice]).to match(I18n.t('gig.deleted', count: Gig.count))
      end

      it 'redirects to gig page for that gig' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(gigs_url)
      end
    end
  end
end
