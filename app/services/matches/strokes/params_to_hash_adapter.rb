module Matches
  module Strokes
    class ParamsToHashAdapter
      def self.convert_all(action_controller_params)
        action_controller_params.map(&:to_unsafe_hash).map(&:symbolize_keys)
      end
    end
  end
end
