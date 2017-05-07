RSpec.describe DaryllxdError do
  it { should be_a_kind_of(StandardError) }

  context 'methods' do
    subject { described_class.new }

    it { should_not be_valid }
  end
end
