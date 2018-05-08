# frozen_string_literal: true

RSpec.describe GoogleBooks::BookSearcher do
  context 'happy path' do
    it 'returns a list of possible books from the Google Books API' do
      title = '7 Habits of Highly Effective People'

      response = described_class.call(title: title)

      expect(response).to be_valid
      expect(response.payload.keys).to match_array(%i[count books])
    end
  end

  context 'errors' do
    it 'no books found: it returns an error' do
      title = 'NO RESULTDFQJWLDHQKWCBJAKJBZKXLJCHL'

      response = described_class.call(title: title)

      expect(response).not_to be_valid
      expect(response.message).to include('No books found for')
    end

    it 'no books found: it returns an error' do
      allow_any_instance_of(GoogleBooks::Client).to receive(:search).and_return(
        double(success?: false)
      )

      response = described_class.call(title: 'irrelevant')

      expect(response).not_to be_valid
      expect(response.message).to include('Try again later.')
    end
  end
end
