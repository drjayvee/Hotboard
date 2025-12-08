require "test_helper"

class TicketTest < ActiveSupport::TestCase
  test "title must be present" do
    ticket = Ticket.new(description: "Test description")

    refute ticket.valid?
    assert_includes ticket.errors[:title], "can't be blank"
  end

  test "description must be present" do
    ticket = Ticket.new(title: "Test title")

    refute ticket.valid?
    assert_includes ticket.errors[:description], "can't be blank"
  end
end
