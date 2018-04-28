# frozen_string_literal: true

RSpec.describe DaryllxdError do
  it { should be_a_kind_of(StandardError) }

  context 'methods' do
    subject { described_class.new }

    it { should_not be_valid }
    it { expect(subject.message).to eq 'Error.' }
    it { expect(subject.to_s).to eq 'Error.' }
  end
end
