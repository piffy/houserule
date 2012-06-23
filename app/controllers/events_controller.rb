class EventsController < ApplicationController
  before_filter :logged_in_user, only: [:create, :destroy, :new, :edit, :update, :create]
  before_filter :has_rights_to,   only: [:edit, :update, :destroy]

  def index
    @user=current_user
    @selection =  params[:selection] || session[:selection] || :all_events
    sort = params[:sort] || session[:sort]

    #Handle sorting
    case sort
      when 'name'
        ordering,@name_header = 'name', 'hilite'
      when 'begins_at'
        @begins_at_header = 'hilite'
      when 'system'
        ordering,@system_header = 'system', 'hilite'
    end


    #Preserve sorting selection in session
    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort, :selection => @selection and return
    end



    #preserve selection is session
    if params[:selection] != session[:selection]
      session[:selection] = params[:selection]
      redirect_to :sort => sort, :selection => @selection and return
    end


  #Handle Pagination
    if ordering.nil?
      @events = Event.send(@selection).paginate(page: params[:page])
    else

      @events = Event.unscoped.send(@selection).page(params[:page]).order(ordering)

    end

  end

  # GET /events/1
  # GET /events/1.json
  def show
  @user=current_user
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
    @event.begins_at = 7.days.from_now
    @event.deadline = 6.days.from_now


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

    if  @event.save
      flash[:success] = "Evento creato!"
      redirect_to user_path(current_user)
    else
      render 'new'
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

private

def has_rights_to
  @event = Event.find(params[:id])
   unless current_user?(@event.user)
    flash[:notice] = "Azione non consentita"
    redirect_to(root_path)
  end
end
