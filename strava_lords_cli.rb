require 'thor'

STRAVA_LORDS_PATH = './app/services/strava_lords'.freeze

Dir.glob(File.join(STRAVA_LORDS_PATH, '**', '*.rb'), &method(:require))

class StravaLordsCli < Thor
  desc 'new', 'Creates a new Strava description for an activity'
  method_option :tags, type: :string, aliases: '-t'

  def new
    tags = StravaLords::DescriptionCreator.new(
      tags: options[:tags].split(',')
    ).call

    puts tags
  end
end