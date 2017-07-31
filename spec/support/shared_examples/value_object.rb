# frozen_string_literal: true
# Just ensures that when you create an instance of a Klass, setters Foo and Bar are accessible
# it_should_behave_like('value_object_with_setters', 'foo', 'bar'))
# means you initialize with foo, bar, and they are accessible somewhere
RSpec.shared_examples('value_object_with_setters') do |*setters|
  it 'initializes, gets, and sets correctly' do
    setter_hash = setters.each_with_object({}) { |v, h| h[v] = v }.symbolize_keys

    initialized_value_object = described_class.new(setter_hash)

    setters.each do |setter|
      expect(initialized_value_object.send(setter)).to be_present
    end
  end
end
