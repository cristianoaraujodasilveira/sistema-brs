class EntityClass < ActiveRecord::Base
	audited

	belongs_to :state
	belongs_to :city
	
	has_many :entity_class_responsibles, dependent: :destroy
	accepts_nested_attributes_for :entity_class_responsibles, allow_destroy: true

	validates_presence_of :name

	def get_complete_address
		text = ""
		if self.address != nil
			text += self.address+', '
		end
		if self.number != nil
			text += self.number+', '
		end
		if self.district != nil
			text += self.district+', '
		end
		if self.complement != nil
			text += self.complement+', '
		end
		if self.zipcode != nil
			text += self.zipcode+', '
		end
		if self.city != nil
			text += self.city.name+', '
		end
		if self.state != nil
			text += self.state.name
		end
		return text
	end

	def get_responsibles
		text = ""
		if self.entity_class_responsibles && self.entity_class_responsibles.length > 0
			self.entity_class_responsibles.each do |ecr|
				text += ecr.name + ", "
			end
		end
		return text
	end

	# Mensagens de notificações
	def self.notification_new_entity_class(entity_class, user)
		return 'Entidade de classe <b>'+entity_class.name+'</b> cadastrada por <b>'+user.name+'</b>'
	end

	def self.notification_edit_entity_class(entity_class, user)
		return 'Entidade de classe <b>'+entity_class.name+'</b> editada por <b>'+user.name+'</b>'
	end

	def self.notification_delete_entity_class(entity_class, user)
		return 'Entidade de classe <b>'+entity_class.name+'</b> removida por <b>'+user.name+'</b>'
	end
end
