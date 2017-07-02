# frozen_string_literal: true
module Pomodoros
  class AppendService
    attr_reader :duration

    def initialize(duration:)
      @duration = duration
    end

    def call
      if valid_duration?
        last_pomodoro = Pomodoro.last
        last_pomodoro.update_attributes(duration: last_pomodoro.duration + duration.to_i)
      else
        Pomodoros::Errors::GenericError.new('Unable to update duration.')
      end
    end

    private

    def valid_duration?
      integer_duration = Integer(duration)
      integer_duration.positive?
    rescue ArgumentError
      false
    end
  end
end
