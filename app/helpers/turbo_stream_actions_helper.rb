# frozen_string_literal: true

module TurboStreamActionsHelper
  def log(message, level = :log)
    turbo_stream_action_tag :log, message:, level:
  end
end

Turbo::Streams::TagBuilder.include TurboStreamActionsHelper
