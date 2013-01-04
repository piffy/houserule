class ReputationsController < ApplicationController
  before_filter :logged_in_user, except: [:index, :show]
  before_filter  :admin_only, except: [:index, :show, :create]
  before_filter  :correct_user, only: [:create]

  def admin_only
    unless current_user.admin?
      flash[:notice] = "Azione non consentita"
      redirect_to(root_path)
    end
  end


  # GET /reputations
  # GET /reputations.json
  def index
    @reputations = Reputation.order(:positive_fb).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reputations }
    end
  end

  # GET /reputations/1
  # GET /reputations/1.json
  def show
    @reputation = Reputation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reputation }
    end
  end

  # GET /reputations/new
  # GET /reputations/new.json
  def new
    @reputation = Reputation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reputation }
    end
  end

  # GET /reputations/1/edit
  def edit
    @reputation = Reputation.find(params[:id])
  end

  # POST /reputations
  # POST /reputations.json
  def create
    redirect_to @user, notice: 'Sistema di reputazione non ancora attivo.'
    return
    @user= User.find(params[:id])

    @reputation = Reputation.new
    @reputation.user_id=@user.id
    if @user.reputation.nil?
      msg = "Reputazione attivato in precedenza"
    else
      msg = "Impossibile attivare il sistema di reputazione"
    end
    respond_to do |format|
      if @user.reputation.nil? && @reputation.save
        format.html { redirect_to @user, notice: 'Sistema di reputazione attivato.' }
        format.json { render json: @reputation, status: :created, location: @user }
      else
        format.html { redirect_to @user,notice: msg }
        format.json { render json: @reputation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reputations/1
  # PUT /reputations/1.json
  def update
    @reputation = Reputation.find(params[:id])

    respond_to do |format|
      if @reputation.update_attributes(params[:reputation])
        format.html { redirect_to @reputation, notice: 'Reputation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reputation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reputations/1
  # DELETE /reputations/1.json
  def destroy
    @reputation = Reputation.find(params[:id])
    @reputation.destroy

    respond_to do |format|
      format.html { redirect_to reputations_url }
      format.json { head :no_content }
    end
  end
end
