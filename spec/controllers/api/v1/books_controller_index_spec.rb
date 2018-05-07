# frozen_string_literal: true

RSpec.describe Api::V1::BooksController, type: :controller do
  context 'happy path' do
    it 'grabs all the Pomodoros in a day' do
      allow(controller).to receive(:doorkeeper_token) { double(acceptable?: true) }

      get :index

      expect(response).to be_success
      expect(json_response).to have_key('books')
    end
  end
end
