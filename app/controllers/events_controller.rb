class EventsController < ApplicationController
  before_action :authenticate_admin!, only: %i(new create edit update)
  before_action :set_event, only: %i(edit update default_series_name)

  def index
    @events = Event.includes(:prizes).includes(:final_borders).order(id: :desc).page(params[:page])
  end

  def show
    @event = params[:id].present? ? Event.includes(:prizes).find(params[:id]) : Event.includes(:prizes).border_available.last
    return redirect_to events_path if @event.nil?

    if @event.has_border?
      @latest_data = @event.border.latest
      @latest_data_team = @event.border(Event::ULA_FINAL_TEAM_SERIES_NAME).latest if @event.ula_final?
      if @event.hhp_event?
        @idol_map = Rubimas.all.each_with_object({}) { |idol, hash| hash[idol.id] = idol.name.shorten }
        @color_map = Rubimas.all.each_with_object({}) { |idol, hash| hash[idol.id] = idol.color }
      end
    end
    @recent_events = Event.includes(:prizes).includes(:final_borders).send(@event.event_type.to_sym).border_available.order(started_at: :desc).limit(10)

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
    t = Time.current
    @event = Event.new(
      started_at: Time.local(t.year, t.month, t.day, 12),
      ended_at: t.end_of_day
    )
    @event.prizes.build
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_path(@event), flash: { alert: { type: 'success', message: 'イベントを作成しました' } }
    else
      render :new
    end
  end

  def edit
    @event.prizes.build unless @event.prizes.any?
  end
  def update
    @event.assign_attributes(event_params)

    if @event.save
      redirect_to event_path(@event), flash: { alert: { type: 'success', message: 'イベントを更新しました' } }
    else
      render :edit
    end
  end

  def default_series_name
    render json: { series_name: @event.default_series_name }
  end

  private
  def event_params
    params.require(:event).permit(
      :name,
      :event_type,
      :started_at,
      :ended_at,
      :series_name,
      :records_available,
      prizes_attributes: [:id, :idol_id, :_destroy]
    )
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
