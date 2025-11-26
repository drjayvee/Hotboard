require "application_system_test_case"

class TicketsTest < ApplicationSystemTestCase
  def setup
    @ticket_one = tickets(:one)
    @ticket_two = tickets(:two)
  end

  def test_inline_edit
    visit root_url

    # Edit first ticket
    first(:link, text: "Edit").click

    assert_field "Title", with: @ticket_one.title
    assert_text @ticket_two.title # 2nd ticket is still shown

    # Change title and submit
    fill_in "Title", with: "1st one"
    click_button "Update Ticket"

    # Back on index, assert form is gone and both tickets are shown
    refute_field "Title"
    assert_text "1st one"
    assert_text @ticket_two.title
  end
end
