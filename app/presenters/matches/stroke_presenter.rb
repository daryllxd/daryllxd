# constructor model = instance of Match, not Stroke
module Matches
  class StrokePresenter < BasePresenter
    def present
      stroke_query.map do |stroke|
        {
          id: stroke.id,
          hole_number: stroke.hole_number,
          match_participant_id: stroke.match_participant_id,
          first_name: stroke.first_name,
          value: stroke.value,
          manual_junk: stroke.manual_junk
        }
      end
    end

    def stroke_query
      Stroke
        .select('strokes.*, teebox_holes.hole_number, users.first_name')
        .joins(:match)
        .joins(:teebox_hole)
        .joins(match_participant: :participant)
        .where('matches.id = ?', id)
        .order('strokes.match_participant_id, teebox_holes.hole_number')
    end
  end
end
