# frozen_string_literal: true

RSpec.describe SuccessfulOperation do
  it 'is valid' do
    successful_operation = described_class.new

    expect(successful_operation).to be_valid
    expect(successful_operation.payload).to be_nil
  end

  it 'can take a payload' do
    successful_operation = described_class.new(payload: 'pants')

    expect(successful_operation.payload).to eq('pants')
  end
end
