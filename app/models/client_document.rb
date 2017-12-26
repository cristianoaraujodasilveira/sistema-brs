class ClientDocument < ActiveRecord::Base
	audited

	attr_accessor :type_show_grid
	
	belongs_to :client
	belongs_to :client_document_type
	belongs_to :client_document_status
	belongs_to :client_document_notification
	belongs_to :subfolder_document

	has_attached_file :document,
	:storage => :s3,
	:url => ":s3_domain_url",
	:path => ":class/:attachment/:id_partition/:style/:filename"
	do_not_validate_attachment_file_type :document

	# rotina para atualização de status dos documentos
	def self.update_documents_by_client(client_id)
		client = Client.includes(:client_documents).includes(client_documents: :client_document_type).includes(client_documents: :client_document_status).includes(client_documents: :client_document_notification).where(:id => client_id).first

		if client
			if client.client_documents != nil && client.client_documents.length > 0
				document_1_list = client.client_documents.select{|item| item[:client_document_type_id] == 1 }
				document_2_list = client.client_documents.select{|item| item[:client_document_type_id] == 2 }
				document_3_list = client.client_documents.select{|item| item[:client_document_type_id] == 3 }
				document_4_list = client.client_documents.select{|item| item[:client_document_type_id] == 4 }
				document_5_list = client.client_documents.select{|item| item[:client_document_type_id] == 5 }
				document_6_list = client.client_documents.select{|item| item[:client_document_type_id] == 6 }
				document_7_list = client.client_documents.select{|item| item[:client_document_type_id] == 7 }

				# documentos 1
				document_1_list.each do |document_1|
					if document_1
						due_date = document_1.due_date
						if DateTime.now.to_date > due_date
							if document_1.client_document_status_id != 3
								document_1.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_1.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if document_1.client_document_status_id != 2
									document_1.update_column(:client_document_status_id,2)
								end
							else
								if document_1.client_document_status_id !=
									document_1.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end	# documentos 1

				# documentos 2
				document_2_list.each do |document_2|
					if document_2
						due_date = document_2.due_date
						if DateTime.now.to_date > due_date
							if document_2.client_document_status_id != 3
								document_2.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_2.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if document_2.client_document_status_id != 2
									document_2.update_column(:client_document_status_id,2)
								end
							else
								if document_2.client_document_status_id != 1
									document_2.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 2

				# documentos 3
				document_3_list.each do |document_3|
					if document_3
						due_date = document_3.due_date
						if DateTime.now.to_date > due_date
							if document_3.client_document_status_id != 3
								document_3.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_3.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if document_3.client_document_status_id != 2
									document_3.update_column(:client_document_status_id,2)
								end
							else
								if document_3.client_document_status_id != 1
									document_3.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 3

				# documentos 4
				document_4_list.each do |document_4|
					if document_4
						due_date = document_4.due_date
						if DateTime.now.to_date > due_date
							if document_4.client_document_status_id != 3
								document_4.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_4.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if document_4.client_document_status_id != 2
									document_4.update_column(:client_document_status_id,2)
								end
							else
								if document_4.client_document_status_id != 1
									document_4.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 4

				# documentos 5
				document_5_list.each do |document_5|
					if document_5
						due_date = document_5.due_date
						if DateTime.now.to_date > due_date
							if document_5.client_document_status_id != 3
								document_5.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_5.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if document_5.client_document_status_id != 2
									document_5.update_column(:client_document_status_id,2)
								end
							else
								if document_5.client_document_status_id != 1
									document_5.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 5

				# documentos 6
				document_6_list.each do |document_6|
					if document_6
						due_date = document_6.due_date
						if DateTime.now.to_date > due_date
							if document_6.client_document_status_id != 3
								document_6.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_6.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if document_6.client_document_status_id != 2
									document_6.update_column(:client_document_status_id,2)
								end
							else
								if document_6.client_document_status_id != 1
									document_6.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 6

				# documentos 7
				document_7_list.each do |document_7|
					if document_7
						due_date = document_7.due_date
						if DateTime.now.to_date > due_date
							if document_7.client_document_status_id != 3
								document_7.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_7.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if document_7.client_document_status_id != 2
									document_7.update_column(:client_document_status_id,2)
								end
							else
								if document_7.client_document_status_id != 1
									document_7.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 7

			end # if client.client_documents > 0
		end # if client
	end # rotina

	# rotina para atualização de status dos documentos
	def self.update_documents
		clients = Client.includes(:client_documents).includes(client_documents: :client_document_type).includes(client_documents: :client_document_status).includes(client_documents: :client_document_notification).includes(:users).all

		clients.each do |client|
			if client.client_documents != nil && client.client_documents.length > 0

				list_emails_to_send = client.users.select{|item| item[:is_blocked] != true }.collect(&:email).join(",")

				document_1_list = client.client_documents.select{|item| item[:client_document_type_id] == 1 }
				document_2_list = client.client_documents.select{|item| item[:client_document_type_id] == 2 }
				document_3_list = client.client_documents.select{|item| item[:client_document_type_id] == 3 }
				document_4_list = client.client_documents.select{|item| item[:client_document_type_id] == 4 }
				document_5_list = client.client_documents.select{|item| item[:client_document_type_id] == 5 }
				document_6_list = client.client_documents.select{|item| item[:client_document_type_id] == 6 }
				document_7_list = client.client_documents.select{|item| item[:client_document_type_id] == 7 }

				list_email_to_client = Array.new

				# documentos 1
				document_1_list.each do |document_1|
					if document_1
						due_date = document_1.due_date
						if DateTime.now.to_date+1.days == due_date
							# documento irá vencer daqui 1 dia
							object = Object.new
							object.instance_variable_set(:@document, document_1)
							object.instance_variable_set(:@days, 1)
							object.instance_variable_set(:@text, 'dia')
							object.instance_variable_set(:@client, client)
							list_email_to_client.push(object)
						elsif DateTime.now.to_date > due_date
							if document_1.client_document_status_id != 3
								document_1.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_1.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if date_more_notification_days == due_date
									# dia de notificar o vencimento do documento pela configuração							 
									object = Object.new
									object.instance_variable_set(:@document, document_1)
									object.instance_variable_set(:@days, days_notification)
									object.instance_variable_set(:@text, 'dias')
									object.instance_variable_set(:@client, client)
									list_email_to_client.push(object)
								end
								if document_1.client_document_status_id != 2
									document_1.update_column(:client_document_status_id,2)
								end
							else
								if document_1.client_document_status_id !=
									document_1.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end	# documentos 1

				# documentos 2
				document_2_list.each do |document_2|
					if document_2
						due_date = document_2.due_date
						if DateTime.now.to_date+1.days == due_date
							# documento irá vencer daqui 1 dia
							object = Object.new
							object.instance_variable_set(:@document, document_2)
							object.instance_variable_set(:@days, 1)
							object.instance_variable_set(:@text, 'dia')
							object.instance_variable_set(:@client, client)
							list_email_to_client.push(object)
						elsif DateTime.now.to_date > due_date
							if document_2.client_document_status_id != 3
								document_2.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_2.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if date_more_notification_days == due_date
									# dia de notificar o vencimento do documento pela configuração								 
									object = Object.new
									object.instance_variable_set(:@document, document_2)
									object.instance_variable_set(:@days, days_notification)
									object.instance_variable_set(:@text, 'dias')
									object.instance_variable_set(:@client, client)
									list_email_to_client.push(object)
								end
								if document_2.client_document_status_id != 2
									document_2.update_column(:client_document_status_id,2)
								end
							else
								if document_2.client_document_status_id != 1
									document_2.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 2

				# documentos 3
				document_3_list.each do |document_3|
					if document_3
						due_date = document_3.due_date
						if DateTime.now.to_date+1.days == due_date
							# documento irá vencer daqui 1 dia
							object = Object.new
							object.instance_variable_set(:@document, document_3)
							object.instance_variable_set(:@days, 1)
							object.instance_variable_set(:@text, 'dia')
							object.instance_variable_set(:@client, client)
							list_email_to_client.push(object)
						elsif DateTime.now.to_date > due_date
							if document_3.client_document_status_id != 3
								document_3.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_3.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if date_more_notification_days == due_date
									# dia de notificar o vencimento do documento pela configuração								 
									object = Object.new
									object.instance_variable_set(:@document, document_3)
									object.instance_variable_set(:@days, days_notification)
									object.instance_variable_set(:@text, 'dias')
									object.instance_variable_set(:@client, client)
									list_email_to_client.push(object)
								end
								if document_3.client_document_status_id != 2
									document_3.update_column(:client_document_status_id,2)
								end
							else
								if document_3.client_document_status_id != 1
									document_3.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 3

				# documentos 4
				document_4_list.each do |document_4|
					if document_4
						due_date = document_4.due_date
						if DateTime.now.to_date+1.days == due_date
							# documento irá vencer daqui 1 dia
							object = Object.new
							object.instance_variable_set(:@document, document_4)
							object.instance_variable_set(:@days, 1)
							object.instance_variable_set(:@text, 'dia')
							object.instance_variable_set(:@client, client)
							list_email_to_client.push(object)
						elsif DateTime.now.to_date > due_date
							if document_4.client_document_status_id != 3
								document_4.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_4.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if date_more_notification_days == due_date
									# dia de notificar o vencimento do documento pela configuração								 
									object = Object.new
									object.instance_variable_set(:@document, document_4)
									object.instance_variable_set(:@days, days_notification)
									object.instance_variable_set(:@text, 'dias')
									object.instance_variable_set(:@client, client)
									list_email_to_client.push(object)
								end
								if document_4.client_document_status_id != 2
									document_4.update_column(:client_document_status_id,2)
								end
							else
								if document_4.client_document_status_id != 1
									document_4.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 4

				# documentos 5
				document_5_list.each do |document_5|
					if document_5
						due_date = document_5.due_date
						if DateTime.now.to_date+1.days == due_date
							# documento irá vencer daqui 1 dia
							object = Object.new
							object.instance_variable_set(:@document, document_5)
							object.instance_variable_set(:@days, 1)
							object.instance_variable_set(:@text, 'dia')
							object.instance_variable_set(:@client, client)
							list_email_to_client.push(object)
						elsif DateTime.now.to_date > due_date
							if document_5.client_document_status_id != 3
								document_5.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_5.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if date_more_notification_days == due_date
									# dia de notificar o vencimento do documento pela configuração								 
									object = Object.new
									object.instance_variable_set(:@document, document_5)
									object.instance_variable_set(:@days, days_notification)
									object.instance_variable_set(:@text, 'dias')
									object.instance_variable_set(:@client, client)
									list_email_to_client.push(object)
								end
								if document_5.client_document_status_id != 2
									document_5.update_column(:client_document_status_id,2)
								end
							else
								if document_5.client_document_status_id != 1
									document_5.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 5

				# documentos 6
				document_6_list.each do |document_6|
					if document_6
						due_date = document_6.due_date
						if DateTime.now.to_date+1.days == due_date
							# documento irá vencer daqui 1 dia
							object = Object.new
							object.instance_variable_set(:@document, document_6)
							object.instance_variable_set(:@days, 1)
							object.instance_variable_set(:@text, 'dia')
							object.instance_variable_set(:@client, client)
							list_email_to_client.push(object)
						elsif DateTime.now.to_date > due_date
							if document_6.client_document_status_id != 3
								document_6.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_6.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if date_more_notification_days == due_date
									# dia de notificar o vencimento do documento pela configuração								 
									object = Object.new
									object.instance_variable_set(:@document, document_6)
									object.instance_variable_set(:@days, days_notification)
									object.instance_variable_set(:@text, 'dias')
									object.instance_variable_set(:@client, client)
									list_email_to_client.push(object)
								end
								if document_6.client_document_status_id != 2
									document_6.update_column(:client_document_status_id,2)
								end
							else
								if document_6.client_document_status_id != 1
									document_6.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 6

				# documentos 7
				document_7_list.each do |document_7|
					if document_7
						due_date = document_7.due_date
						if DateTime.now.to_date+1.days == due_date
							# documento irá vencer daqui 1 dia
							object = Object.new
							object.instance_variable_set(:@document, document_7)
							object.instance_variable_set(:@days, 1)
							object.instance_variable_set(:@text, 'dia')
							object.instance_variable_set(:@client, client)
							list_email_to_client.push(object)
						elsif DateTime.now.to_date > due_date
							if document_7.client_document_status_id != 3
								document_7.update_column(:client_document_status_id,3)
							end
						else
							days_notification = document_7.client_document_notification.days
							date_more_notification_days = DateTime.now.to_date+days_notification.days
							if (date_more_notification_days == due_date || date_more_notification_days > due_date)
								if date_more_notification_days == due_date
									# dia de notificar o vencimento do documento pela configuração								 
									object = Object.new
									object.instance_variable_set(:@document, document_7)
									object.instance_variable_set(:@days, days_notification)
									object.instance_variable_set(:@text, 'dias')
									object.instance_variable_set(:@client, client)
									list_email_to_client.push(object)
								end
								if document_7.client_document_status_id != 2
									document_7.update_column(:client_document_status_id,2)
								end
							else
								if document_7.client_document_status_id != 1
									document_7.update_column(:client_document_status_id,1)
								end
							end
						end
					end
				end # documentos 7

				if list_email_to_client.length > 0 && list_emails_to_send.length > 0
					# enviar email ao cliente informando sobre os documentos que irão vencer
					ApplicationMailer.document_will_expire_client_message(list_email_to_client, client, list_emails_to_send).deliver_now
				end

			end # if client.client_documents > 0
		end # clients
	end # rotina

end
