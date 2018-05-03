# frozen_string_literal: true

require 'boot_cli'
BootCli.new(presumed_symlink: '/usr/local/bin/p').boot

require 'app/services/pomodoros/boot_cli'

class PomodoroCli < Thor
  desc 'new', 'Makes a new pomodoro'
  method_option :description, type: :string, aliases: '-d', default: ''
  method_option :duration, type: :string, aliases: '-u', default: 0
  method_option :tags, type: :string, aliases: '-t', default: ''
  method_option :duration_offset, type: :string, aliases: '-o', default: 0

  def new
    new_pomodoros = Pomodoros::CreateInteractor.new(options.symbolize_keys).call

    if new_pomodoros.valid?
      puts Pomodoros::Presenters::ForDateRange.new.present
    else
      puts new_pomodoros.to_s
    end
  end

  desc 'update', 'Updates the last pomodoro'
  method_option :description, type: :string, aliases: '-d'
  method_option :duration, type: :string, aliases: '-d'
  method_option :tags, type: :string, aliases: '-t'

  def update
    last_pomodoro = Pomodoro.last
    new_pomodoros = Pomodoros::UpdateInteractor.call(
      options.symbolize_keys.merge(
        pomodoro_id: last_pomodoro.id
      )
    )

    if new_pomodoros.valid?
      puts Pomodoros::Presenters::ForDateRange.new.present
    else
      puts new_pomodoros.to_s
    end
  end

  desc 'append', 'Appends to the last pomodoro'
  method_option :duration, type: :string, aliases: '-u'

  def append
    Pomodoros::Append.call(
      duration: options[:duration]
    )

    puts Pomodoros::Presenters::ForDateRange.new.present
  end

  desc 'destroy', 'Destroys the last pomodoro'

  def destroy
    Pomodoros::Destroy.call

    puts Pomodoros::Presenters::ForDateRange.new.present
  end

  desc 'list', 'Shows pomodoros for the date_range.'
  method_option :date_range, type: :string, aliases: '-u'
  method_option :view_type, type: :string, aliases: '-v'

  def list
    date_range = Cli::DateRangeResolver.new(date_range_string: options[:date_range]).call
    view_resolver = Cli::ViewTypeResolver.new(view_type_string: options[:view_type]).call

    puts view_resolver.new(date_range: date_range).present
  end

  desc 'tags', 'Shows all activity tags'

  def tags
    puts Pomodoros::Presenters::ActivityTags.new.present
  end
end
