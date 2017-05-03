class MatchParticipantPresenter < BasePresenter
  def present
    {
      id: id,
      email: participant.email,
      first_name: participant.first_name,
      handicap_value: presented_handicap_value,
      last_name: participant.last_name
    }
  end
end
