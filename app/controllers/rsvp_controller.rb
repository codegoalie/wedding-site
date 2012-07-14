class RsvpController < ApplicationController
  layout 'welcome'

  before_filter :downcase_id_hash

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
    will_come = params[:will_come] == 'yes'

    if will_come
      params[:names].each_with_index do |n, i|
        @invitation.attendees << Attendee.new(:name => params['names'][i.to_s], :meal_id => params['meals'][i.to_s]) unless params['names'][i.to_s].blank?
      end
    end

    @invitation.attending = will_come

    if @invitation.save
      RsvpMailer.rsvped(@invitation).deliver
      @title = 'Thank you for RSVPing!!!'
    else
      @guest = @invitation.guest
      (@guest.count - @invitation.attendees.count).times { @invitation.attendees.build }
      @title = "Welcome, #{@invitation.guest.name}!"
      render :rsvp
    end
  end

 #def response_test
 #  @invitation = Invitation.from_hash(params[:id_hash])
 #  @invitation.attending = false
 #  @title = 'Thank you for RSVPing!!!'

 #  render 'rsvp_response'
 #end

 private 

 def downcase_id_hash
   params[:id_hash] = params[:id_hash].downcase if params[:id_hash]
   puts params[:id_hash]
 end
end

