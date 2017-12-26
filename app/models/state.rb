class State < ActiveRecord::Base
	validates_presence_of :name, :acronym
	has_many :cities
	has_many :users
	has_many :organs
	has_many :visits_reports
end
