class City < ActiveRecord::Base
  belongs_to :state
  has_many :users
  has_many :organs
  has_many :visits_reports
  validates_presence_of :name, :state_id
end
