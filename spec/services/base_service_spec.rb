# frozen_string_literal: true

class TestBaseService < BaseService
  def call
    'yo'
  end
end

class TestBaseServiceWithParams < BaseService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    "Hi #{params}"
  end
end

RSpec.describe TestBaseService do
  context 'params not present' do
    it 'constructs the service and performs the #call instance method' do
      inherited_class = TestBaseService.call

      expect(inherited_class).to eq('yo')
    end
  end

  context 'params present' do
    it 'constructs the service and performs the #call instance method' do
      inherited_class = TestBaseServiceWithParams.call('haha')

      expect(inherited_class).to eq('Hi haha')
    end
  end
end
