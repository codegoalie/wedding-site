class RsvpMailer < ActionMailer::Base
  def rsvped(invitation)
    @invitation = invitation
    @total_invited = Invitation.joins(:guest).sum('guests.count')
    @attending = Attendee.count
    @not_attending = Invitation.where(:attending => false).where('invitations.created_at <> invitations.updated_at').joins(:guest).sum('guests.count').to_i
    @percent_reporting = (1.0 * (@attending.to_i + @not_attending.to_i) / @total_invited.to_i).round(4) * 100

    mail(:to => User.all.map(&:email).join(','),
         :from => 'rsvp@crayley.com',
         :subject => "#{@invitation.guest.full_friendly_name} has RSVPed: #{@invitation.attending ? 'YES' : 'NO'}")

  end
end

