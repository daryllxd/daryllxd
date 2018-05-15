# frozen_string_literal: true

module Pomodoros
  class CreatePomodoro
    extend LightService::Action

    expects :params, :activity_tags
    promises :pomodoro

    executed do |context|
      created_pomodoro = Pomodoro.create(create_pomdoro_attributes(context.params[:pomodoro]))

      if created_pomodoro.valid?
        context.pomodoro = created_pomodoro
      else
        context.fail!(error_from(created_pomodoro))
      end
    end

    def self.create_pomdoro_attributes(params)
      duration_offset = (params[:duration_offset] || 0).minutes

      {
        description: params[:description],
        duration: params[:duration],
        started_at: Time.current - params[:duration].minutes - duration_offset
      }
    end

    def self.error_from(created_pomodoro)
      DaryllxdError.new(
        message: 'Unable to create pomodoro', payload: created_pomodoro.errors.full_messages
      )
    end
  end
end
