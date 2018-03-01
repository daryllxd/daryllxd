# frozen_string_literal: true

module Pomodoros
  module Values
    class ActivityTag < Dry::Struct
      attribute :name, Types::Strict::String
    end
  end
end
