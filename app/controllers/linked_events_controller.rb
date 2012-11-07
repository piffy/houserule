# encoding: utf-8
class LinkedEventsController < ApplicationController
  before_filter :logged_in_user
  before_filter :user_is_group_admin_or_event_admin, only: [:edit,:destroy]
  def new
    @group=Group.find(params[:group_id])
    if current_user==@group.user
      @events=Event.all-@group.events
    else
      @events=current_user.events-@group.events #.in_groups_of(2, false)
    end

  end

  def confirm
    @group=Group.find(params[:group_id])
    @event=Event.find(params[:event_id])

  end


  def create
    @group=Group.find(params[:group_id])
    @event=Event.find(params[:event_id])
    unless current_user?(@event.user) || current_user.admin? ||  current_user?(@group.user)
      flash[:notice] = "Azione non consentita"
      redirect_to(event_path(@event))
     else
      @event.groups << @group
      flash[:success] = "L'evento #{@event.name} è ora collegato al gruppo #{@group.name}"
      redirect_to group_path(@group)
    end
  end

  def edit
    @group=Group.find(params[:group_id])
    @event=Event.find(params[:id])
  end

  def destroy
    @group=Group.find(params[:group_id])
    @event=Event.find(params[:id])
    if @event.groups.delete(@group)
      flash[:success] = "L'evento #{@event.name} non è più collegato al gruppo #{@group.name}"
    else
      flash[:error] = "Si è verificato un errore"
    end
    redirect_to group_path(@group)
  end

  private

  def user_is_group_admin_or_event_admin
    @group=Group.find(params[:group_id])
    @event=Event.find(params[:id])
    unless current_user?(@event.user) || current_user.admin? ||  current_user?(@group.user)
      flash[:notice] = "Azione non consentita"
      redirect_to(event_path(@event))
    end
  end



end
