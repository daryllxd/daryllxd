class CoursePresenter < BasePresenter
  delegate :name, to: :country_club

  def present
    {
      id: id,
      name: name,
      location: 'New York',
      teeboxes: present_teeboxes
    }
  end

  def present_teeboxes
    TeeboxPresenter.present_collection(teeboxes)
  end
end
