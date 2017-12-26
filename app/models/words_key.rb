class WordsKey < ActiveRecord::Base
	audited
	default_scope { order("word ASC") }
	belongs_to :client_segment
	belongs_to :library

end
