class ArchivedEventsController < ApplicationController
  before_filter :logged_in_user, only: [:create, :new, :update, :destroy]
  before_filter :correct_event_related_to_user,   only: [:create, :new]
  before_filter :admin_only, only: [:update, :destroy, :edit]

  # GET /archived_events
  # GET /archived_events.json
  def index
    sort = params[:sort] || session[:sort]


    #Handle sorting
    case sort
      when 'name'
        ordering,@name_header = 'name', 'hilite'
      when 'begins_at'
        ordering, @begins_at_header = 'begins_at', 'hilite'
      when 'system'
        ordering,@system_header = 'system', 'hilite'
    end


    #Preserve sorting selection in session
    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort, :selection => @selection and return
    end

    @archived_events = ArchivedEvent.order(ordering).all  || []




    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @archived_events }
    end
  end

  # GET /archived_events/1
  # GET /archived_events/1.json
  def show
    @event = ArchivedEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /archived_events/new
  # GET /archived_events/new.json
  def new
    @archived_event = ArchivedEvent.new
    @event = Event.find(params[:event_id])



    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @archived_event }
    end
  end

  # GET /archived_events/1/edit
  def edit

    @archived_event = ArchivedEvent.find(params[:id])
  end

  # POST /archived_events
  # POST /archived_events.json
  def create
    @event = Event.find(params[:event_id])

    @archived_event = ArchivedEvent.new(params[:archived_event])

    @archived_event.user_id=@event.user_id
    @archived_event.name=@event.name
    @archived_event.description=@event.description
    @archived_event.aftermath=params[:archived_event][:aftermath]
    @archived_event.subscriber_list=render_to_string(:partial => 'reservations/subscriber_list', :layout => false,
                          :locals => {:reservations => @event.reservations})
    @archived_event.system=@event.system
    @archived_event.max_player_num=@event.max_player_num
    @archived_event.min_player_num=@event.min_player_num
    @archived_event.descr_short=@event.descr_short
    @archived_event.begins_at=@event.begins_at
    @archived_event.deadline=@event.deadline


    respond_to do |format|
      if @archived_event.save  &&   @event.destroy

        format.html { redirect_to @archived_event, notice: 'Evento archiviato con successo.' }
        format.json { render json: @archived_event, status: :created, location: @archived_event }
      else
        format.html { render action: "new" }
        format.json { render json: @archived_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /archived_events/1
  # PUT /archived_events/1.json
  def update
    @archived_event = ArchivedEvent.find(params[:id])

    respond_to do |format|
      if @archived_event.update_attributes(params[:archived_event])
        format.html { redirect_to @archived_event, notice: 'Evento aggiornato con successo.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @archived_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archived_events/1
  # DELETE /archived_events/1.json
  def destroy
    @archived_event = ArchivedEvent.find(params[:id])
    @archived_event.destroy
    flash[:notice] = "Evento eliminato dagli archivi"

    respond_to do |format|
      format.html { redirect_to archived_events_url }
      format.json { head :no_content }
    end
  end

  def admin_only
    unless current_user.admin?
      flash[:notice] = "Azione non consentita"
      redirect_to(root_path)
    end
  end


end
