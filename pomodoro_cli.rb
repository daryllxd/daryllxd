# frozen_string_literal: true
require 'boot_cli'
BootCli.new(presumed_symlink: '/usr/local/bin/p').boot

require 'app/services/pomodoros/boot_cli'

class PomodoroCli < Thor
  desc 'new', 'Makes a new pomodoro'
  method_option :description, type: :string, aliases: '-d'
  method_option :duration, type: :string, aliases: '-u'
  method_option :tags, type: :string, aliases: '-t'

  def new
    # Pomodoros::CreateInteractor.new(

    # ).call

    resolved_tags = Pomodoros::TagResolver.new(
      tag_string: options[:tags]
    ).call

    Pomodoros::CreateService.new(
      description: options[:description],
      duration: options[:duration],
      tags: resolved_tags
    ).call

    puts Pomodoros::Presenters::ForDateRange.new.present
  end

  desc 'append', 'Appends to the last pomodoro'
  method_option :duration, type: :string, aliases: '-u'

  def append
    Pomodoros::AppendService.new(
      duration: options[:duration]
    ).call

    puts Pomodoros::Presenters::ForDateRange.new.present
  end

  desc 'list', 'Shows pomodoros for the date_range.'
  method_option :date_range, type: :string, aliases: '-u'

  def list
    date_range = Cli::DateRangeResolver.new(date_range_string: options[:date_range]).call

    puts Pomodoros::Presenters::ForDateRange.new(date_range: date_range).present
  end

  desc 'tags', 'Shows all activity tags'

  def tags
    puts Pomodoros::Presenters::ActivityTags.new.present
  end
end
