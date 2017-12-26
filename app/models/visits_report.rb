class VisitsReport < ActiveRecord::Base
	audited

	belongs_to :client
	belongs_to :scale
	belongs_to :user
	belongs_to :state
	belongs_to :city
	belongs_to :visits_report_size

	validates_presence_of :user_id, 
	:date_and_time,
	:scale_id,
	:email,
	:cnpj,
	:zipcode,
	:address,
	:district,
	:number,
	:state_id,
	:city_id,
	:fantasy_name,
	:proposal_text,
	:responsible_name

	def as_json(options = {})
		{
			:id => self.id,
			:name => self.subject,
			:start => date_and_time,
			:type => "visit",
			:color => get_visit_color,
			:social_name => self.social_name,
			:fantasy_name => self.fantasy_name,
			:cnpj => self.cnpj
		}
	end

	def get_visit_color
		if self.user && self.user.calendar_color
			return self.user.calendar_color.code
		else
			return "#FFFFFF"
		end
	end

	# Mensagens de notificações
	def self.notification_new_visits_report(visit_report, user)
		return 'Relatório de visita <b>'+visit_report.social_name+'</b> cadastrado por <b>'+user.name+'</b>'
	end

	def self.notification_edit_visits_report(visit_report, user)
		return 'Relatório de visita <b>'+visit_report.social_name+'</b> editado por <b>'+user.name+'</b>'
	end

	def self.notification_delete_visits_report(visit_report, user)
		return 'Relatório de visita <b>'+visit_report.social_name+'</b> removido por <b>'+user.name+'</b>'
	end

end
