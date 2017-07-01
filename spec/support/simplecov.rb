# frozen_string_literal: true
SimpleCov.start do
  add_filter '/app/controllers/concerns/documentation/'
  add_filter '/spec/support/'
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Services', 'app/services'
  add_group 'Presenters', 'app/presenters'
  add_group 'Libraries', 'lib'
end
