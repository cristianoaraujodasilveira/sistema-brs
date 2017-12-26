class FinancialsController < ApplicationController

	before_action :financial

	def index
		generate_financial
		@grid = FinancialsGrid.new(params[:financials_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Financeiro-#{Time.now.to_s}.csv"
			end
		end
	end

	def generate_financial
		clients = Client.all
		clients.each do |client|
			if client.proposal
				contract = Contract.where(:proposal_id => client.proposal.id).first
				if contract
					Contract.update_monthly_payment(contract)
					Contract.update_comission(contract)
					Financial.find_or_create_by(client_id: client.id, contract_id: contract.id)
				end
			end
		end
	end

	def build_initials_relations
		if @financial.attachments.select{|item| item[:id] == nil}.length == 0
			@financial.attachments.build
		end
		if @financial.observations.select{|item| item[:observation_type] == 1 && item[:id] == nil}.length == 0
			@financial.observations.build(observation_type: 1)
		end
		if @financial.observations.select{|item| item[:observation_type] == 2 && item[:id] == nil}.length == 0
			@financial.observations.build(observation_type: 2)
		end
		if @financial.observations.select{|item| item[:observation_type] == 3 && item[:id] == nil}.length == 0
			@financial.observations.build(observation_type: 3)
		end
		if @financial.financial_thirds.select{|item| item[:id] == nil}.length == 0
			@financial.financial_thirds.build
		end
		if @financial.financial_tickets.select{|item| item[:id] == nil}.length == 0
			@financial.financial_tickets.build
		end
		build_relations_childrens
	end

	def build_relations_childrens
		if @financial.client && @financial.client.biddings.length > 0
			@financial.client.biddings.each do |bidding|
				if bidding.attachments.select{ |item| item[:attachment_type] == 14 && item[:id] == nil }.length == 0
					bidding.attachments.build(attachment_type: 14)
				end
				if bidding.attachments.select{ |item| item[:attachment_type] == 15 && item[:id] == nil }.length == 0
					bidding.attachments.build(attachment_type: 15)
				end
				if bidding.attachments.select{ |item| item[:attachment_type] == 16 && item[:id] == nil }.length == 0
					bidding.attachments.build(attachment_type: 16)
				end
				if bidding.attachments.select{ |item| item[:attachment_type] == 17 && item[:id] == nil }.length == 0
					bidding.attachments.build(attachment_type: 17)
				end
				if !bidding.address
					bidding.build_address
				end
				bidding.efforts.build
				bidding.financial_invoices.build
			end
		end
		@financial.financial_thirds.each do |third|
			if third.observations.select{|item| item[:id] == nil}.length == 0
				third.observations.build
			end
		end
	end

	def edit
		@financial = Financial.find params[:id]
		build_initials_relations
		active_step_form(params)
	end

	def redirect_to_edit_step(params)
		if params[:save_1]
			redirect_to controller: 'financials', action: 'edit', id: @financial.id, step: '1'
		elsif params[:save_2]
			redirect_to controller: 'financials', action: 'edit', id: @financial.id, step: '2'
		elsif params[:save_3]
			redirect_to controller: 'financials', action: 'edit', id: @financial.id, step: '3'
		elsif params[:save_4]
			redirect_to controller: 'financials', action: 'edit', id: @financial.id, step: '4'
		end
	end

	def active_step_form(params)
		if params[:save_1] || params[:step] == '1'
			@active = 1
		elsif params[:save_2] || params[:step] == '2'
			@active = 2
		elsif params[:save_3] || params[:step] == '3'
			@active = 3
		elsif params[:save_4] || params[:step] == '4'
			@active = 4
		else
			@active = 1
		end
	end

	def update
		@financial = Financial.find params[:id]
		if @financial.update financial_params
			audit = @financial.audits.last
			if audit
				audit.comment = "Editou o financeiro do cliente '"+@financial.client.fantasy_name+"' de id #"+@financial.id.to_s
				audit.save
			else
				audit = Audit.last
				if audit && audit.comment == nil && audit.auditable_type == 'financial'
					if audit.action == 'create'
						text = "Criou"
					elsif audit.action == 'update'
						text = "Editou"
					elsif audit.action == 'destroy'
						text = "Apagou"
					end
					audit.comment = text+" o financeiro do cliente '"+@financial.client.fantasy_name+"' de id #"+audit.auditable_id.to_s
					audit.save
				end
			end
			if @financial.contract
				Contract.update_monthly_payment(@financial.contract)
				Contract.update_comission(@financial.contract)
				update_comissions_values
			end
			gflash :success => "Financeiro editado com sucesso"
			redirect_to_edit_step(params)
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@financial.errors.full_messages.join('<br>')
			build_initials_relations
			active_step_form(params)
			render :edit
		end
	end

	def update_comissions_values
		if @financial && @financial.client && @financial.client.biddings.length > 0
			contract = Contract.find @financial.contract.id
			@financial.client.biddings.each do |bidding|
				bidding_proposals = bidding.bidding_proposals.select{|item| item[:participation_result_id] == 1 && (item[:competition_status_id] == 2 || item[:competition_status_id] == 3 || item[:competition_status_id] == 4 )}

				contract_value = 0
				
				bidding_proposals.each do |proposal|
					traded_value = proposal.traded_value
					total = 0
					if traded_value && Contract.return_string_like_number(traded_value).to_f > 0
						traded_value = Contract.return_string_like_number(proposal.traded_value).to_f

						contract_value = contract_value + traded_value
						
						comission_brs = Contract.return_string_like_number(contract.comission_payment).to_f
						comission_agent = Contract.return_string_like_number(contract.discount_value).to_f
						comission_intermediary = Contract.return_string_like_number(contract.discount_value_intermediary).to_f
						indication_pessoal = Contract.return_string_like_number(proposal.indication_pessoal).to_f

						if comission_brs && comission_brs > 0
							comission_brs = comission_brs / 100
							value_comission_brs = traded_value * comission_brs
							total = total + value_comission_brs
							value_comission_brs = Contract.return_number_like_string(value_comission_brs, 1)
							proposal.brs_comission = value_comission_brs
						end

						if comission_agent && comission_agent > 0 && proposal.brs_comission && Contract.return_string_like_number(proposal.brs_comission).to_f > 0
							comission_agent = comission_agent / 100
							value_comission_consultant = Contract.return_string_like_number(proposal.brs_comission).to_f * comission_agent
							total = total - value_comission_consultant
							value_comission_consultant = Contract.return_number_like_string(value_comission_consultant, 1)
							proposal.consultant_comission = value_comission_consultant
						end

						if comission_intermediary && comission_intermediary > 0 && proposal.brs_comission && Contract.return_string_like_number(proposal.brs_comission).to_f > 0
							comission_intermediary = comission_intermediary / 100
							value_comission_intermediary = Contract.return_string_like_number(proposal.brs_comission).to_f * comission_intermediary
							total = total - value_comission_intermediary
							value_comission_intermediary = Contract.return_number_like_string(value_comission_intermediary, 1)
							proposal.intermediary_comission = value_comission_intermediary
						end
						if indication_pessoal && indication_pessoal > 0
							total = total - indication_pessoal
						end
						proposal.brs_comission_final = Contract.return_number_like_string(total, 1)
						proposal.save(:validate => false)
					end
				end
				bidding.update_column(:contract_value, Contract.return_number_like_string(contract_value, 1))
			end
		end
	end

	def destroy
		@financial = Financial.find params[:id]
		if @financial 
			@financial.destroy
			audit = @financial.audits.last
			audit.comment = "Apagou o financeiro do cliente '"+@financial.client.fantasy_name+"' de id #"+@financial.id.to_s
			audit.save
			generate_notification('destroy')
			gflash :success => "Financeiro excluído com sucesso"
		end
		redirect_to financials_path
	end

	def delete_attachment_financial
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

	def delete_observation_financial
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a observação '"+observation.observation+"' do financeiro de id #"+observation.observationtable.id.to_s
			audit.save
			gflash :success => "Observação do financeiro excluída com sucesso"
		end
		redirect_to :back
	end

	def generate_notification(type)
		# if type == 'create'
		# 	text = Financial.notification_new_financial(@financial, @current_user)
		# 	action_notification_id = 16
		# elsif type == 'update'
		# 	text = Financial.notification_edit_financial(@financial, @current_user)
		# 	action_notification_id = 17
		# elsif type == 'destroy'
		# 	text = Financial.notification_delete_financial(@financial, @current_user)
		# 	action_notification_id = 18
		# end
		# @financial.financials_users.each do |user|
		# 	if @current_user.id != user.id
		# 		notification = Notification.new
		# 		notification.action_notification_id = action_notification_id
		# 		notification.area_notification_id = 9
		# 		notification.sender = @current_user
		# 		notification.receiver = user
		# 		notification.text = text
		# 		notification.save
		# 	end
		# end
		# if @current_user.id != @financial.user.id
		# 	notification = Notification.new
		# 	notification.action_notification_id = action_notification_id
		# 	notification.area_notification_id = 9
		# 	notification.sender = @current_user
		# 	notification.receiver = @financial.user
		# 	notification.text = text
		# 	notification.save
		# end
	end

	private
	def financial_params
		params.require(:financial).permit(
			:id,
			:client_id,
			:contract_id,
			:indication_pessoal,
			:indication_value,
			:contractual_mulct,
			:reason_contractual_mulct,
			financial_tickets_attributes: [
				:id, 
				:_destroy,
				:ticket,
				:emission_date,
				:due_date,
				:payment_date,
				],
				financial_thirds_attributes: [
					:id, 
					:_destroy,
					:financial_id,
					:third_type_id,
					:third_id,
					:lawyer_id,
					:financial_third_service_id,
					:name,
					:fantasy_name,
					:social_name,
					:value,
					:quantity,
					:date,
					observations_attributes:[
						:id,
						:user_id,
						:observation,
						:observation_type,
						:_destroy
						],
						],
						contract_attributes: [
							:id,
							:monthly_fixed_payment,
							:monthly_payment,
							:monthly_discount,
							:monthly_initial_date,
							:monthly_final_date,
							:comission_fixed_payment,
							:comission_payment,
							:comission_discount,
							:comission_initial_date,
							:comission_final_date,
							:fixed_value, 
							:comission_value,
							:discount_value,
							:fixed_value_intermediary,
							:discount_value_intermediary,
							:comission_value_intermediary,
							:comercial_agent_id,
							:intermediary_id,
							],
							client_attributes: [
								:id,
								biddings_attributes: [
									:id,
									:catch_user_id,
									:catch_date_catch,
									:catch_client_id,
									:catch_organ_id,
									:catch_capture_form_id,
									:catch_other_capture_form,
									:catch_cost,
									:catch_bid_newspaper_id,
									:catch_capture_form_presencial_id,
									:catch_solicitation_date_organ,
									:catch_limit_date_organ,
									:catch_organ_notification,
									:catch_organ_notification_observation,
									:catch_modalidate_id,
									:catch_other_modalidate,
									:catch_number,
									:catch_process,
									:catch_portal_id,
									:catch_limit_date,
									:catch_competition_date,
									:read_user_id,
									:read_displacement_km,
									:read_displacement,
									:read_agreed_amount,
									:read_date_read,
									:read_sample,
									:read_delivery_time,
									:read_survey,
									:read_deadline,
									:read_judgment_form_id,
									:read_other_judgment_form,
									:read_srp,
									:read_installation,
									:read_catalog,
									:read_product_guarantee,
									:read_proposal_guarantee,
									:read_proposal_guarantee_percent,
									:read_proposal_guarantee_value,
									:read_claritication,
									:read_claritication_deadline,
									:read_claritication_motivation,
									:read_impugnment,
									:read_impugnment_deadline,
									:read_impugnment_motivation,
									:read_bidding_read_delivery_id,
									:read_bidding_read_delivery_deadline,
									:read_exclusive_me_epp,
									:read_guarantee_contractual,
									:read_guarantee_contractual_value,
									:read_guarantee_contractual_percent,
									:good_habit_name_read,
									:accreditation_presential_name_read,
									:habilitation_name_read,
									:good_habit_name_participation,
									:accreditation_presential_name_participation,
									:habilitation_name_participation,
									:participation_return_date,
									:participation_partner_participation_id,
									:participation_partner_participation_justification,
									:participation_process_status_id,
									:participation_process_status_date,
									:participation_resource,
									:participation_against_reason,
									:participation_process_location_id,
									:contract_number,
									:contract_value,
									:initial_date,
									:final_date,
									:percent,
									:residual_value_contract,
									:brs_comission,
									:date_payment_comission,
									:comission_received,
									:ride_in_process,
									:organ_ride_id,
									financial_invoices_attributes: [
										:id,
										:_destroy,
										:bidding_id,
										:emission_date,
										:certify_date,
										:due_date_payment,
										:total_value,
										:organ_value,
										:received_value,
										:residual_value,
										:payment_date_residual,
										:liquidation_date,
										:payment_partner_date,
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
											efforts_attributes: [
												:id,
												:bidding_id,
												:number,
												:value,
												:signature_date,
												:initial_date,
												:final_date,
												:_destroy,
												],
												attachments_attributes: [
													:id,
													:attachment,
													:attachment_type
													],
													bidding_proposals_attributes: [
														:id, 
														:_destroy,
														:price_offer_id,
														:another_price_offer,
														:registration_form_id,
														:technical_offer,
														:judgment_form_id,
														:quoted_value,
														:discount_percent,
														:item_number,
														:description,
														:quantity,
														:unitary_value,
														:total_value,
														:global_value,
														:partner_rank_text,
														:partner_rank_id,
														:participation_result_id,
														:competition_status_id,
														:auctioned_value,
														:unit_id,
														:traded_value,
														:bidder_name,
														:representative_name,
														:cnpj,
														:past_due,
														:bidder_status_id,
														:another_bidder_status,
														:provenance_id,
														:country_id,
														:site,
														:brs_comission,
														:consultant_comission,
														:intermediary_comission,
														:indication_pessoal,
														:indication_value,
														:brs_comission_final,
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
															phones_attributes: [
																:id,
																:_destroy,
																:phone
																],
																emails_attributes: [
																	:id,
																	:_destroy,
																	:email
																]
															]
															],
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
																	)
end
end
