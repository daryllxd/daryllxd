# frozen_string_literal: true

# TODO: Remove this, it's just here because I have spring to run the tests faster, so I need to load Rails first.
# Though I should run the tests without spring.
require 'dry-types'
require 'dry-struct'

module Types
  include Dry::Types.module
end
