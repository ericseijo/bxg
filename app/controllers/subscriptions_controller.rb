class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @subscriptions = Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  def new
    if params[:try].present?
      create_trial
    else
      @subscription = Subscription.new
      @subscription.user_id = current_user.id
      @plan = Plan.find(params[:plan_id])

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @subscription }
      end
    end
  end

  def edit
    @subscription = Subscription.find(params[:id])
    redirect_to root_path unless @subscription.user == current_user
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user_id = current_user.id
    @subscription.status = 'trial' unless params[:subscription][:status].present?

    if @subscription.save_with_payment_for(current_user)
        current_user.update_attributes(params[:user])
      redirect_to dashboard_path, notice: 'Your subscription is now active.'
    else
      render :new
    end

  end

  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_trial
    # @TODO - check if we want to allow a user to try it twice?

    @subscription = Subscription.new(:plan_id => params[:plan_id])
    @subscription.user_id = current_user.id
    @subscription.status = 'trial'
    if @subscription.save
      UserMailer.new_subscriber(current_user).deliver
      redirect_to dashboard_path, notice: 'Your trial subscription is now active.'
    else
      redirect_to plans_path
    end

  end


end
