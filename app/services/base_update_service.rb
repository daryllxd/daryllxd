module BaseUpdateService
  def build_edit_attributes_hash(
    editable_attributes:, supplied_attributes:
  )
    editable_attributes.each_with_object({}) do |key, acc|
      acc[key] = supplied_attributes[key] if supplied_attributes[key]

      acc
    end
  end

  def attributes
    raise 'Must implement'
  end
end
