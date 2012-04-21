class RsvpController < ApplicationController
  layout 'welcome'

  def rsvp_verify_form
    @invitation = Invitation.from_hash(params[:id_hash])
    @title = "Welcome, #{@invitation.guest.name}!"
  end


  def rsvp
    @invitation = Invitation.from_hash(params[:id_hash], params[:passcode])

    if @invitation
      @title = "Welcome, #{@invitation.guest.name}!"
    else
      flash[:notice] = 'Please enter the passcode found on your mailed invitation'
      redirect_to :rsvp_verify_form
    end
  end
end
