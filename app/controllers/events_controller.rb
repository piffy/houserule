# encoding: utf-8

class EventsController < ApplicationController
  before_filter :logged_in_user, only: [:create, :destroy, :new, :edit, :update, :create]
  before_filter :correct_event_for_user,   only: [:edit, :update, :destroy]

  def index
    @user=current_user
    @total=Event.count
    @selection =  params[:selection] || session[:selection] || :not_begun
    sort = params[:sort] || session[:sort]

    if @selection=='archived'
      redirect_to archived_events_path and return
    end

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

  def reserved_events
    @reserved=true
    @user = User.find(params[:user_id])
    @events = @user.reserved_events
    @current_user=current_user
  end

  # GET /owned_events/
  def owned_events
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
      redirect_to :sort => sort and return
    end


    @user = User.find(params[:user_id])
    @current_user=current_user

    #Handle Pagination
    if ordering.nil?
      @events = Event.where("user_id="+@user.id.to_s).paginate(page: params[:page])
    else

      @events = Event.where("user_id="+@user.id.to_s).unscoped.page(params[:page]).order(ordering)

    end

    #@events = Event.where("user_id="+@user.id.to_s).paginate(page: params[:page])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @events }
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
    unless (params[:group_id].nil?)
      @group=Group.find(params[:group_id])
      flash.now[:notice]  ="Questo evento sarà collegato al gruppo '#{@group.name}'"
    end
    unless (params[:convention_id].nil?)
      @convention=Convention.find(params[:convention_id])
      flash.now[:notice]  ="Questo evento sarà proposto per essere inserito nella convention '#{@convention.name}'"
    end



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
    @user = current_user
    params[:event].delete("user_id")
    @event = current_user.events.build(params[:event])
    @event.status=0; #proposed
    @convention=Convention.find(params[:convention][:id]) unless params[:convention].nil?
    msg = "Evento creato!"
    if @event.save
      unless (params[:group].nil?)
        @group=Group.find(params[:group][:id])
        if ( current_user?(@event.user) || current_user.admin? ||  current_user?(@group.user))
          @event.groups << @group
          msg = msg +" L'evento, inoltre, è collegato al gruppo #{@group.name}"
        end
      end
      unless (params[:convention].nil?)

        @convention=Convention.find(params[:convention][:id])
        @event.begins_at=@convention.begin_date
        @event.deadline=@event.begins_at
        @convention.link(@event)
        msg = msg +" Evento proposto per la convention #{@convention.name}"
      end


      flash[:success] = msg
      redirect_to event_event_wizard_path(@event,"game")
    else
      render :new
    end



end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      flash[:success] = "Evento aggiornato"
      redirect_to event_event_wizard_path(@event,'game')
    else
      render "edit"
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

  def convention_unlink
    @event = Event.find(params[:event_id])
    convention=@event.convention
    if convention.nil?
      flash[:warning] = "Evento non associato"
    else
      convention.unlink(@event)
      flash[:success] = "Evento rimosso dal programma"
    end

    render 'edit'
  end

end

private


def datepicker_adapter
  if params[:event][:"begins_at_date_only"]
    /(\d\d)-(\d\d)-(\d\d\d\d)/ =~ params[:event]["begins_at_date_only"]
    params[:event][:"begins_at(1i)"]=Regexp.last_match[3]
    params[:event][:"begins_at(2i)"]=Regexp.last_match[2]
    params[:event][:"begins_at(3i)"]=Regexp.last_match[1]
    /(\d\d)-(\d\d)-(\d\d\d\d)/ =~ params[:event]["deadline_date_only"]
    params[:event][:"deadline(1i)"]=Regexp.last_match[3]
    params[:event][:"deadline(2i)"]=Regexp.last_match[2]
    params[:event][:"deadline(3i)"]=Regexp.last_match[1]
    params[:event].delete("begins_at_date_only")
    params[:event].delete("deadline_date_only")
  end
end
