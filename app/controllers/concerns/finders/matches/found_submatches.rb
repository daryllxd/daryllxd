module Finders
  module Matches
    module FoundSubmatches
      extend ActiveSupport::Concern

      def found_submatches(action: params[:action])
        @cached_found_submatches ||=
          begin
            permitted_params = send("permitted_#{action}_params")
            converted_submatches = Adapters::Matches::SubmatchesAdapter.new(
              params: permitted_params.to_h
            ).call

            if converted_submatches.valid?
              converted_submatches
            else
              render_error_from(converted_submatches)
            end
          end
      end
    end
  end
end
