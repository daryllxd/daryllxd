# frozen_string_literal: true
module Enumerable
  # This is needed for calculating indie match results, we need to remember past final scores
  # http://stackoverflow.com/questions/30992959/map-with-accumulator-on-an-array
  def map_with_accumulator(initial)
    inject([initial]) { |acc, el| acc << yield(acc.last, el) }
  end

  # Just so we don't have to do stuff like this:
  # json_response['contacts'].map do |x| x['email'] end
  # We can write it like this:
  # json_response['contacts'].map_fetch('email')
  #
  def map_fetch(key)
    map { |obj| obj[key] }
  end

  # Just a patch, when rendering a collection/array, to make sure that all elements inside are valid
  def valid?
    all?(&:valid?)
  end
end
