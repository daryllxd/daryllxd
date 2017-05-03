class BaseService
  include ActiveSupport::Rescuable
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ActiveRecord::AssociationTypeMismatch, with: :handle_record_invalid

  # Template method -- ensure no excess attributes first.
  def call
    pre_method_hooks.each do |hook|
      if (error = hook.call)
        return error
      end
    end

    perform
  rescue StandardError => error
    rescue_with_handler(error) || raise
  end

  def pre_method_hooks
    []
  end

  protected

  # This converts all instance variables to a Struct which can be then
  # accessed by other classes.
  #
  # This is done so we can pass the values of this service class as a context to other
  # classes such as policies.
  # class WewertzService < BaseService
  #   attr_reader :pants
  #
  #   def initialize(pants:)
  #     @pants = pants
  #   end
  # end
  #
  # WewertzService.new(pants: 'wow').context => Struct that responds to #pants with 'wow'
  #
  def context
    Struct.new(*instance_values.keys.map(&:to_sym)).new(*instance_values.values)
  end

  def perform
    raise 'Must implement perform'
  end

  def record_invalid_error_from(model)
    Errors::RecordInvalid.new(model.full_error_message_string)
  end

  def handle_record_invalid(error)
    raise Errors::RecordInvalid.new(error.message, error)
  end

  # rubocop:disable GuardClause
  def ensure_no_excess_attributes(supplied_keys = attribute_keys, required_keys = editable_attributes)
    if (excess_attributes = supplied_keys.find { |k| !required_keys.include?(k) })
      Errors::WrongParams.new("`#{excess_attributes}`", supplied_keys)
    end
  end
  # rubocop:enable GuardClause

  def attribute_keys
    attributes.keys.map(&:to_sym)
  end

  def attributes
    raise "Services must implement 'attributes', or use 'attributes' as a variable"
  end

  def editable_attributes
    raise "Services must implement 'editable_attributes'"
  end
end
