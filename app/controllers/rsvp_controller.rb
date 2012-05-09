class RsvpController < ApplicationController
  layout 'welcome'

  def rsvp_verify_form
    @invitation = Invitation.from_hash(params[:id_hash])
    if @invitation
      @title = "Welcome, #{@invitation.guest.name}!"
    else
      flash[:notice] = 'Please check the web address from your mailed invitation and try again'
      redirect_to :root
    end

  end


  def rsvp
    @invitation = Invitation.from_hash(params[:id_hash], params[:passcode])

    if @invitation
      @guest = @invitation.guest
      (@guest.count - @invitation.attendees.count).times { @invitation.attendees.build }
      @title = "Welcome, #{@invitation.guest.name}!"
    else
      flash[:notice] = 'Please enter the passcode found on your mailed invitation'
      redirect_to :rsvp_verify_form
    end
  end

  def rsvp_response
    @invitation = Invitation.from_hash(params[:id_hash])
  end
end
