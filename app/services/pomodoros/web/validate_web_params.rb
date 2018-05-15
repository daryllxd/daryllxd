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
          required(:name).filled.str?
        end
      end
    end

    class ValidateWebParams
      extend LightService::Action

      expects :params

      executed do |context|
        context.fail_and_return!(wrong_params_error) if context.params.blank?
        validated_pomodoro = PomodoroSchema.call(context.params)

        context.fail!(wrong_params_error(validated_pomodoro.errors)) if validated_pomodoro.failure?
      end

      def self.wrong_params_error(payload = nil)
        DaryllxdError.new(
          message: 'Wrong Params', payload: payload
        )
      end
    end
  end
end
