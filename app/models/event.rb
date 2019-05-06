class Event < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :attendances
  has_many :users, through: :attendances
  validates :start_date, inclusion: { in: (Date.today..Date.today+5.years) }, presence: true
  validates :duration, numericality:  { greater_than: 5 }, presence: true
  validates :title, length: { in: 5..140 }, presence: true
  validates :description, length: { in: 20..1000 }, presence: true
  validates :price, numericality: { greater_than: 0, less_than: 1001 }, presence: true
  validates :location, presence: true

end
