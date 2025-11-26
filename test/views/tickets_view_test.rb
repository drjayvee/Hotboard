# frozen_string_literal: true

require "test_helper"

class TicketsViewTest < ActionView::TestCase
  def setup
    @ticket = Ticket.new
    @controller.controller_path = "tickets" # so that view will find partials such as `render "form"`
  end

  [
    [ {},                            "_top",  "non-Turbo request" ],
    [ { x_turbo_request_id: "123" }, "_top",  "Turbo Drive request" ],
    [ { turbo_frame: "ticket_123" }, "_self", "Turbo request from a frame" ]
  ].each do |test_case|
    headers, target, description = test_case

    test "edit sets turbo-frame[target] correctly for #{description}" do
      # Replace with assert_turbo_frame(target: "_top", rendered...) once available https://github.com/hotwired/turbo-rails/commit/2530f69
      frame_selector = %(turbo-frame[id="#{dom_id(@ticket)}"])
      request.headers.merge! headers

      render template: "tickets/edit"

      assert_equal target, rendered.html.at(frame_selector)["target"]

      rendered.clear # because of https://github.com/rails/rails/issues/56235
    end
  end
end
