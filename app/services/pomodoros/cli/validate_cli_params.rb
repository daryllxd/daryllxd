# frozen_string_literal: true

# Validate both Pomodoro and Activity Tag parameters before hitting the database.
# Expected to create one pomodoro with potentially
# multiple activity tags.
# Pomodoro: self-explanatory.
# Activity Tag: Ensure that we can at least retrieve the Activity Tag.
module Pomodoros
  module Cli
    PomodoroSchema = Dry::Validation.Schema do
      required(:description).filled.str?
      required(:duration).filled(gt?: 0).int?
      required(:activity_tags).filled.str?
      optional(:duration_offset).filled(gteq?: 0).int?
    end

    class ValidateCliParams
      extend LightService::Action

      expects :params

      executed do |context|
        context.fail_and_return!(wrong_params_error) if context.params.blank?
        validated_pomodoro = PomodoroSchema.call(context.params)

        if validated_pomodoro.success?
          context.params[:pomodoro] = validated_pomodoro.output
        else
          context.fail!(wrong_params_error(validated_pomodoro.errors))
        end
      end

      def self.wrong_params_error(payload = nil)
        DaryllxdError.new(
          message: 'Wrong Params', payload: payload
        )
      end
    end
  end
end
