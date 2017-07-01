# frozen_string_literal: true
class BasePresenter < Delegator
  def self.present_collection(collection_of_models)
    collection_of_models.map do |model|
      new(model: model).present
    end
  end

  attr_reader :model

  def initialize(model: NullModel.new)
    @model = model
  end

  # Delegate, if possible, calls to the wrapped model
  def __getobj__
    model
  end

  def present
    raise 'Must implement present if you are a presenter.'
  end
end
