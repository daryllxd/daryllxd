# frozen_string_literal: true

RSpec.describe GoogleBooks::Client do
  context '#search' do
    context 'happy path' do
      it 'returns a list of possible books from the Google Books API' do
        title = '7 Habits of Highly Effective People'

        response = described_class.new(title: title).search

        expect(response).to be_success
      end
    end
  end
end
