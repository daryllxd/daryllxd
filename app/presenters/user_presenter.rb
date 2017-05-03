class UserPresenter < BasePresenter
  def present
    {
      email: email,
      id: id,
      first_name: first_name,
      ghin: ghin,
      handicap_value: handicap_value.to_s,
      last_name: last_name,
      location: location,
      nickname: nickname
    }
  end
end
