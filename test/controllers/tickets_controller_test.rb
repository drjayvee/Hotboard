require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test "root should be tickets#index" do
    get root_path

    assert_dom "h1", "Tickets"
  end

  test "should get index" do
    get tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_url
    assert_response :success
  end

  test "should create ticket" do
    assert_difference("Ticket.count") do
      post tickets_url, params: { ticket: { description: @ticket.description, title: @ticket.title } }
    end

    assert_redirected_to ticket_url(Ticket.last)
  end

  test "should show ticket" do
    get ticket_url(@ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_url(@ticket)
    assert_response :success
  end

  test "edit should set turbo-frame[target] appropriately" do
    frame_selector = %(turbo-frame[id="#{dom_id(@ticket)}"])

    # assert_turbo_frame would be nice. See turbo-rails https://github.com/hotwired/turbo-rails/commit/2530f69

    # Non-Turbo request
    get edit_ticket_url(@ticket)
    assert_equal "_top", css_select(frame_selector).first["target"]

    # Turbo Drive request
    get edit_ticket_url(@ticket), headers: { x_turbo_request_id: "123" }
    assert_equal "_top", css_select(frame_selector).first["target"]

    # Turbo request from a frame
    get edit_ticket_url(@ticket), headers: { turbo_frame: "ticket_123" }
    assert_equal "_self", css_select(frame_selector).first["target"]
  end

  test "should update ticket" do
    patch ticket_url(@ticket), params: { ticket: { description: @ticket.description, title: @ticket.title } }
    assert_redirected_to ticket_url(@ticket)
  end

  test "should destroy ticket" do
    assert_difference("Ticket.count", -1) do
      delete ticket_url(@ticket)
    end

    assert_redirected_to tickets_url
  end
end
