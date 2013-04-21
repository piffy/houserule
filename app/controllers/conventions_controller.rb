class ConventionsController < ApplicationController
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
    @convention = Convention.new

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
    @convention = Convention.new(params[:convention])

    respond_to do |format|
      if @convention.save
        format.html { redirect_to @convention, notice: 'Convention was successfully created.' }
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
        format.html { redirect_to @convention, notice: 'Convention was successfully updated.' }
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
end
