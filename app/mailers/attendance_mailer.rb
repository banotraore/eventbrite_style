class AttendanceMailer < ApplicationMailer
  default from: 'no-reply@monsite.fr'

  def new_participation_email(attendance)
    @attendance = attendance
    @event = @attendance.event
    @admin = @attendance.event.admin
    @participant = @attendance.user

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @admin.email, subject: "1 nouvelle personne s'est inscrite à l'évènement !")
  end
end
