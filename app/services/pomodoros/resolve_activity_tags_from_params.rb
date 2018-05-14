# frozen_string_literal: true

# Retrieve all Activity Tags from IDs. If any match doesn't work, fail.
# TODO: Must retrieve ActivityTag only if both id and description match.
module Pomodoros
  class ResolveActivityTagsFromParams
    extend LightService::Action

    expects :params
    promises :activity_tags

    executed do |context|
      tag_ids_to_be_fetched = context.params[:activity_tags].map_fetch(:id).uniq

      fetched_tags = ActivityTag.where(id: tag_ids_to_be_fetched)

      tag_ids_not_found = tag_ids_to_be_fetched - fetched_tags.map(&:id)

      if tag_ids_not_found.length.positive?
        context.fail!(error_from(tag_ids_not_found))
      else
        context.activity_tags = fetched_tags
      end
    end

    def self.error_from(tag_ids_not_found)
      DaryllxdError.new(
        message: 'Unable to find activity tags', payload: { activity_tag_ids: tag_ids_not_found }
      )
    end
  end
end
