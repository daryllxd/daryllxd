# frozen_string_literal: true

RSpec.describe Api::V1::BooksController, type: :controller do
  context '#scan' do
    context 'happy path' do
      it 'grabs all the Pomodoros in a day' do
        get :search, params: { title: 'Antifragile' }

        expect(response).to be_success
        expect(json_response).to have_key('books')
      end
    end

    context 'errors' do
      it 'spec_name' do
        allow(GoogleBooks::BookSearcher).to receive(:call).and_return(
          create(:daryllxd_error)
        )

        get :search, params: { title: 'Antifragile' }

        expect(response).not_to be_success
      end
    end
  end
end
