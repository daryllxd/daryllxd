module Matches
  module Strokes
    class MassUpdateService
      attr_reader :found_strokes, :multiple_stroke_attributes

      def initialize(found_strokes:, multiple_stroke_attributes:)
        @found_strokes = found_strokes
        @multiple_stroke_attributes = multiple_stroke_attributes
      end

      def call
        ActiveRecord::Base.transaction do
          found_strokes.zip(multiple_stroke_attributes).each do |(stroke, stroke_attr)|
            Matches::Strokes::UpdateService.new(found_stroke: stroke, **stroke_attr).call
          end
        end.map(&:first)
      end
    end
  end
end
