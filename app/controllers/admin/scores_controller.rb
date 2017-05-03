module Admin
  class ScoresController < ApplicationController
    include Admin::QaToolController

    def testing_tool_class
      Matches::Scoring::Parsers::OverallMatchScore
    end

    def template_to_render_path
      'admin/scores/show'
    end
  end
end
