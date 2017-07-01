# frozen_string_literal: true
RSpec.describe StravaLords::DescriptionCreator do
  context 'happy path' do
    it 'spits out a string with then needed tags' do
      tags = %w(core fasted 15)

      description = described_class.new(tags: tags).call

      expect(description).to eq '[fasted][core][15rpe]'
    end
  end
end
