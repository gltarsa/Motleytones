# frozen_string_literal: true

RSpec.shared_examples "admin-required actions" do
  context 'when called as a non-admin user' do
    before do
      sign_in user
    end

    it 'sets flash message to "You must be an admin" message' do
      expect(response).to have_http_status(:redirect)
      expect(flash[:alert]).to match(I18n.t('.must_be_admin'))
    end

    it 'redirects to root' do
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end
  end
end
