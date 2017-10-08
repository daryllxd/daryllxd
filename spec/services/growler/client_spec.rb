RSpec.describe Growler::Client do
  it 'is a singleton' do
    expect { described_class.new }.to raise_error(NoMethodError)
  end

  context '#notify' do
    it 'sends a message over to Growl' do
      expect_any_instance_of(Growl).to receive(:notify)
      allow_any_instance_of(Growl).to receive(:notify)
      described_class.instance.notify
    end
  end
end
