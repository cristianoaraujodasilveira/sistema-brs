class CalendarEvent < ActiveRecord::Base
	audited

	belongs_to :calendar_event 
	belongs_to :entity_class 
	belongs_to :user 
	belongs_to :calendar_color 
	belongs_to :calendar_type_event 
	belongs_to :state 
	belongs_to :city 
	belongs_to :calendar_repetition 
	has_and_belongs_to_many :weekdays
	has_and_belongs_to_many :users, :validate => false, dependent: :destroy

	has_many :calendar_events, dependent: :destroy

	validates_presence_of :name, :calendar_type_event_id, :initial_date, :user_id

	validates_presence_of :quantity_repetition, if: Proc.new { |calendar_event| calendar_event.repeat == true && (calendar_event.calendar_repetition == nil || calendar_event.calendar_repetition_id != 1 )}
	
	validate :require_at_least_one_weekday

	validate :times

	def times
		if self != nil && self.final_time != nil && self.initial_time && (self.final_time < self.initial_time)
			errors.add(:final_time, " não pode ser menor que tempo inicial.")
		end
	end

	def as_json(options = {})
		{
			:id => self.id,
			:name => get_event_name,
			:color => get_event_color,
			:start => get_initial_date,
			:end => get_final_date,
			:type => "calendar_event",
			:parent_id => self.calendar_event_id
		}
	end

	def get_event_name
		if self.calendar_type_event_id == 1
			return self.name
		else
			return "Evento privado"
		end
	end

	def get_event_color
		if self.user && self.user.calendar_color
			return self.user.calendar_color.code
		else
			return "#FFFFFF"
		end
	end

	def get_initial_date
		if self.initial_date && self.initial_time
			date = self.initial_date
			time = self.initial_time
			return DateTime.new(date.strftime('%Y').to_i, date.strftime('%m').to_i, date.strftime('%d').to_i, time.strftime('%H').to_i, time.strftime('%M').to_i)
		end
	end

	def get_final_date
		if self.initial_date && self.final_time
			date = self.initial_date
			time = self.final_time
			return DateTime.new(date.strftime('%Y').to_i, date.strftime('%m').to_i, date.strftime('%d').to_i, time.strftime('%H').to_i, time.strftime('%M').to_i)
		end
	end

	private

	def require_at_least_one_weekday
		errors.add(:base,"Deve haver ao menos 1 dia selecionado") if self.weekdays.blank? && self.repeat == true && self.calendar_repetition_id != nil && self.calendar_repetition_id == 6 && self.calendar_event_id == nil
	end
end
