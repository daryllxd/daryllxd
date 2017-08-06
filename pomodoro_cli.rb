# frozen_string_literal: true
require 'thor'
require 'active_record'
require 'app/services/pomodoros/boot_cli'

# Ensure all references to timezones are in UTC.
ENV['TZ'] = 'UTC'
Time.zone = 'UTC'

class PomodoroCli < Thor
  desc 'new', 'Makes a new pomodoro'
  method_option :description, type: :string, aliases: '-d'
  method_option :duration, type: :string, aliases: '-u'
  method_option :tags, type: :string, aliases: '-t'

  def new
    resolved_tags = Pomodoros::TagResolver.new(
      tag_string: options[:tags]
    ).call

    Pomodoros::CreateService.new(
      description: options[:description],
      duration: options[:duration],
      tags: resolved_tags
    ).call

    puts Pomodoros::Presenters::ForToday.new.present
  end

  desc 'append', 'Appends to the last pomodoro'
  method_option :duration, type: :string, aliases: '-u'

  def append
    Pomodoros::AppendService.new(
      duration: options[:duration]
    ).call

    puts Pomodoros::Presenters::ForToday.new.present
  end

  desc 'list', 'Shows pomodoros'

  def list
    puts Pomodoros::Presenters::ForToday.new.present
  end

  desc 'tags', 'Shows all activity tags'

  def tags
    puts Pomodoros::Presenters::ActivityTags.new.present
  end
end
