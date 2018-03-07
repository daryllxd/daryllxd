# frozen_string_literal: true

RSpec.describe ErrorResponse, type: :service do
  context '#render' do
    context 'no payload' do
      it 'renders an error response with a message' do
        error_response = described_class.new(message: 'The error')

        expect(error_response.render).to eq(
          success: false, data: { message: 'The error' }
        )
      end
    end

    context 'payload present' do
      it 'renders and error response, and the payload too' do
        error_response = described_class.new(message: 'The error', payload: 'pants')

        expect(error_response.render).to eq(
          success: false, data: { message: 'The error', payload: 'pants' }
        )
      end
    end
  end
end
