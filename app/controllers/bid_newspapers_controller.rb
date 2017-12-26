class BidNewspapersController < ApplicationController

	before_action :register
	
	def index
		@grid_bid_newspapers = BidNewspapersGrid.new(params[:bid_newspapers_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def new
		@bid_newspaper = BidNewspaper.new
		build_bid_newspapers
	end

	def edit
		@bid_newspaper = BidNewspaper.find params[:id]
		build_bid_newspapers
	end

	def build_bid_newspapers
		if !@bid_newspaper.address
			@bid_newspaper.build_address
		end
		if @bid_newspaper.responsibles.length == 0
			@bid_newspaper.responsibles.build
		end
		@bid_newspaper.observations.build
		build_bid_newspapers_attributes
	end

	def build_bid_newspapers_attributes
		@bid_newspaper.responsibles.each do |responsible|
			if responsible.phones.length == 0
				responsible.phones.build
			end
			if responsible.emails.length == 0
				responsible.emails.build
			end
			if responsible.skypes.length == 0
				responsible.skypes.build
			end
		end
	end

	def create
		@bid_newspaper = BidNewspaper.new(bid_newspaper_params)
		@bid_newspaper.user_id = @current_user.id
		if params[:add_responsible]
		    # add empty responsible associated with @bid_newspaper
		    @bid_newspaper.responsibles.build
		    build_bid_newspapers
		    render :new
		else
			# save goes like usual
			if @bid_newspaper.save
				@bid_newspaper.update_attribute(:user_id, @current_user.id)
				audit = @bid_newspaper.audits.last
				audit.comment = "Criou o jornal de licitação '"+@bid_newspaper.name+"' de id #"+@bid_newspaper.id.to_s
				audit.save
				gflash :success => "Jornal de Licitação cadastrado com sucesso"
				redirect_to edit_bid_newspaper_path @bid_newspaper
			else
				build_bid_newspapers
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@bid_newspaper.errors.full_messages.join('<br>')
				render :new
			end
		end
	end

	def build_in_edit(bid_newspaper_params)
		unless bid_newspaper_params[:responsibles_attributes].blank?
			for attribute in bid_newspaper_params[:responsibles_attributes]
				@bid_newspaper.responsibles.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
	end

	def update
		@bid_newspaper = BidNewspaper.find(params[:id])

		if params[:add_responsible]
			build_in_edit(bid_newspaper_params)
	      	# add one more empty responsible attribute
	      	@bid_newspaper.responsibles.build
	      	build_bid_newspapers
	      	render :edit
	      else
	        # save goes like usual
	        if @bid_newspaper.update_attributes bid_newspaper_params
	        	audit = @bid_newspaper.audits.last
	        	if audit
	        		audit.comment = "Editou o jornal de licitação '"+@bid_newspaper.name+"' de id #"+@bid_newspaper.id.to_s
	        		audit.save
	        	else
	        		audit = Audit.last
	        		if audit && audit.comment == nil && audit.auditable_type == 'bid_newspaper'
	        			if audit.action == 'create'
	        				text = "Criou"
	        			elsif audit.action == 'update'
	        				text = "Editou"
	        			elsif audit.action == 'destroy'
	        				text = "Apagou"
	        			end
	        			audit.comment = text+" o jornal de licitação de id #"+audit.auditable_id.to_s
	        			audit.save
	        		end
	        	end
	        	gflash :success => "Jornal de Licitação editado com sucesso"
	        	redirect_to edit_bid_newspaper_path @bid_newspaper
	        else
	        	build_bid_newspapers
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@bid_newspaper.errors.full_messages.join('<br>')
	        	render :edit
	        end
	    end
	end

	def destroy
		bid_newspaper = BidNewspaper.find params[:id]
		if bid_newspaper 
			bid_newspaper.destroy
			audit = bid_newspaper.audits.last
			audit.comment = "Apagou o jornal de licitação '"+bid_newspaper.name+"' de id #"+bid_newspaper.id.to_s
			audit.save
			gflash :success => "Jornal de Licitação excluído com sucesso"
		end
		redirect_to bid_newspapers_path
	end

	def delete_observation_bid_newspaper
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a observação '"+observation.observation+"' do jornal de licitação '"+observation.observationtable.name+"' de id #"+observation.observationtable.id.to_s
			audit.save
			gflash :success => "Observação excluída com sucesso"
		end
		redirect_to edit_bid_newspaper_path observation.observationtable_id
	end

	def delete_phone_bid_newspaper
		phone = Phone.find params[:format]
		if phone 
			phone.destroy
			audit = phone.audits.last
			audit.comment = "Apagou o telefone '"+phone.phone+"' do jornal de licitação '"+phone.phonetable.name+"' de id #"+phone.phonetable.id.to_s
			audit.save
		end
		redirect_edit_bid_newspaper(phone.phonetable_id)
	end

	def delete_email_bid_newspaper
		email = Email.find params[:format]
		if email 
			email.destroy
			audit = email.audits.last
			audit.comment = "Apagou o email '"+email.email+"' do jornal de licitação '"+email.emailtable.name+"' de id #"+email.emailtable.id.to_s
			audit.save
		end
		redirect_edit_bid_newspaper(email.emailtable_id)
	end

	def delete_skype_bid_newspaper
		skype = Skype.find params[:format]
		if skype 
			skype.destroy
			audit = skype.audits.last
			audit.comment = "Apagou o skype '"+skype.skype+"' do jornal de licitação '"+skype.skypetable.name+"' de id #"+skype.skypetable.id.to_s
			audit.save
		end
		redirect_edit_bid_newspaper(skype.skypetable_id)
	end

	def redirect_edit_bid_newspaper(responsible_id)
		responsible = Responsible.find responsible_id
		bid_newspaper = responsible.responsibletable_id
		redirect_to edit_bid_newspaper_path bid_newspaper
	end

	private
	def bid_newspaper_params
		params.require(:bid_newspaper).permit(
			:id,
			:user_id,
			:client_id,
			:name,
			:initial_date,
			:final_date,
			:site,
			:phone_brs,
			:email_brs,
			:social_name,
			:cnpj,
			responsibles_attributes: [
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
						address_attributes: [
							:id,
							:zipcode,
							:address,
							:district,
							:number, 
							:complement,
							:type,
							:state_id,
							:city_id
							],
							observations_attributes: [
								:id, 
								:user_id,
								:_destroy,
								:observation
							]
							)
	end
end
