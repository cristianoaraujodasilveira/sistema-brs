class EmailSector < ActiveRecord::Base
	audited
	
	belongs_to :sector
	validates_presence_of :email, :sector_id
end
