require 'rails_helper'

RSpec.describe FilesController, type: :controller do
  describe 'GET #songbook' do
    let(:response) { get :songbook }
    let(:songbook_base_name) { 'motleytones-songbook-' }

    it 'responds with http success' do
      expect(response).to be_successful
    end

    it 'has appropriate headers' do
      expect(response.header['Content-Type']).to include('application/pdf')
      expect(response.header['Content-Disposition']).to include("attachment; filename=\"#{songbook_base_name}")
    end
  end
end
