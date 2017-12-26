class Scale < ActiveRecord::Base
	has_many :visits_reports
	validates_presence_of :name
end
