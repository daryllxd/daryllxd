# frozen_string_literal: true
class GraphqlsController < ApplicationController
  def create
    query_string = params[:query]
    # query_variables = JSON.parse(params[:variables]) || {}
    context = {}
    result = Schema.execute(query_string, variables: {}, context: context)
    render json: result
  end
end
