class EventFavoritesController < ApplicationController
  before_action :set_event

  def create
    @event_favorite = current_user.event_favorites.new(event_id: @event.id)

    if @event_favorite.save
      redirect_to @event, notice: 'Event was favorited successfully.'
    else
      redirect_to @event, alert: 'Unable to favorite this event.'
    end
  end

  def destroy
    @event_favorite = current_user.event_favorites.find_by(event_id: @event.id)

    if @event_favorite&.destroy
      redirect_to @event, notice: 'Event was unfavorited successfully.'
    else
      redirect_to @event, alert: 'Unable to unfavorite this event.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
