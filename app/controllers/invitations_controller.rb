class InvitationsController < ApplicationController
  layout 'invitation_inserts', :only => [ :inserts ]
  before_filter :authenticate_user!
  # GET /invitations
  # GET /invitations.json
  def index
    @title = 'Invitations'
    @invitations = Invitation.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @invitations }
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation = Invitation.find(params[:id])
    @title = @invitation.guest.name

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/new
  # GET /invitations/new.json
  def new
    @title = 'New Invitation'
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/1/edit
  def edit
    @invitation = Invitation.find(params[:id])
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(params[:invitation])
    @title = "Editing #{@invitation.guest.name}"

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, success: 'Invitation was successfully created.' }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "new" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        format.html { redirect_to @invitation, success: 'Invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to invitations_url }
      format.json { head :no_content }
    end
  end

  def choose
    @title = "Populate Invitations"
    @guests = Guest.all(:include => :invitation, :conditions => ["invitations.id is null"])
  end

  def populate
    created = 0
    params[:guests].each do |guest_id, i|
      created += 1 if Invitation.create(:guest_id => guest_id)
    end
    flash[:success] = "Successfully created #{created} invitations."
    redirect_to choose_invitations_path
  end

  def inserts
    @invitations = Invitation.all
  end

end
