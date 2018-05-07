# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  # devise_for :users
  post 'graphql' => 'graphqls#create'

  scope(
    module: 'api/v1', path: 'api/v1/',
    constraints: EnsureCorrectApiVersion.new(version: 1)
  ) do
    resources :registrations, only: :create

    resources :pomodoros, only: :index
    resources :books, only: :index
  end
end
