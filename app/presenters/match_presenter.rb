class MatchPresenter < BasePresenter
  attr_reader :requester

  # Requester = MatchParticipant
  def initialize(model:, requester: nil)
    super(model: model)
    @requester = requester
  end

  def present
    if valid?
      {
        id: id,
        requester_id: requester.id,
        status: status,
        started_at: started_at,
        started_by_user_id: started_by_user.id,
        course: present_course,
        participants: present_participants,
        submatches: present_matches,
        strokes: present_strokes
      }
    else
      { id: '' }
    end
  end

  private

  def present_course
    CoursePresenter.new(model: course).present.merge(teebox: present_teebox).except(:teeboxes)
  end

  def present_teebox
    TeeboxPresenter.new(model: teebox).present.merge(
      holes: TeeboxHolePresenter.present_collection(teebox.teebox_holes)
    )
  end

  def present_strokes
    @cached_strokes ||=
      begin
        Matches::StrokePresenter.new(model: model).present
      end
  end

  def present_participants
    Matches::MatchParticipantPresenter.present_collection(
      ordered_match_participants
    )
  end

  def present_matches
    submatches.order('id ASC').map do |submatch|
      SubmatchPresenter.new(model: submatch, requester: requester_teammate(submatch)).present
    end
  end

  # A bit dirty, but in order to do the perspective check correctly,
  # we need to set the requester as the requester's teammate in the
  # matches that the requester isn't a direct participant in.
  def requester_teammate(submatch)
    if submatch.match_participants.include?(requester)
      requester
    else
      (submatch.match.team_submatch.team_of(match_participant: requester) - [requester]).first
    end
  end

  def ordered_match_participants
    match_participants.order('match_participants.id ASC')
  end
end
