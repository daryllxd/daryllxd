# frozen_string_literal: true
module HandleRecordInvalid
  extend ActiveSupport::Concern

  def render_record_invalid(active_record_error)
    render json: { error: active_record_error }, status: 400 && return
  end

  included do
    rescue_from Errors::RecordInvalid, with: :render_record_invalid
  end
end
