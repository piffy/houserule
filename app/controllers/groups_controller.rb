class GroupsController < ApplicationController
  include GroupsHelper
  before_filter :logged_in_user, only: [:create, :destroy, :new, :edit, :update, :create]
  before_filter :has_rights_to,   only: [:edit, :update, :destroy]
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @interested=already_interested?(current_user,@group)
    if @interested && @interested.is_banned?
      flash.now[:notice]="Sei stato bandito da questo gruppo"
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
    @location_list = (Group.all(:select => "location")+User.all(:select => "Location")+Event.all(:select => "Location")).map(&:location).delete_if {|x| x == nil || x == ""}



    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    @location_list = (Group.all(:select => "location")+User.all(:select => "Location")+Event.all(:select => "Location")).map(&:location).delete_if {|x| x == nil || x == ""}

  end

  # POST /groups
  # POST /groups.json
  def create
    params[:group].delete("user_id")
    @group = current_user.groups.build(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Gruppo creato.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Gruppo modificato.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  def has_rights_to
    @group = Group.find(params[:id])
    unless current_user?(@group.user) || current_user.admin?
      flash[:notice] = "Azione non consentita"
      redirect_to group_path(@group)
    end
  end



end
