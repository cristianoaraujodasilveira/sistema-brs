class Sphere < ActiveRecord::Base
	has_many :organs
	validates_presence_of :name
end
