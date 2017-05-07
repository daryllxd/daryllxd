module Pomodoros
  class ChangeDurationService
    attr_reader :pomodoro, :duration, :absolute

    def initialize(pomodoro:, duration:, absolute: false)
      @pomodoro = pomodoro
      @duration = duration
      @absolute = absolute
    end

    def call
      if absolute
        pomodoro.update_attributes!(duration: duration)
      else
        pomodoro.update_attributes!(duration: pomodoro.duration + duration)
      end

      pomodoro
    end
  end
end
