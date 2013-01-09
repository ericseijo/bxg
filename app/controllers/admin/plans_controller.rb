class Admin::PlansController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin


  def index
    @plans = Plan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  # GET /Plans/1
  # GET /Plans/1.json
  def show
    @subscription = Plan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /Plans/new
  # GET /Plans/new.json
  def new
    @subscription = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /Plans/1/edit
  def edit
    @subscription = Plan.find(params[:id])
  end

  # POST /Plans
  # POST /Plans.json
  def create
    @subscription = Plan.new(params[:plan])

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to admin_plan_path(@subscription), notice: 'Plan was successfully created.' }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Plans/1
  # PUT /Plans/1.json
  def update
    @subscription = Plan.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:plan])
        format.html { redirect_to admin_plan_path(@subscription), notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Plans/1
  # DELETE /Plans/1.json
  def destroy
    @subscription = Plan.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to admin_plans_url }
      format.json { head :no_content }
    end
  end
end
