class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  def index
    @tickets = Ticket.all
    @new_ticket = Ticket.new
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      flash.notice = "Ticket was successfully created."
      respond_to do |format|
        format.turbo_stream # refresh index
        format.html { redirect_to tickets_path }
      end
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to tickets_path, notice: "Ticket was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @ticket.destroy!
    redirect_to tickets_path, notice: "Ticket was successfully destroyed.", status: :see_other
  end

  private
    def set_ticket
      @ticket = Ticket.find(params.expect(:id))
    end

    def ticket_params
      params.expect(ticket: [ :title, :description ])
    end
end
