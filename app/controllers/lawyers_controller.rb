class LawyersController < ApplicationController

	before_action :register

	def index
		@grid = LawyersGrid.new(params[:lawyers_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Advogados-#{Time.now.to_s}.csv"
			end
		end
	end

	def new
		@lawyer = Lawyer.new
		build_initials_relations
	end

	def build_initials_relations
		if @lawyer.addresses.select{|item| item[:address_type] == 1}.length == 0
			@lawyer.addresses.build(:address_type => 1)
		end
		if @lawyer.addresses.select{|item| item[:address_type] == 2}.length == 0
			@lawyer.addresses.build(:address_type => 2)
		end
		if @lawyer.phones.select{ |item| item[:id] == nil }.length == 0
			@lawyer.phones.build
		end
		if @lawyer.emails.select{ |item| item[:id] == nil }.length == 0
			@lawyer.emails.build
		end
	end

	def build_in_create(params)
		if params[:add_phone]
			@lawyer.phones.build
		elsif params[:add_email]
			@lawyer.emails.build
		end
		build_initials_relations
		render :new
	end

	def create
		@lawyer = Lawyer.new lawyer_params
		if params[:add_phone]
			build_in_create(params)
		elsif params[:add_email]
			build_in_create(params)
		elsif params[:remove_phone] || params[:remove_email]
			build_initials_relations
			render :new
		else
			if @lawyer.save
				audit = @lawyer.audits.last
				audit.comment = "Cadastrou o advogado '"+@lawyer.name+"' de id #"+@lawyer.id.to_s
				audit.save
				gflash :success => "Advogado cadastrado com sucesso"
				redirect_to edit_lawyer_path @lawyer
			else
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@lawyer.errors.full_messages.join('<br>')
				build_initials_relations
				render :new
			end
		end
	end

	def build_in_edit(lawyer_params)
		unless lawyer_params[:addresses_attributes].blank?
			for attribute in lawyer_params[:addresses_attributes]
				@lawyer.addresses.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless lawyer_params[:phones_attributes].blank?
			for attribute in lawyer_params[:phones_attributes]
				@lawyer.phones.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless lawyer_params[:emails_attributes].blank?
			for attribute in lawyer_params[:emails_attributes]
				@lawyer.emails.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
	end

	def edit
		@lawyer = Lawyer.find params[:id]
		build_initials_relations
	end

	def build_in_update(params)
		build_in_edit(lawyer_params)
		if params[:add_phone]
			@lawyer.phones.build
		elsif params[:add_email]
			@lawyer.emails.build
		end
		render :edit
	end

	def update
		@lawyer = Lawyer.find params[:id]
		if params[:add_phone] || params[:add_email]
			build_in_update(params)
		else
			if @lawyer.update lawyer_params
				audit = @lawyer.audits.last
				if audit
					audit.comment = "Editou o advogado de id #"+@lawyer.id.to_s
					audit.save
				else
					audit = Audit.last
					if audit && audit.comment == nil && audit.auditable_type == 'lawyer'
						if audit.action == 'create'
							text = "Criou"
						elsif audit.action == 'update'
							text = "Editou"
						elsif audit.action == 'destroy'
							text = "Apagou"
						end
						audit.comment = text+" o advogado de id #"+audit.auditable_id.to_s
						audit.save
					end
				end
				gflash :success => "Advogado editado com sucesso"
				redirect_to edit_lawyer_path @lawyer
			else
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@lawyer.errors.full_messages.join('<br>')
				build_initials_relations
				render :edit
			end
		end
	end

	def destroy
		lawyer = Lawyer.find params[:id]
		if lawyer 
			lawyer.destroy
			audit = lawyer.audits.last
			audit.comment = "Apagou o advogado '"+lawyer.name+"' de id #"+lawyer.id.to_s
			audit.save
			gflash :success => "Advogado excluído com sucesso"
		end
		redirect_to lawyers_path
	end

	private
	def lawyer_params
		params.require(:lawyer).permit(
			:id,
			:lawyer_type_id,
			:name,
			:office,
			:created_date,
			:cpf,
			:cnpj,
			:oab,
			:municipal_registration,
			:honorary_form_id,
			:honorary_value,
			:state_id,
			:city_id,
			addresses_attributes: [
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
					]
					)
	end
end
