# frozen_string_literal: true
require 'thor'
require 'active_record'
require './app/services/pomodoros/boot_cli'

class PomodoroCli < Thor
  desc 'new', 'Makes a new pomodoro'
  method_option :description, type: :string, aliases: '-d'
  method_option :duration, type: :string, aliases: '-u'
  method_option :tags, type: :string, aliases: '-t'

  def new
    Pomodoros::CreateService.new(
      description: options[:description],
      duration: options[:duration]
    ).call

    puts Pomodoros::Presenters::ForToday.new.present
  end

  desc 'list', 'Shows pomodoros'

  def list
    puts Pomodoros::Presenters::ForToday.new.present
  end
end
