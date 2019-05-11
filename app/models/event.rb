class Event < ApplicationRecord
  has_many :attendances, dependent: :destroy
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id', dependent: :destroy
  has_many :users, through: :attendances
  validates :start_date, presence: true
  validate :is_start_date_correct?
  validates :duration, presence: true
  validate :is_duration_correct?
  validates :title, length: { in: 5..140 }, presence: true
  validates :description, length: { in: 20..1000 }, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than: 1001 }, presence: true
  validates :location, presence: true

  # To calculate the end date
  def end_date
    start_date + (duration * 60)
  end

  # To check if the duration is correct
  def is_duration_correct?
    if duration <= 0 || (duration % 5) != 0
      errors.add(:duration, " must be a multiple of 5 and can't be blank")
    end
  end

  # To check if the duration is correct
  def is_start_date_correct?
    if start_date < Date.today || start_date > Date.today + 5.years
      errors.add(:start_date, " must be between the next 30 minutes : #{(Time.now + 30.minutes).strftime '%H:%M'} and before : #{Date.today + 5.years}")
    end
  end

  def is_free?
    price == 0
  end

  
end
