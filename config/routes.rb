Rails.application.routes.draw do

	# ------------------- JÁ FUNCIONANDO ------------------ #
	root to: 'sessions#new'

	match 'active'  => 'sessions#active',  via: :get
	match 'timeout' => 'sessions#timeout', via: :get

	get 'find_cep', :to => 'cep#find_cep', :as => 'find_cep'
	get 'states/:state_id/cities.json', :to => 'cities#by_state'
	get 'get_informations_client/:id/client.json', :to => 'clients#get_informations'
	get 'client_document_types/:client_document_type_id/subfolders.json', :to => 'clients#get_subfolders_client_document_type'

	get 'login', :to => 'sessions#new', :as => 'new_session'
	get 'logout', :to => 'sessions#destroy', :as => 'logout'

	resources :sessions
	resources :users
	resources :audits

	get 'recover_pass', :to => 'users#recovery_pass', :as => 'recovery_pass'
	post 'recovery_pass', :to => 'users#create_recovery_pass', :as => 'create_recovery_pass'
	get 'edit_pass/:recovery_token', :to => 'users#edit_pass', :as => 'edit_pass_token'
	get 'edit_pass', :to => 'users#edit_pass', :as => 'edit_pass'
	patch 'update_pass/:id', :to => 'users#update_pass', :as => 'update_pass'

	resources :organs
	delete 'delete_sector', to: 'organs#delete_sector', :as => 'delete_sector'
	get '/get_organs_values_to_graphic', :to => 'organs#get_organs_values_to_graphic', :as => 'get_organs_values_to_graphic'

	resources :proposals
	get 'proposals_historic/:id', :to => 'proposals#proposals_historic', :as => 'proposals_historic'
	get '/get_proposals_values_to_graphic', :to => 'proposals#get_proposals_values_to_graphic', :as => 'get_proposals_values_to_graphic'
	get 'get_informations_proposal/:id/proposal.json', :to => 'proposals#get_informations'

	resources :registration_units
	delete 'delete_responsible_registration_unit', to: 'registration_units#delete_responsible_registration_unit', :as => 'delete_responsible_registration_unit'
	
	resources :clients
	
	resources :contracts
	get 'draft_contract/:id', :to => 'contracts#draft_contract_edit', :as => 'draft_contract_edit'
	get 'draft_contract_email/:id', :to => 'contracts#draft_contract_email', :as => 'draft_contract_email'
	get 'draft_contract_download/:id', :to => 'contracts#draft_contract_download', :as => 'draft_contract_download'
	get '/get_contracts_values_to_graphic', :to => 'contracts#get_contracts_values_to_graphic', :as => 'get_contracts_values_to_graphic'
	get 'update_values_contracts', :to => 'contracts#update_values_contracts', :as => 'update_values_contracts'
	delete 'delete_attachment_contract/:attachment_id', to: 'contracts#delete_attachment_contract', :as => 'delete_attachment_contract'

	resources :entity_classes

	resources :calendar_events
	get '/events_marked/:user_id', :to => 'calendar_events#events_marked'
	get '/events_marked', :to => 'calendar_events#events_marked'
	
	resources :visits_reports
	get '/visits_report_marked/:user_id', :to => 'visits_reports#visits_report_marked'
	get '/visits_report_marked', :to => 'visits_reports#visits_report_marked'
	get 'get_informations_visits_report/:id/visits_report.json', :to => 'visits_reports#get_informations'
	get '/get_visits_reports_values_to_graphic', :to => 'visits_reports#get_visits_reports_values_to_graphic', :as => 'get_visits_reports_values_to_graphic'

	resources :portals
	delete 'delete_observation_portal', to: 'portals#delete_observation_portal', :as => 'delete_observation_portal'
	delete 'delete_phone_portal', to: 'portals#delete_phone_portal', :as => 'delete_phone_portal'
	delete 'delete_email_portal', to: 'portals#delete_email_portal', :as => 'delete_email_portal'
	delete 'delete_skype_portal', to: 'portals#delete_skype_portal', :as => 'delete_skype_portal'

	resources :official_diaries
	delete 'delete_observation_official_diary', to: 'official_diaries#delete_observation_official_diary', :as => 'delete_observation_official_diary'
	delete 'delete_phone_official_diary', to: 'official_diaries#delete_phone_official_diary', :as => 'delete_phone_official_diary'
	delete 'delete_email_official_diary', to: 'official_diaries#delete_email_official_diary', :as => 'delete_email_official_diary'
	delete 'delete_skype_official_diary', to: 'official_diaries#delete_skype_official_diary', :as => 'delete_skype_official_diary'

	resources :bid_newspapers
	delete 'delete_observation_bid_newspaper', to: 'bid_newspapers#delete_observation_bid_newspaper', :as => 'delete_observation_bid_newspaper'
	delete 'delete_phone_bid_newspaper', to: 'bid_newspapers#delete_phone_bid_newspaper', :as => 'delete_phone_bid_newspaper'
	delete 'delete_email_bid_newspaper', to: 'bid_newspapers#delete_email_bid_newspaper', :as => 'delete_email_bid_newspaper'
	delete 'delete_skype_bid_newspaper', to: 'bid_newspapers#delete_skype_bid_newspaper', :as => 'delete_skype_bid_newspaper'
	
	resources :biddings
	delete 'delete_observation_bidding', to: 'biddings#delete_observation_bidding', :as => 'delete_observation_bidding'
	delete 'delete_observation_bidding_resource', to: 'biddings#delete_observation_bidding_resource', :as => 'delete_observation_bidding_resource'
	post '/save_edit_qualifications/:type/:id', :to => 'biddings#save_edit_qualifications', :as => 'save_edit_qualifications'

	resources :lawyers

	resources :pieces
	delete 'delete_observation_piece', to: 'pieces#delete_observation_piece', :as => 'delete_observation_piece'
	delete 'delete_attachment_piece/:attachment_id', to: 'pieces#delete_attachment_piece', :as => 'delete_attachment_piece'
	delete 'delete_historic_situation_piece/:historic_situation_id', to: 'pieces#delete_historic_situation_piece', :as => 'delete_historic_situation_piece'
	get '/get_pieces_values_to_graphic', :to => 'pieces#get_pieces_values_to_graphic', :as => 'get_pieces_values_to_graphic'

	resources :library_categories
	
	resources :libraries
	get 'show_library', :to => 'libraries#show_library', :as => 'show_library'
	get 'show_library/:category_id', :to => 'libraries#show_library', :as => 'show_library_with_category'

	resources :thirds
	get 'index_diligent', :to => 'thirds#index_diligent', :as => 'index_diligent'
	get 'index_motoboy', :to => 'thirds#index_motoboy', :as => 'index_motoboy'
	get 'index_other', :to => 'thirds#index_other', :as => 'index_other'
	get 'index_post_office', :to => 'thirds#index_post_office', :as => 'index_post_office'
	get 'index_registry', :to => 'thirds#index_registry', :as => 'index_registry'
	delete 'delete_attachment_third/:attachment_id', to: 'thirds#delete_attachment_third', :as => 'delete_attachment_third'
	delete 'delete_observation_third', to: 'thirds#delete_observation_third', :as => 'delete_observation_third'
	delete 'delete_phone_third', to: 'thirds#delete_phone_third', :as => 'delete_phone_third'
	delete 'delete_email_third', to: 'thirds#delete_email_third', :as => 'delete_email_third'
	delete 'delete_skype_third', to: 'thirds#delete_skype_third', :as => 'delete_skype_third'
	get 'thirds/:third_type/thirds.json', :to => 'thirds#by_third_type'
	
	resources :notifications
	get 'get_new_notifications', :to => 'notifications#get_new_notifications', :as => 'get_new_notifications'
	get 'mark_as_read', :to => 'notifications#mark_as_read', :as => 'mark_as_read'
	get 'mark_as_unread', :to => 'notifications#mark_as_unread', :as => 'mark_as_unread'
	
	resources :communications
	delete 'delete_attachment_communication/:attachment_id', to: 'communications#delete_attachment_communication', :as => 'delete_attachment_communication'
	delete 'delete_observation_communication', to: 'communications#delete_observation_communication', :as => 'delete_observation_communication'

	resources :financials
	delete 'delete_attachment_financial/:attachment_id', to: 'financials#delete_attachment_financial', :as => 'delete_attachment_financial'
	delete 'delete_observation_financial', to: 'financials#delete_observation_financial', :as => 'delete_observation_financial'

	resources :bidding_proposals
	# ------------------------------------------------------ #

	resources :finances
end
