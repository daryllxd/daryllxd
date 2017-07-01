# frozen_string_literal: true
module Pomodoros
  class CreateService
    attr_reader :description, :duration

    def initialize(description:, duration:)
      @description = description
      @duration = duration
    end

    def call
      Pomodoro.create(create_pomodoro_attributes)
    end

    private

    def create_pomodoro_attributes
      {
        description: description,
        duration: duration
      }
    end
  end
end
