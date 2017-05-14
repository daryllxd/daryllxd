module StravaLords
  class DescriptionCreator
    attr_reader :tags

    def initialize(tags:)
      @tags = tags
    end

    def call
      tags
        .map { |tag| to_strava_tag(tag) }
        .sort
        .map { |tag| "[#{tag.value}]" }
        .join('')
    end

    private

    def to_strava_tag(tag)
      StravaLords::Tag.new(value: tag)
    end
  end
end
