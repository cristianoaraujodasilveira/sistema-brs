class PhoneSector < ActiveRecord::Base
	audited
	
	belongs_to :sector
	validates_presence_of :phone, :extension, :sector_id
end
