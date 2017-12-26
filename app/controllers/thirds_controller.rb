class ThirdsController < ApplicationController

	before_action :register

	def index
		case(params[:type])
		when '1'
			redirect_to index_post_office_path
		when '2'
			redirect_to index_registry_path
		when '3'
			redirect_to index_motoboy_path
		when '5'
			redirect_to index_diligent_path
		when '6'
			redirect_to index_other_path
		else
			redirect_to index_other_path
		end
	end

	def index_diligent
		@grid = ThirdsGrid.new(params[:thirds_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.where(:third_type_id => 5).page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Diligeiros-#{Time.now.to_s}.csv"
			end
		end
	end

	def index_motoboy
		@grid = ThirdsGrid.new(params[:thirds_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.where(:third_type_id => 3).page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Motoboys-#{Time.now.to_s}.csv"
			end
		end
	end

	def index_other
		@grid = ThirdsGrid.new(params[:thirds_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.where(:third_type_id => 6).page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Outros-#{Time.now.to_s}.csv"
			end
		end
	end

	def index_post_office
		@grid = ThirdsGrid.new(params[:thirds_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.where(:third_type_id => 1).page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Correios-#{Time.now.to_s}.csv"
			end
		end
	end

	def index_registry
		@grid = ThirdsGrid.new(params[:thirds_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.where(:third_type_id => 2).page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Cartórios-#{Time.now.to_s}.csv"
			end
		end
	end

	def get_type_third(type)
		case(type)
		when '1', 1 
			@name_to_show = Third.human_attribute_name(:post_offices)
			@path = 'post_office'
		when '2', 2
			@name_to_show = Third.human_attribute_name(:registries)
			@path = 'registry'
		when '3', 3
			@name_to_show = Third.human_attribute_name(:motoboys)
			@path = 'motoboy'
		when '5', 5
			@name_to_show = Third.human_attribute_name(:diligents)
			@path = 'diligent'
		when '6', 6
			@name_to_show = Third.human_attribute_name(:others)
			@path = 'other'
		else
			@name_to_show = Third.human_attribute_name(:others)
			@path = 'other'
		end
		@third_type = type
	end

	def new
		if !params[:type] || params[:type].length == 0
			redirect_to new_third_path(type: 6)
		end
		@third = Third.new
		get_type_third(params[:type])
		build_initials_relations
	end

	def build_initials_relations
		if @third.emails.select{ |item| item[:id] == nil }.length == 0
			@third.emails.build
		end
		if @third.phones.select{ |item| item[:id] == nil }.length == 0
			@third.phones.build
		end
		if !@third.responsible
			@third.build_responsible
		end
		if !@third.address
			@third.build_address
		end
		if @third.attachments.select{ |item| item[:id] == nil }.length == 0
			@third.attachments.build
		end
		if @third.observations.select{ |item| item[:id] == nil }.length == 0
			@third.observations.build
		end
		build_responsible_attributes
	end

	def build_responsible_attributes
		if @third.responsible.phones.select{ |item| item[:id] == nil }.length == 0
			@third.responsible.phones.build
		end
		if @third.responsible.emails.select{ |item| item[:id] == nil }.length == 0
			@third.responsible.emails.build
		end
		if @third.responsible.skypes.select{ |item| item[:id] == nil }.length == 0
			@third.responsible.skypes.build
		end
	end

	def create
		@third = Third.new third_params
		if @third.save
			audit = @third.audits.last
			audit.comment = "Cadastrou o "+get_type_name_third(@third)+" '"+get_name_or_fantasy_name(@third)+"' de id #"+@third.id.to_s
			audit.save
			gflash :success => get_type_name_third(@third)+" cadastrado com sucesso"
			redirect_to edit_third_path @third
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@third.errors.full_messages.join('<br>')
			get_type_third(third_params[:third_type_id])
			build_initials_relations
			render :new
		end
	end

	def build_in_edit(third_params)
		unless third_params[:addresses_attributes].blank?
			for attribute in third_params[:addresses_attributes]
				@third.addresses.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless third_params[:phones_attributes].blank?
			for attribute in third_params[:phones_attributes]
				@third.phones.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless third_params[:emails_attributes].blank?
			for attribute in third_params[:emails_attributes]
				@third.emails.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
	end

	def edit
		@third = Third.find params[:id]
		get_type_third(@third.third_type_id)
		build_initials_relations
	end

	def build_in_update(params)
		build_in_edit(third_params)
		if params[:add_phone]
			@third.phones.build
		elsif params[:add_email]
			@third.emails.build
		end
		render :edit
	end

	def update
		@third = Third.find params[:id]
		if @third.update third_params
			audit = @third.audits.last
			if audit
				audit.comment = "Editou o terceiro de id #"+@third.id.to_s
				audit.save
			else
				audit = Audit.last
				if audit && audit.comment == nil && audit.auditable_type == 'third'
					if audit.action == 'create'
						text = "Criou"
					elsif audit.action == 'update'
						text = "Editou"
					elsif audit.action == 'destroy'
						text = "Apagou"
					end
					audit.comment = text+" o terceiro de id #"+audit.auditable_id.to_s
					audit.save
				end
			end
			gflash :success => get_type_name_third(@third)+" editado com sucesso"
			redirect_to edit_third_path @third
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@third.errors.full_messages.join('<br>')
			get_type_third(third_params[:third_type_id])
			build_initials_relations
			render :edit
		end
	end

	def destroy
		third = Third.find params[:id]
		if third 
			third.destroy
			audit = third.audits.last
			audit.comment = "Apagou o "+get_type_name_third(third)+" '"+get_name_or_fantasy_name(third)+"' de id #"+third.id.to_s
			audit.save
			gflash :success => get_type_name_third(third)+" excluído com sucesso"
		end
		redirect_to thirds_path(type: third.third_type_id)
	end

	def get_type_name_third(third)
		case(third.third_type_id)
		when 1 
			return Third.human_attribute_name(:post_offices)
		when 2
			return Third.human_attribute_name(:registry)
		when 3
			return Third.human_attribute_name(:motoboy)
		when 5
			return Third.human_attribute_name(:diligent)
		when 6
			return Third.human_attribute_name(:other)
		else
			return Third.human_attribute_name(:other)
		end
	end

	def get_name_or_fantasy_name(third)
		if (third.third_type_id == 3 || third.third_type_id == 5 || third.third_type_id == 6) && third.name
			return third.name
		elsif third.fantasy_name
			return third.fantasy_name
		end
		return ''
	end

	def delete_attachment_third
		result = false
		attachment = Attachment.find params[:attachment_id]
		if attachment 
			if attachment.destroy
				result = true
			end
		end
		data = {
			:result => result
		}
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	def delete_observation_third
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a observação '"+observation.observation+"' do terceiro de id #"+observation.observationtable.id.to_s
			audit.save
			gflash :success => "Observação de terceiro excluída com sucesso"
		end
		redirect_to edit_third_path observation.observationtable_id
	end

	def delete_phone_third
		phone = Phone.find params[:format]
		if phone 
			phone.destroy
			audit = phone.audits.last
			audit.comment = "Apagou o telefone '"+phone.phone+"' do terceiro '"+phone.phonetable.name+"' de id #"+phone.phonetable.id.to_s
			audit.save
		end
		redirect_edit_third(phone.phonetable_id)
	end

	def delete_email_third
		email = Email.find params[:format]
		if email 
			email.destroy
			audit = email.audits.last
			audit.comment = "Apagou o email '"+email.email+"' do terceiro '"+email.emailtable.name+"' de id #"+email.emailtable.id.to_s
			audit.save
		end
		redirect_edit_third(email.emailtable_id)
	end

	def delete_skype_third
		skype = Skype.find params[:format]
		if skype 
			skype.destroy
			audit = skype.audits.last
			audit.comment = "Apagou o skype '"+skype.skype+"' do terceiro '"+skype.skypetable.name+"' de id #"+skype.skypetable.id.to_s
			audit.save
		end
		redirect_edit_third(skype.skypetable_id)
	end

	def redirect_edit_third(responsible_id)
		responsible = Responsible.find responsible_id
		third = responsible.responsibletable_id
		redirect_to edit_third_path third
	end

	def by_third_type
		data = Third.where('third_type_id = ?', params[:third_type]).order(:register_number)
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	private
	def third_params
		params.require(:third).permit(
			:id,
			:register_number,
			:name,
			:fantasy_name,
			:social_name,
			:cpf,
			:rg,
			:diligent_profile_id,
			:third_type_id,
			:cnpj,
			:phone,
			address_attributes: [
				:id,
				:zipcode,
				:address,
				:district,
				:number,
				:complement,
				:address_type,
				:state_id,
				:city_id
				],
				phones_attributes:[
					:id,
					:phone,
					:phone_type,
					:_destroy
					],
					emails_attributes:[
						:id,
						:email,
						:email_type,
						:_destroy
						], 
						attachments_attributes: [
							:id,
							:attachment,
							:attachment_type
							],
							observations_attributes:[
								:id,
								:user_id,
								:observation,
								:observation_type,
								:_destroy
								],
								responsible_attributes: [
									:id,
									:_destroy,
									:name,
									:office,
									:department,
									:phone,
									:email,
									:skype,
									:whatsapp,
									:type,
									:site,
									phones_attributes: [
										:_destroy,
										:id,
										:phone
										],
										emails_attributes: [
											:_destroy,
											:id,
											:email
											],
											skypes_attributes: [
												:_destroy,
												:id,
												:skype
											]
											],
											)
	end
end
