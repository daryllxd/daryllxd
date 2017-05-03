module Admin
  module QaToolController
    extend ActiveSupport::Concern

    MATCH_CSV_FILE_PATH = './spec/fixtures/match.csv'.freeze

    def create
      if (match_result_file = params[:match_result_file])
        @csv_to_process = CSV.read(match_result_file.tempfile)
        @csv_contents = File.read(match_result_file.tempfile)
        flash[:notice] = 'Uploaded file!'
      elsif (match_result = params[:match_result])
        @csv_to_process = textarea_to_csv
        @csv_contents = match_result['text']
        flash[:notice] = 'Uploaded text!'
      end

      @results = testing_tool_class.new(
        csv_contents: @csv_to_process,
        reversed: params[:reversed][:flag] == '1' ? true : false
      ).generate

      render template: template_to_render_path
    end

    def show
      @csv_contents ||= File.read(MATCH_CSV_FILE_PATH)
    end

    def textarea_to_csv
      params[:match_result]['text'].split("\r\n").map { |row| row.split(',') }
    end

    def template_to_render_path
      raise 'Must implement template_to_render_path'
    end

    def testing_tool_class
      raise 'Must implement testing_tool_class'
    end
  end
end
