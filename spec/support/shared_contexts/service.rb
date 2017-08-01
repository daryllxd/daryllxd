# frozen_string_literal: true
RSpec.shared_context 'service' do
  let!(:execute) do
    proc do |params|
      if params.present?
        described_class.new(params).call
      else
        described_class.new.call
      end
    end
  end
end
