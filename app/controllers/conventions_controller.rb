class ConventionsController < ApplicationController
  before_filter :logged_in_user, except: [:index, :show]
  before_filter :has_rights_to,   only: [:edit, :update, :destroy]
  # GET /conventions
  # GET /conventions.json
  def index
    @conventions = Convention.incoming.order(:begin_date).all
    @selectionc =  params[:selectionc] || session[:selectionc] || :incoming

    #preserve selection is session
    if params[:selectionc] != session[:selectionc]
      session[:selectionc] = params[:selectionc]
      redirect_to :selectionc => @selectionc and return
    end

    @conventions =Convention.send(@selectionc).order(:begin_date).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conventions }
    end
  end


  def propose
    @event = Event.find(params[:event_id])
    @conventions = Convention.starting_after(@event.begins_at).ending_before(@event.begins_at)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @convention }
    end
  end

  def link
    @convention=Convention.find(params[:event][:convention_id])
    @event = Event.find(params[:event_id])


      respond_to do |format|
        if @convention.compatible_with?(@event) && @event.convention_id.nil?
          @convention.link(@event)
          format.html { redirect_to @convention, notice: "Evento proposto per la convention #{@convention.name}" }
          format.json { render json: @convention, status: :created, location: @convention }
        else
          format.html { redirect_to @convention, error: "Evento incompatibile" }
          format.json { render json: @convention.errors, status: :unprocessable_entity }
        end
      end

  end

  def approve
    @event = Event.find(params[:event_id])
    redirect_to @event and return  if @event.convention.nil?
    @convention=Convention.find(@event.convention_id)

    respond_to do |format|
      if @convention.compatible_with?(@event) && @event.status==4
        @event.status=2
        @event.save
        format.html { redirect_to @convention, notice: "Evento confermato per il programma di #{@convention.name}" }
        format.json { render json: @convention, status: :created, location: @convention }
      else
        format.html { redirect_to @convention, error: "Evento incompatibile" }
        format.json { render json: @convention.errors, status: :unprocessable_entity }
      end
    end

  end

  def disapprove
    @event = Event.find(params[:event_id])
    redirect_to @event and return  if @event.convention.nil?
    @convention=Convention.find(@event.convention_id)

    respond_to do |format|
      if @event.status==4 || @event.status==2
        @event.convention_id=nil
        if (@event.deadline==@event.begins_at) && (@event.begins_at==nil)
          @event.status=0
        else
          @event.status=1
        end
        @event.save
        format.html { redirect_to @convention, notice: "Evento rimosso dal programma il programma di #{@convention.name}" }
        format.json { render json: @convention, status: :created, location: @convention }
      else
        format.html { redirect_to @convention, error: "Errore di sistema" }
        format.json { render json: @convention.errors, status: :unprocessable_entity }


      end
    end

  end


  # GET /conventions/1
  # GET /conventions/1.json
  def show
    @convention = Convention.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @convention }
    end
  end

  # GET /conventions/new
  # GET /conventions/new.json
  def new
    @user=current_user
    @convention = Convention.new
    @convention.begin_date = Date.today + 7.days
    @convention.end_date = Date.today + 9.days
    #@location_list = (Group.all(:select => "location")+User.all(:select => "Location")+Event.all(:select => "Location")).map(&:location).delete_if {|x| x == nil || x == ""}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @convention }
    end
  end

  # GET /conventions/1/edit
  def edit
    @convention = Convention.find(params[:id])
  end

  # POST /conventions
  # POST /conventions.json
  def create

    @user=current_user
    datepicker_adapter
    @convention = Convention.create(params[:convention])
    @convention.user_id = @user.id

    respond_to do |format|
      if @convention.save
        format.html { redirect_to @convention, notice: 'Convention creata con successo.' }
        format.json { render json: @convention, status: :created, location: @convention }
      else
        format.html { render action: "new" }
        format.json { render json: @convention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /conventions/1
  # PUT /conventions/1.json
  def update
    @convention = Convention.find(params[:id])
    datepicker_adapter
    respond_to do |format|
      if @convention.update_attributes(params[:convention])
        format.html { redirect_to @convention, notice: 'Convention modificata con successo.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @convention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conventions/1
  # DELETE /conventions/1.json
  def destroy
    @convention = Convention.find(params[:id])
    @convention.destroy

    respond_to do |format|
      format.html { redirect_to conventions_url }
      format.json { head :no_content }
    end
  end

  #TODO Refactor this!!!
  def datepicker_adapter
    if params[:convention]["begin_date_only"]
      /(\d\d)-(\d\d)-(\d\d\d\d)/ =~ params[:convention]["begin_date_only"]
      params[:convention][:"begin_date(1i)"]=Regexp.last_match[3]
      params[:convention][:"begin_date(2i)"]=Regexp.last_match[2]
      params[:convention][:"begin_date(3i)"]=Regexp.last_match[1]
      /(\d\d)-(\d\d)-(\d\d\d\d)/ =~ params[:convention]["end_date_only"]
      params[:convention][:"end_date(1i)"]=Regexp.last_match[3]
      params[:convention][:"end_date(2i)"]=Regexp.last_match[2]
      params[:convention][:"end_date(3i)"]=Regexp.last_match[1]
      params[:convention].delete("begin_date_only")
      params[:convention].delete("end_date_only")
    end
  end

  def has_rights_to
    @convention = Convention.find(params[:id])
    unless current_user?(@convention.user) || current_user.admin?
      flash[:notice] = "Azione non consentita"
      redirect_to convention_path(@convention)
    end
  end


end
