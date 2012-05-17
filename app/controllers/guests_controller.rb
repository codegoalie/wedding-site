require 'csv'

class GuestsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @title = "Guest List"
    @guests = Guest.order('name')
    @total_guests = Guest.sum(:count)
    @guest_count = Guest.count
    respond_to do |format|
      format.html
      format.csv do
        guest_csv = CSV.generate do |csv|
          csv << [ 'Name', 'Friendly Name', 'Address', 'City', 'State', 'Zip' ]

          @guests.each do |g|
            csv << [ g.name, g.full_friendly_name, g.address, g.city, g.state, g.zip ]
          end
        end
        send_data(guest_csv, :type => 'text/csv', :filename => 'guest_list.csv')
      end
      format.json { render :json => @guests }
    end
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

  private
    def render_xls(guests)
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet(name: 'Guest List')
      sheet1.row(0).concat %w(Name Address City State Zip Count)
      guests.each_with_index do |guest, i|
        sheet1.row(i+1).push guest.name, guest.address, guest.city, guest.state, guest.zip,
          guest.count
      end

      blob = StringIO.new('')
      book.write(blob)
      blob.string
    end
end
