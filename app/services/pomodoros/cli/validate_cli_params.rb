# frozen_string_literal: true

# Validate both Pomodoro and Activity Tag parameters before hitting the database.
# Expected to create one pomodoro with potentially
# multiple activity tags.
# Pomodoro: self-explanatory.
# Activity Tag: Ensure that we can at least retrieve the Activity Tag.
module Pomodoros
  module Cli
    # Because Thor takes in all ints as strings, we need to convert duration and
    # duration_offset to ints
    IntFromString = Types::Int.constructor(&:to_i)

    PomodoroSchema = Dry::Validation.Schema do
      configure do
        config.input_processor = :sanitizer
        config.type_specs = true
      end

      required(:description, :string).filled.str?
      required(:duration, IntFromString).filled(gt?: 0).int?
      required(:activity_tags, :string).filled.str?
      optional(:duration_offset, IntFromString).filled(gteq?: 0).int?
    end

    class ValidateCliParams
      extend LightService::Action

      expects :params

      executed do |context|
        context.fail_and_return!(wrong_params_error) if context.params.blank?
        validated_pomodoro = PomodoroSchema.call(context.params)

        if validated_pomodoro.success?
          context.params[:pomodoro_params] = validated_pomodoro.output
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
