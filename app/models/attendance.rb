class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user
  after_create :new_user_event


  def new_user_event
    AttendanceMailer.new_participation_email(self).deliver_now
  end

end
