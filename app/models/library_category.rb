class LibraryCategory < ActiveRecord::Base
	audited

	validates_presence_of :name
end
