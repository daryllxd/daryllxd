module Matches
  module Strokes
    class UpdateService
      attr_reader :found_stroke, :stroke_attributes

      def initialize(found_stroke:, **stroke_attributes)
        @found_stroke = found_stroke
        @stroke_attributes = stroke_attributes
      end

      def call
        found_stroke.update_attributes!(build_update_attribute_hash)

        found_stroke.reload
      end

      private

      def build_update_attribute_hash
        update_stroke_attributes.each_with_object({}) do |key, acc|
          acc[key] = stroke_attributes[key] if stroke_attributes[key]

          acc
        end
      end

      def update_stroke_attributes
        [:value, :manual_junk]
      end
    end
  end
end
