class EventParticipantsController < ApplicationController
  before_action :set_event

  def create
    if @event.users.include?(current_user)
      flash[:alert] = "You're already participating in this event."
    else
      @event.users << current_user
      flash[:notice] = "You've joined the event successfully."
    end
    redirect_to @event
  end

  def destroy
    @event.users.delete(current_user)
    flash[:notice] = "You've left the event successfully."
    redirect_to @event
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
