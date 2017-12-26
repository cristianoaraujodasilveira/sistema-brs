class OfficialDiariesController < ApplicationController

	before_action :register
	
	def index
		@grid_official_diaries = OfficialDiariesGrid.new(params[:official_diaries_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def new
		@official_diary = OfficialDiary.new
		build_official_diaries
	end

	def edit
		@official_diary = OfficialDiary.find params[:id]
		build_official_diaries
	end

	def build_official_diaries
		if !@official_diary.address
			@official_diary.build_address
		end
		if @official_diary.responsibles.length == 0
			@official_diary.responsibles.build
		end
		@official_diary.observations.build
		build_official_diaries_attributes
	end

	def build_official_diaries_attributes
		@official_diary.responsibles.each do |responsible|
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
		@official_diary = OfficialDiary.new(official_diary_params)
		@official_diary.user_id = @current_user.id
		if params[:add_responsible]
		    # add empty responsible associated with @official_diary
		    @official_diary.responsibles.build
		    build_official_diaries
		    render :new
		else
			# save goes like usual
			if @official_diary.save
				@official_diary.update_attribute(:user_id, @current_user.id)
				audit = @official_diary.audits.last
				audit.comment = "Criou o diário oficial '"+@official_diary.name+"' de id #"+@official_diary.id.to_s
				audit.save
				gflash :success => "Diário Oficial cadastrado com sucesso"
				redirect_to edit_official_diary_path @official_diary
			else
				build_official_diaries
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@official_diary.errors.full_messages.join('<br>')
				render :new
			end
		end
	end

	def build_in_edit(official_diary_params)
		unless official_diary_params[:responsibles_attributes].blank?
			for attribute in official_diary_params[:responsibles_attributes]
				@official_diary.responsibles.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
	end

	def update
		@official_diary = OfficialDiary.find(params[:id])

		if params[:add_responsible]
			build_in_edit(official_diary_params)
	      	# add one more empty responsible attribute
	      	@official_diary.responsibles.build
	      	build_official_diaries
	      	render :edit
	      else
	        # save goes like usual
	        if @official_diary.update_attributes official_diary_params
	        	audit = @official_diary.audits.last
	        	if audit
	        		audit.comment = "Editou o diário oficial '"+@official_diary.name+"' de id #"+@official_diary.id.to_s
	        		audit.save
	        	else
	        		audit = Audit.last
	        		if audit && audit.comment == nil && audit.auditable_type == 'official_diary'
	        			if audit.action == 'create'
	        				text = "Criou"
	        			elsif audit.action == 'update'
	        				text = "Editou"
	        			elsif audit.action == 'destroy'
	        				text = "Apagou"
	        			end
	        			audit.comment = text+" o diário oficial de id #"+audit.auditable_id.to_s
	        			audit.save
	        		end
	        	end
	        	gflash :success => "Diário Oficial editado com sucesso"
	        	redirect_to edit_official_diary_path @official_diary
	        else
	        	build_official_diaries
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@official_diary.errors.full_messages.join('<br>')
	        	render :edit
	        end
	    end
	end

	def destroy
		official_diary = OfficialDiary.find params[:id]
		if official_diary 
			official_diary.destroy
			audit = official_diary.audits.last
			audit.comment = "Apagou o diário oficial '"+official_diary.name+"' de id #"+official_diary.id.to_s
			audit.save
			gflash :success => "Diário Oficial excluído com sucesso"
		end
		redirect_to official_diaries_path
	end

	def delete_observation_official_diary
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a observação '"+observation.observation+"' do diário oficial '"+observation.observationtable.name+"' de id #"+observation.observationtable.id.to_s
			audit.save
			gflash :success => "Observação excluída com sucesso"
		end
		redirect_to edit_official_diary_path observation.observationtable_id
	end

	def delete_phone_official_diary
		phone = Phone.find params[:format]
		if phone 
			phone.destroy
			audit = phone.audits.last
			audit.comment = "Apagou o telefone '"+phone.phone+"' do diário oficial '"+phone.phonetable.name+"' de id #"+phone.phonetable.id.to_s
			audit.save
		end
		redirect_edit_official_diary(phone.phonetable_id)
	end

	def delete_email_official_diary
		email = Email.find params[:format]
		if email 
			email.destroy
			audit = email.audits.last
			audit.comment = "Apagou o email '"+email.email+"' do diário oficial '"+email.emailtable.name+"' de id #"+email.emailtable.id.to_s
			audit.save
		end
		redirect_edit_official_diary(email.emailtable_id)
	end

	def delete_skype_official_diary
		skype = Skype.find params[:format]
		if skype 
			skype.destroy
			audit = skype.audits.last
			audit.comment = "Apagou o skype '"+skype.skype+"' do diário oficial '"+skype.skypetable.name+"' de id #"+skype.skypetable.id.to_s
			audit.save
		end
		redirect_edit_official_diary(skype.skypetable_id)
	end

	def redirect_edit_official_diary(responsible_id)
		responsible = Responsible.find responsible_id
		official_diary = responsible.responsibletable_id
		redirect_to edit_official_diary_path official_diary
	end

	private
	def official_diary_params
		params.require(:official_diary).permit(
			:id,
			:user_id,
			:sphere_id,
			:name,
			:social_name,
			:cnpj,
			:phone_brs,
			:email_brs,
			:site,
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
