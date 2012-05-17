class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  before_filter :logged_in_user, only: [:create, :destroy, :new]

  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @user=current_user
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @user=current_user
    params[:event].delete("user_id")
    @event = current_user.events.build(params[:event])
    @event.status=1; #proposed

    #TODO -> Transform it into a regular validation (ugly)
    if @event.deadline > @event.begins_at
      flash[:error] = "Data di conferma errata"
      render 'new'
    else
      if  @event.save
        flash[:success] = "Evento creato!"
        redirect_to user_path(current_user)
      else
        render 'new'
      end
    end

end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end