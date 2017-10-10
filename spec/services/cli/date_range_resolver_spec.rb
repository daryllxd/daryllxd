# frozen_string_literal: true
RSpec.describe Cli::DateRangeResolver, type: :service do
  context 'happy path' do
    context 'yesterday' do
      it 'resolves' do
        expect(DateRangeFactory).to receive(:yesterday)
        execute.call(date_range_string: 'y')
      end
    end
  end
end
