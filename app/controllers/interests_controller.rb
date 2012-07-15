class InterestsController < ApplicationController
  before_filter :logged_in_user, only: [:create, :destroy, :new, :edit, :update]
  before_filter :has_rights_to, only: [:edit, :update, :destroy]

  #Ask confirm for Interest
  def new
    @group = Group.find(params[:group_id])
    @user = current_user
    @interest = Interest.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @interest = Interest.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @interest = Interest.find(params[:id])

    respond_to do |format|
      if @interest.update_attributes(params[:interest])
        format.html { redirect_to @group, notice: 'Interesse aggiornato' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  #Sends email to group owner
  def create
    @group = Group.find(params[:group_id])
    case show_interest(@group)
      when 1
        flash[:error] = "Non puoi interessarti al tuo gruppo"
        redirect_to group_path(@group)
      when false
        flash[:error] = "Errori durante l'operazione"
        render 'new'
      when true
        flash[:success] = "Interesse registrato"
        redirect_to group_path(@group)
    end

  end

  def show
    @interest= Interest.find(params[:id])
    @group = @interest.group
  end


  def destroy
    @group = Group.find(params[:group_id])
    @interest= Interest.find(params[:id])

    @interest.destroy
    flash[:success] = "Interesse eliminato."
    redirect_to group_path(@group)
  end


  def show_interest (group,user=nil)
    if user==nil
      user=current_user
    end
    interest = user.interests.build(params[:interest])
    interest.group=group
    if interest.user == group.user
      return  1 #no self-interest
    end
    interest.save

  end


  private

  def has_rights_to
    r = Interest.find(params[:id])
    if r.is_banned?
      flash[:notice] = "Sei stato bannato"
      redirect_to group_path(r.group)
    end
    unless current_user?(r.user) || current_user?(r.group.user)
      flash[:notice] = "Azione non consentita"
      redirect_to group_path(r.group)
    end
  end

end
