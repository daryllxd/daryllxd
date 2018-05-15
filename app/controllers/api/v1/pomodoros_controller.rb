# frozen_string_literal: true

module Api
  module V1
    class PomodorosController < ApiController
      def index
        pomodoros = Pomodoros::Aggregates::ForDateRange.new.pomodoro_collection

        render json: { pomodoros: pomodoros }
      end

      def create
        created_pomodoro = Pomodoros::Web::CreateOrganizer.call(clean_params)

        if created_pomodoro.success
          render_success(payload: { pomodoro: created_pomodoro })
        else
          render_error_from(created_pomodoro.message)
        end
      end
    end
  end
end
