class AttendeesController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => :update

  # GET /attendees
  # GET /attendees.json
  def index
    @attendees = Attendee.order(:id)

    @total_invited = Invitation.joins(:guest).sum('guests.count')
    @attending = @attendees.size
    @not_attending = Invitation.where(:attending => false).where('invitations.created_at <> invitations.updated_at').joins(:guest).sum('guests.count').to_i
    @percent_reporting = ((1.0 * (@attending.to_i + @not_attending.to_i) / @total_invited.to_i) * 100).round

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attendee }
      format.csv do
        attendee_csv = CSV.generate do |csv|
          csv << [ 'Name', 'Table Number' ]

          Attendee.guests_by_table.each do |table_hash|
            table_hash[1].each do |name|
              csv << [ name, table_hash[0] ]
            end
          end
        end
        send_data(attendee_csv, :type => 'text/csv', :filename => 'attendee_list.csv')
      end
    end
  end

  # GET /attendees/1
  # GET /attendees/1.json
  def show
    @attendee = Attendee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attendee }
    end
  end

  # GET /attendees/new
  # GET /attendees/new.json
  def new
    @attendee = Attendee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attendee }
    end
  end

  # GET /attendees/1/edit
  def edit
    @attendee = Attendee.find(params[:id])
  end

  # POST /attendees
  # POST /attendees.json
  def create
    @attendee = Attendee.new(params[:attendee])

    respond_to do |format|
      if @attendee.save
        format.html { redirect_to attendees_path, flash: { success: "#{@attendee.name} was successfully created." } }
        format.json { render json: @attendee, status: :created, location: @attendee }
      else
        format.html { render action: "new" }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attendees/1
  # PUT /attendees/1.json
  def update
    @attendee = Attendee.find(params[:id])

    respond_to do |format|
      if @attendee.update_attributes(params[:attendee])
        format.html { redirect_to @attendee, flash: { success: "#{@attendee.name} was successfully updated." } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendees/1
  # DELETE /attendees/1.json
  def destroy
    @attendee = Attendee.find(params[:id])
    @attendee.destroy

    respond_to do |format|
      format.html { redirect_to attendees_url }
      format.json { head :no_content }
    end
  end

  def seating_chart
    table_numbers = Attendee.select('distinct table_number').order(:table_number).map(&:table_number)
    @attendees_by_table = {}
    table_numbers.each do |table_number| 
      @attendees_by_table[table_number] = Attendee.where(table_number: table_number).order(:id)
    end
  end

  def table_stats
    @table_and_meal_counts = Attendee.group(:table_number, :meal_id).order(:table_number, :meal_id).count
    @meals_by_invitation_by_table =  Attendee.group(:table_number, :invitation_id, :meal_id).order(:table_number, :invitation_id, :meal_id).count
  end
end
