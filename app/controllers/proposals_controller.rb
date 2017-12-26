class ProposalsController < ApplicationController

	before_action :commercial

	def index
		@proposal = ProposalsGrid.new(params[:proposals_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def new
		@proposal = Proposal.new
		build_proposals
	end

	def edit
		@proposal = Proposal.find params[:id]
		build_proposals
	end

	def proposals_historic
		@proposal = Proposal.includes(:proposal_historics).includes(proposal_historics: :user).where(:id => params[:id]).first
		if @proposal
			@proposal.proposal_historics.build
		end
	end

	def build_proposals
		if @proposal.monthly_values == nil || @proposal.monthly_values.length == 0
			@proposal.monthly_values.build
		end
		if @proposal.upload_proposals == nil || @proposal.upload_proposals.length == 0
			@proposal.upload_proposals.build
		end
	end

	def create
		@proposal = Proposal.new(proposal_params)
		if params[:add_monthly_value]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    @proposal.monthly_values.build
		    render :new
		elsif params[:add_upload_proposal]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    @proposal.upload_proposals.build
		    render :new
		elsif params[:remove_data]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    render :new
		else
	        # save goes like usual
	        if @proposal.save
	        	audit = @proposal.audits.last
	        	audit.comment = "Criou a Proposta '"+@proposal.visits_report.proposal_text+"' de id #"+@proposal.id.to_s
	        	audit.save
	        	gflash :success => "Proposta cadastrada com sucesso"
	        	generate_notification('create')
	        	redirect_to proposals_path
	        else
	        	build_proposals
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@proposal.errors.full_messages.join('<br>')
	        	render :new
	        end
	    end
	end

	def update
		@proposal = Proposal.find(params[:id])	
		if params[:add_monthly_value]
			unless proposal_params[:monthly_values_attributes].blank?
				for attribute in proposal_params[:monthly_values_attributes]
					@proposal.monthly_values.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
				end
			end
	      	# add one more empty sector attribute
	      	@proposal.monthly_values.build
	      	render :edit
	      elsif params[:add_upload_proposal]
	      	unless proposal_params[:upload_proposals_attributes].blank?
	      		for attribute in proposal_params[:upload_proposals_attributes]
	      			@proposal.upload_proposals.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	      		end
	      	end
	      	@proposal.save
	      	# add one more empty sector attribute
	      	@proposal.upload_proposals.build
	      	render :edit
	      elsif params[:remove_data]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    render :edit
		else
			if params[:add_comment_to_notes]
				@proposal.skip_validate = true
			end
	        # save goes like usual
	        if @proposal.update_attributes proposal_params
	        	audit = @proposal.audits.last
	        	generate_notification('update')
	        	if params[:add_comment_to_notes]
	        		gflash :success => "Comentário salvo com sucesso"
	        		redirect_to proposals_historic_path @proposal
	        	else
	        		gflash :success => "Proposta editada com sucesso"	        		
	        		redirect_to edit_proposal_path @proposal
	        	end
	        else
	        	build_proposals
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@proposal.errors.full_messages.join('<br>')
	        	render :edit
	        end
	    end
	end

	def destroy
		@proposal = Proposal.find params[:id]
		if @proposal 
			if @proposal.clients.length > 0
				gflash :now, :error => "Não foi possível remover. Existem clientes vinculados a essa proposta."
			else
				@proposal.destroy
				audit = @proposal.audits.last
				text = ""
				if @proposal.visits_report && @proposal.visits_report.proposal_text
					text = @proposal.visits_report.proposal_text
				elsif @proposal.title != nil
					text = @proposal.title
				end
				audit.comment = "Apagou a proposta '"+text+"' de id #"+@proposal.id.to_s
				audit.save
				generate_notification('destroy')
				gflash :success => "Proposta excluída com sucesso"
			end
		end
		redirect_to proposals_path
	end

	def get_proposals_values_to_graphic
		situations = Situation.all
		values = Array.new;
		situations.each do |si|
			proposals = Proposals.where(:situation_id => si.id).count
			data = {
				:name => si.name,
				:y => proposals
			}
			values.push(data)
		end
		respond_to do |format|
			format.json {render :json => values, :status => 200}
		end
	end

	def get_proposals_values_to_graphic
		proposal_situations = ProposalSituation.all
		values = Array.new;
		proposal_situations.each do |sp|
			proposals = Proposal.where(:proposal_situation_id => sp.id).count
			data = {
				:name => sp.name,
				:y => proposals
			}
			values.push(data)
		end
		respond_to do |format|
			format.json {render :json => values, :status => 200}
		end
	end

	def get_informations
		data = Proposal.where('id = ?', params[:id]).first
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	def generate_notification(type)
		if @current_user.id != 1
			if type == 'create'
				text = Proposal.notification_new_proposal(@proposal, @current_user)
				action_notification_id = 7
			elsif type == 'update'
				text = Proposal.notification_edit_proposal(@proposal, @current_user)
				action_notification_id = 8
			elsif type == 'destroy'
				text = Proposal.notification_delete_proposal(@proposal, @current_user)
				action_notification_id = 9
			end
			already_sent = false
			User.to_create_notification([1,7,8]).each do |user|
				notification = Notification.new
				notification.action_notification_id = action_notification_id
				notification.area_notification_id = 2
				notification.sender = @current_user
				notification.receiver = user
				notification.text = text
				notification.save
				if user.id == @current_user.id
					already_sent = true
				end
			end
			if !already_sent
				# Para o próprio usuário
				notification = Notification.new
				notification.action_notification_id = action_notification_id
				notification.area_notification_id = 2
				notification.sender = @current_user
				notification.receiver = @current_user
				notification.text = text
				notification.save
			end
		end
	end

	private
	def proposal_params
		params.require(:proposal).permit(
			:user_id,
			:visits_report_id,
			:title,
			:fantasy_name,
			:social_name,
			:cnpj,
			:observation,
			:notes,
			:proposed_value,
			:closed_value,
			:minimum_value,
			:proposed_percentage,
			:closed_percentage,
			:minimum_percentage,
			:commission_percentage,
			:client_id,
			:proposal_situation_id,
			:user_ids => [],
			monthly_values_attributes: [
				:id,
				:percentual_discounts,
				:observation,
				:_destroy
				],
				upload_proposals_attributes: [
					:id,
					:file,
					:_destroy
					],
					proposal_historics_attributes: [
						:id, 
						:user_id,
						:proposal_id,
						:comment
					]
					)
	end
end
