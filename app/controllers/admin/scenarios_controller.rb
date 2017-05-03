module Admin
  class ScenariosController < ApplicationController
    include Admin::QaToolController

    def testing_tool_class
      Matches::Scoring::Parsers::ScenarioAnalysis
    end

    def template_to_render_path
      'admin/scenarios/show'
    end
  end
end
