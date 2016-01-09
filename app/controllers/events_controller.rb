class EventsController < ApplicationController
  include AuthActions
  before_action :authenticate_admin!, only: %i(new create edit update)
  before_action :set_event, only: %i(edit update)

  def index
    @events = Event.includes(:final_borders).order(id: :desc).page(params[:page])
  end

  def show
    @event = params[:id].present? ? Event.find(params[:id]) : Event.border_available.last
    return redirect_to events_path if @event.nil?
    @latest_data = @event.border.latest if @event.has_border?
    @dataset = @event.border.dataset if @event.has_border?
    @recent_events = Event.includes(:final_borders).send(@event.event_type.to_sym).border_available.order(started_at: :desc).limit(10)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          id: @event.id,
          url: event_url(@event.id),
          series_name: @event.series_name,
          name: @event.name,
          started_at: @event.started_at,
          ended_at: @event.ended_at
        }
      end
    end
  end

  def new
    today = Date.today
    @event = Event.new(
      started_at: Time.new(today.year, today.month, today.day, 17),
      ended_at: today.end_of_day
    )
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_path(@event), flash: { alert: { type: 'success', message: 'イベントを作成しました' } }
    else
      render :new
    end
  end

  def edit; end
  def update
    @event.assign_attributes(event_params)

    if @event.save
      redirect_to event_path(@event), flash: { alert: { type: 'success', message: 'イベントを更新しました' } }
    else
      render :edit
    end
  end

  private
  def event_params
    params.require(:event).permit(
      :name,
      :event_type,
      :started_at,
      :ended_at,
      :series_name,
      :records_available
    )
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
