class ConventionsController < ApplicationController
  before_filter :logged_in_user
  # GET /conventions
  # GET /conventions.json
  def index
    @conventions = Convention.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conventions }
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



end
