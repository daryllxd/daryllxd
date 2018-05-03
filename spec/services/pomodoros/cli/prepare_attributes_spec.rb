# frozen_string_literal: true

RSpec.describe Pomodoros::Cli::PrepareAttributes do
  context 'happy path' do
    it 'empty hash: returns an empty hash' do
      expect(described_class.call({})).to be_valid
    end

    it 'applies transformations for each attribute supplied' do
      prepared_attributes = described_class.call(description: 'Hello', duration: '99', duration_offset: '98')

      expect(prepared_attributes.payload).to eq(description: 'Hello', duration: 99, duration_offset: 98)
    end

    it 'only applies the transformation to the attributes if they were present' do
      prepared_attributes = described_class.call(duration: '99')

      expect(prepared_attributes.payload).to eq(duration: 99)
    end
  end

  context 'errors' do
    it 'has unneeded attributes-raises an error' do
      error = described_class.call(pants: 'whatever')

      expect(error).not_to be_valid
    end
  end
end
