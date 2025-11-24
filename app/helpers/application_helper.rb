module ApplicationHelper
  def turbo_request?
    request.headers.key? :x_turbo_request_id
  end
end
