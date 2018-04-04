# frozen_string_literal: true

module HasSteps
  # HasSteps: Define functions that can be ran, and execute all of them in order
  # If any one of those fails, then do a rollback on the database
  # Implement a final return value when everythhhing is finished
  def call
    ActiveRecord::Base.transaction do
      steps.map do |step|
        result = step.call

        if result.blank? || !result.valid?
          @errors = result.errors
          raise ActiveRecord::Rollback
        end
      end

      return success_return_value
    end
    return errors
  rescue NotImplementedError => e
    raise e
  rescue StandardError => e
    DaryllxdError.new(message: e.to_s)
  end

  # Must implement #steps and #success_return_value
  MUST_IMPLEMENT_METHODS = %i[steps success_return_value].freeze

  MUST_IMPLEMENT_METHODS.each do |x|
    define_method(x) do
      raise NotImplementedError, not_implemented_message(__method__)
    end
  end

  private

  def not_implemented_message(method_name)
    "Method `#{method_name}` is not implemented`. When including `HasSteps`, this method is required."
  end
end
