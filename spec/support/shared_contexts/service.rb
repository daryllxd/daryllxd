# frozen_string_literal: true
RSpec.shared_context 'service' do
  let!(:execute) { proc { |params| described_class.new(params).call } }
end
