# frozen_string_literal: true

class EnsureCorrectApiVersion
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    request
      .headers
      .fetch(:accept)
      .include?("version=#{version}")
  end
end
