# frozen_string_literal: true
module HandleObjectNotFound
  extend ActiveSupport::Concern

  # Ensure that the finder_class finds an array of ActiveRecord obejcts from the finder_value
  # (expected to be an array) inside the param_hash_location (by default is the parent `params` object
  # sample params: Match, [{ id: 1}], params[:match]
  def ensure_found_all_from_params(finder_class, finder_value, param_hash_location = params)
    ensure_params_are_present(finder_value)
    raise(Errors::ObjectNotFound, finder_value) unless params[finder_value].is_a?(Array)

    array_of_ids = param_hash_location[finder_value].map { |elem| elem[:id].to_i }
    found_objects = finder_class.where(id: array_of_ids)

    unfound_ids = array_of_ids - found_objects.pluck(:id)

    # rubocop:disable GuardClause
    if unfound_ids.present?
      raise Errors::ObjectNotFound, finder_class: finder_class, param_hash_location: finder_value
    else
      found_objects
    end
    # rubocop:enable GuardClause
  end

  # Implied that if we are looking for a course using course_id, if we do not find course_id in the parameter list,
  # then we won't find it--at least we report to the user that course_id is missing,
  # not that we can't find a course using that course_id
  def ensure_found_object_from_params(finder_class, finder_value, finder_index = 'id', param_hash_location = params)
    ensure_params_are_present(finder_value)
    found_object = finder_class.find_by(finder_index => param_hash_location[finder_value])

    # rubocop:disable GuardClause
    if found_object
      found_object
    else
      raise Errors::ObjectNotFound, finder_class: finder_class, param_hash_location: finder_value
    end
    # rubocop:enable GuardClause
  end

  # "Cannot find course with that id."
  def render_not_found_if_object_not_found(error)
    render json: { error: error.message }, status: 404
  end

  included do
    rescue_from Errors::ObjectNotFound, with: :render_not_found_if_object_not_found
  end
end
