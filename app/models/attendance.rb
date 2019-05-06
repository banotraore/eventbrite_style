class Attendance < ApplicationRecord
  after_create :new_user_event

  def new_user_event
    AttendanceMailer.new_participation_email(self).deliver_now
  end
  belongs_to :user
  belongs_to :event
end
