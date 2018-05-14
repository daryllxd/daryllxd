# frozen_string_literal: true

# Validate both Pomodoro and Activity Tag parameters before hitting the database.
# Expected to create one pomodoro with potentially
# multiple activity tags.
# Pomodoro: self-explanatory.
# Activity Tag: Ensure that we can at least retrieve the Activity Tag.
module Pomodoros
  module Web
    PomodoroSchema = Dry::Validation.Schema do
      required(:pomodoro).schema do
        required(:description).filled.str?
        required(:duration).filled(gt?: 0).int?
        required(:started_at).filled.date_time?
      end

      required(:activity_tags).each do
        schema do
          required(:id).filled.int?
          required(:description).filled.str?
        end
      end
    end

    class ValidateWebParams
      extend LightService::Action

      expects :params

      executed do |context|
        validated_pomodoro = PomodoroSchema.call(context.params)

        if validated_pomodoro.failure?
          context.fail!(DaryllxdError.new(message: 'Wrong Params', payload: validated_pomodoro.errors))
        end
      end
    end
  end
end
