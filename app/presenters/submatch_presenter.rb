class SubmatchPresenter < BasePresenter
  include ::Submatches::VersusNamePresenter

  attr_reader :requester

  def initialize(model:, requester:)
    super(model: model)
    @requester = requester
  end

  def present
    {
      id: id,
      match_mode: match_mode,
      match_type: match_type.humanize.titleize,
      participants: grouped_by_teams.values.flatten,
      submatch_name: versus_name(model),
      stake: stake.to_i,
      match_scores: present_match_scores,
      max_aloha: present_max_aloha
    }
  end

  private

  def present_max_aloha
    requester_team, competitor_team = check_requester_perspective

    Matches::Scoring::MaxAlohaIncentiveComputation.new(
      submatch: model.to_value,
      teebox: model.match.teebox.to_scoring_value,
      requester: requester_team,
      competitor: competitor_team
    ).call
  end

  def grouped_by_teams
    @_grouped_by_teams ||= model.grouped_by_teams
  end

  def present_match_scores
    @cached_scores ||=
      begin
        model.to_mother_array(
          requester: requester,
          mother_array_class: Matches::Scoring::Presenters::JustScores
        ).present
      end
  end

  def check_requester_perspective
    Matches::Scoring::PerspectiveCheck.new(
      requester: requester.convert_to_score_array_params,
      teams: submatch_participants_to_match_participants_value
    ).call
  end
end
