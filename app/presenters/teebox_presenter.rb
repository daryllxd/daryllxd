class TeeboxPresenter < BasePresenter
  def present
    {
      id: id,
      name: name,
      description: description,
      course_rating: course_rating,
      slope: slope
    }
  end
end
