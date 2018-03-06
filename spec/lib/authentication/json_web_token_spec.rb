# frozen_string_literal: true

RSpec.describe Authentication::JsonWebToken do
  context '.encode and .decode' do
    context 'happy path' do
      it 'decodes the token in an indifferent hash' do
        new_json_token = described_class.encode(user_id: 1)

        decoded_token = described_class.decode(new_json_token)

        expect(decoded_token).to be_valid

        # Expect indifferent hash
        expect(decoded_token.payload[:user_id]).to eq(1)
        expect(decoded_token.payload['user_id']).to eq(1)
      end
    end

    context 'mismatched token' do
      it 'returns an error' do
        new_json_token = described_class.encode(user_id: 1)

        decoded_token = described_class.decode(new_json_token + 'a')

        expect(decoded_token).not_to be_valid
        expect(decoded_token.message).to eq('Incorrect JSON Web token.')
      end
    end
  end
end
