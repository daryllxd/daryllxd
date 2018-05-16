# frozen_string_literal: true

module Api
  module V1
    class ActivityTagsController < ApiController
      def index
        activity_tags = ActivityTag.all

        render_success(payload: { activity_tags: activity_tags })
      end
    end
  end
end
