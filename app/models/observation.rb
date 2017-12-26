class Observation < ActiveRecord::Base
	audited
	
	default_scope { order(created_at: :asc) }

	belongs_to :observationtable, :polymorphic => true
	belongs_to :user

	def is_edited?
		if self.created_at != self.updated_at
			return '- Editado em: '+I18n.l(self.updated_at.to_datetime, format: :full)
		end
		return ''
	end
end
