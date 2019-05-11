class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user
  after_create :new_user_event #, :email_to_new_register


 def new_user_event
   AttendanceMailer.new_participation_email(self).deliver_now
 end

#  def email_to_new_register
#    EventParticipantMailer.welcome_email_to_event(user).deliver_now

#  end

end
