# frozen_string_literal: true

module Api
  module V1
    class PomodorosController < ApiController
      def index
        pomodoros = Pomodoros::Aggregates::ForDateRange.new.pomodoro_collection

        render json: { data: { pomodoros: pomodoros } }
      end
    end
  end
end
