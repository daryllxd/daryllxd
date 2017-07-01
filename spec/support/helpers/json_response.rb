# frozen_string_literal: true
def json_response
  JSON.parse(response.body)
rescue
  raise 'JSON parse error on response.body'
end
