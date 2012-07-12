class InterestsController < ApplicationController
  #before_filter :logged_in_user
  #before_filter :has_rights_to, only: [:edit, :update, :destroy]

  #Ask confirm for Interest
  def new
    @group = Group.find(params[:group_id])
    @user = current_user
    @interest = Interest.new
  end

  def index

  end

  #Ask confirm of Interest
  #Sends email to owner
  def create
    @group = Group.find(params[:group_id])
    #@user = current_user
    @interest = @group.interests.build(params[:interest])
    @interest.user=current_user
    if  @group.user!=@interest.user &&  @interest.save
      #groupMailer.new_interest(@interest).deliver
      flash[:success] = "Interesse registrato"
      redirect_to group_path(@group)
    else
      if @group.user==@interest.user
        flash[:error] = "Non puoi interessarti al tuo gruppo"
        redirect_to group_path(@group)
      else
        flash[:error] = "Errori durante l'operazione"
        render 'new'
      end

    end

  end

  def show
    #@group = Group.find(params[:group_id])
    @interest= Interest.find(params[:id])
    @group = @interest.group
  end


  def destroy
=begin
    interest= Interest.find(params[:id])
    #send confirmation email
    if interest.user == current_user
      groupMailer.delete_Interest(Interest).deliver
      msg=" Mail inviata all'organizzatore ("+interest.group.user.name+")"
    else
      groupMailer.delete_Interest(interest,current_user).deliver
      msg=" Mail inviata all'utente ("+interest.user.name+")"
    end

    @group = group.find(params[:group_id])
    Interest.destroy
    flash[:success] = "Prenotazione eliminata."+msg
    redirect_to group_path(@group)
=end
  end

  private

  def has_rights_to
    r = Interest.find(params[:id])
    unless current_user?(r.user) || current_user?(r.group.user)
      flash[:notice] = "Azione non consentita"
      redirect_to group_path(r.group)
    end
  end

end
