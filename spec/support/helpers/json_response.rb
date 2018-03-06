# frozen_string_literal: true

def json_response
  JSON.parse(response.body)
rescue JSON::ParserError
  raise 'JSON parse error on response.body'
end

def json_response_data
  json_response['data']
end
