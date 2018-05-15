# frozen_string_literal: true

module Pomodoros
  module Cli
    class ResolveActivityTagsFromTagString
      extend LightService::Action

      expects :params
      promises :activity_tags

      executed do |context|
        found_tags = ActivityTag.where(shortcut: context.params[:activity_tags].split(''))

        if found_tags.present?
          context.activity_tags = found_tags
        else
          context.fail!(no_tags_found_error)
        end
      end

      def self.no_tags_found_error
        DaryllxdError.new(message: I18n.t('pomodoro.create.error_no_tags_found'))
      end
    end
  end
end
