module Users
  class UpdateService < BaseService
    include BaseUpdateService

    attr_reader :user, :attributes, :editable_attributes

    def initialize(user:, attributes:)
      @user = user
      @attributes = attributes
      @editable_attributes = editable_attributes
    end

    def perform
      updated_user = user.update_attributes_cleanly(attributes_hash)

      if updated_user.valid?
        updated_user
      else
        record_invalid_error_from(updated_user)
      end
    end

    def pre_method_hooks
      [proc { ensure_no_excess_attributes }]
    end

    def attributes_hash
      build_edit_attributes_hash(
        editable_attributes: editable_attributes,
        supplied_attributes: attributes
      )
    end

    def editable_attributes
      %i(first_name last_name handicap_value location)
    end
  end
end
