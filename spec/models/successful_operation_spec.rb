# frozen_string_literal: true
RSpec.describe SuccessfulOperation do
  it 'is valid' do
    successful_operation = described_class.new

    expect(successful_operation).to be_valid
  end
end
