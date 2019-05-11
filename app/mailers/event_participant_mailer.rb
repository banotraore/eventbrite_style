class EventParticipantMailer < ApplicationMailer

  def welcome_email_to_event(attendance)
    @attendance = attendance
    @event = @attendance.event
    @admin = @attendance.event.admin
    @participant = @attendance.user

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @participant.email, subject: "Tom inscription a l'event #{@event.id} est bien confirmée")
  end

end
