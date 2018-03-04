# frozen_string_literal: true

Rails.application.routes.draw do
  post 'graphql' => 'graphqls#create'

  scope(
    module: 'api/v1', path: 'api/v1/',
    constraints: EnsureCorrectApiVersion.new(version: 1)
  ) do
    resources :pomodoros, only: :index
  end
end
