# frozen_string_literal: true
class TeeboxHolePresenter < BasePresenter
  def present
    {
      id: id,
      hole_number: hole_number,
      par_value: par_value,
      handicap_value: handicap_value,
      yard_distance: yard_distance
    }
  end
end
