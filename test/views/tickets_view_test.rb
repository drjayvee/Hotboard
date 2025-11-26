# frozen_string_literal: true

require "test_helper"

class TicketsViewTest < ActionView::TestCase
  def setup
    @ticket = Ticket.new
    @controller.controller_path = "tickets" # so that view will find partials such as `render "form"`
  end

  test "edit should set turbo-frame[target] appropriately" do
    # Replace with assert_turbo_frame(target: "_top", rendered...) once available https://github.com/hotwired/turbo-rails/commit/2530f69
    frame_selector = %(turbo-frame[id="#{dom_id(@ticket)}"])

    # Non-Turbo request
    render template: "tickets/edit"

    assert_equal "_top", rendered.html.at(frame_selector)["target"]

    # Turbo Drive request
    rendered.clear # because of https://github.com/rails/rails/issues/56235

    @request.headers[:x_turbo_request_id] = "123"
    render template: "tickets/edit"

    assert_equal "_top", rendered.html.at(frame_selector)["target"]

    # Turbo request from a frame
    rendered.clear

    @request.headers[:turbo_frame] = "ticket_123"
    render template: "tickets/edit"

    assert_equal "_self", rendered.html.at(frame_selector)["target"]
  end
end
