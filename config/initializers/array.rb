# frozen_string_literal: true
class Array
  # Non-destructive fill method
  # WIP -- how do you pass the block to the underlying fill?
  def pad_right(*args)
    dup.fill(*args)
  end
end
