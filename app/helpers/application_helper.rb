module ApplicationHelper
  def turbo_request?
    request.headers.key? :x_turbo_request_id
  end

  def turbo_frame_request?
    request.headers.key? :turbo_frame
  end
end
