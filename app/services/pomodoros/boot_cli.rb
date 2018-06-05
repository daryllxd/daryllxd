# frozen_string_literal: true

# Loads everything needed for the Pomodoro sub-app
require 'dry-types'
require 'dry-struct'
require 'dry-validation'
require 'light-service'

module Types
  include Dry::Types.module
end

require 'app/services/has_steps'
require 'app/services/cli/date_range_resolver'
require 'app/services/cli/view_type_resolver'
require 'app/models/date_range_factory'
require 'app/models/constants'
require 'app/models/successful_operation'
require 'app/models/pomodoro'
require 'app/models/pomodoro_activity_tag'
require 'app/models/date_range'
require 'app/models/activity_tag'
require 'app/models/pomodoros/queries/for_date_range'
require 'app/services/pomodoros/base_service'
require 'app/services/pomodoros/cli/create_organizer'
require 'app/services/pomodoros/cli/validate_cli_params'
require 'app/services/pomodoros/cli/resolve_activity_tags_from_tag_string'
require 'app/services/pomodoros/create_pomodoro'
require 'app/services/pomodoros/create_pomodoro_activity_tags'
require 'app/services/pomodoros/append'
require 'app/services/pomodoros/update_interactor'
require 'app/services/pomodoros/update'
require 'app/services/pomodoros/destroy'
require 'app/services/pomodoros/tag_resolver'
require 'app/errors/daryllxd_error'
require 'app/services/pomodoros/entities/activity_tag'
require 'app/services/pomodoros/entities/pomodoro'
require 'app/services/pomodoros/entities/pomodoro_collection'
require 'app/services/pomodoros/aggregates/for_date_range'
require 'app/services/pomodoros/errors/generic_error'
require 'app/services/pomodoros/presenters/activity_tags'
require 'app/services/pomodoros/presenters/activity_tag_breakdown'
require 'app/services/pomodoros/presenters/for_date_range'
require 'app/services/pomodoros/presenters/terminal_table'
