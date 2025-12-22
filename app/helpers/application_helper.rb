module ApplicationHelper
  def turbo_request?
    request.headers.key? "x-turbo-request-id"
  end

  def turbo_frame_request?
    request.headers.key? "turbo-frame"
  end
end
