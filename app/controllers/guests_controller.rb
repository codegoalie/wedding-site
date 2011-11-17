class GuestsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @title = "Guest List"
    @guests = Guest.order('name')
    @total_guests = Guest.sum(:count)
    @guest_count = Guest.count
  end

  def new
    @title = "Add New Guest"
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(params[:guest])
    if @guest.save
      redirect_to @guest, :notice => "Guest was successfully added."
    else
      render :action => :new
    end
  end

  def show
    @guest = Guest.find params[:id]
    @title = @guest.name
  end

  def edit
    @guest = Guest.find params[:id]
    @title = "Edit #{@guest.name}"
  end

  def update
    @guest = Guest.find params[:id]
    if @guest.update_attributes(params[:guest])
      redirect_to @guest, :notice => "Guest was successfully updated."
    else
      render :action => :edit
    end
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy

    redirect_to guests_path
  end

end
