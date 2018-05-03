# frozen_string_literal: true

class PomodoroTestBaseService < Pomodoros::BaseService
  def initialize(*args); end

  def call
    'swag'
  end
end

RSpec.describe Pomodoros::BaseService do
  it 'call' do
    inherited_class = PomodoroTestBaseService.call('huh')

    expect(inherited_class).to eq('swag')
  end
end
