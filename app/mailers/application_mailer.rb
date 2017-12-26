class ApplicationMailer < ActionMailer::Base
	default from: "contato@brs.com.br"
	def recovery_pass_message(user)
		@user = user
		mail(:to => user.email, :subject => "Alteração de senha do usuário no sistema da BRS.")
	end

	def document_will_expire_admin_message(list_document, user)
		@user = user
		@list_document = list_document
		if user.email != nil 
			mail(:to => [user.email,"contato@brslicita.com.br","brs.licita@gmail.com","financeiro@brslicita.com.br"], :subject => "Vencimento de documento de clientes no sistema da BRS")
		end
	end

	def document_will_expire_client_message(list_document, client, list_emails_to_send)
		@client = client
		@list_document = list_document
		if list_emails_to_send.length > 0
			mail(:to => list_emails_to_send, :subject => "Vencimento de documento no sistema da BRS")
		end
	end

	def send_email_with_contract_message(from, subject, to, cc, cco, message, filename, pdf)
		@message = message
		attachments[filename] = pdf
		mail(:to => to, :cc => cc, :bcc => cco, :subject => subject, :from => from)
	end

	def new_user_created_message(user)
		@recipients = User.where(:profile_id => [1, 7])
		emails = @recipients.collect(&:email).join(",")
		@user = user
		mail(:to => emails, :subject => "Novo usuário criado - "+user.name)
	end

end
