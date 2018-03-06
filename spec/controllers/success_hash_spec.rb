# frozen_string_literal: true

RSpec.describe SuccessHash, type: :service do
  context '#render' do
    context 'no payload supplied' do
      it 'returns a success hash/JSON' do
        success_hash = described_class.new

        expect(success_hash.render).to eq(success: true)
      end
    end

    context 'a payload was supplied' do
      it 'appends the payload to the "data" key of the json hash' do
        success_hash = described_class.new(payload: 1)

        expect(success_hash.render).to eq(
          success: true,
          data: 1
        )
      end
    end
  end
end
