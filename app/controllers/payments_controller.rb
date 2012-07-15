class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => :destroy

  def index 
    @title = "Payments"
    @payments = Payment.includes(:budget_item).joins(:budget_item).
      order('lower(budget_items.title), paid_on').all
    @total = @payments.map{ |p| p.amount }.sum
  end

  def new
    @title = "New Payment"
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(params[:payment])

    if @payment.save
      flash[:success] = 'Payment saved.'
      redirect_to budget_items_path
    else
      @title = "New Payment"
      render 'new'
    end
  end

  def edit
    @title = "Edit Payment"
    @payment = Payment.find params[:id]
  end

  def update
    @payment = Payment.find params[:id]

    if @payment.update_attributes(params[:payment])
      flash[:success] = 'Payment saved.'
      redirect_to budget_items_path
    else
      @title = 'Edit Payment'
      render 'edit'
    end
  end

  def destroy
    @payment = Payment.find params[:id]
    @payment.destroy
    redirect_to payments_path
  end

end
