class PiecesController < ApplicationController

	before_action :juridical

	def index
		@grid = PiecesGrid.new(params[:pieces_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Peças-#{Time.now.to_s}.csv"
			end
		end
	end

	def new
		@piece = Piece.new
		build_initials_relations
	end

	def build_initials_relations
		if @piece.attachments.select{|item| item[:attachment_type] == 1 && item[:id] == nil}.length == 0
			@piece.attachments.build(:attachment_type => 1)
		end
		if @piece.attachments.select{|item| item[:attachment_type] == 2 && item[:id] == nil}.length == 0
			@piece.attachments.build(:attachment_type => 2)
		end
		if @piece.observations.select{ |item| item[:id] == nil }.length == 0
			@piece.observations.build
		end
		generate_collection
	end

	def generate_collection
		@collection = @piece.piece_process_files.order(:folder_name)
	end

	def create
		@piece = Piece.new piece_params
		if params[:add_phone]
			build_initials_relations
		elsif params[:add_email]
			build_initials_relations
		elsif params[:remove_phone] || params[:remove_email]
			build_initials_relations
			render :new
		else
			if @piece.save
				if piece_params[:file_to_add] && piece_params[:file_to_add] != nil
					add_file_to_folder(piece_params)
				end
				audit = @piece.audits.last
				audit.comment = "Cadastrou a peça de id #"+@piece.id.to_s
				audit.save
				gflash :success => "Peça cadastrado com sucesso"
				redirect_to edit_piece_path @piece
			else
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@piece.errors.full_messages.join('<br>')
				build_initials_relations
				render :new
			end
		end
	end

	def build_in_edit(piece_params)
		unless piece_params[:addresses_attributes].blank?
			for attribute in piece_params[:addresses_attributes]
				@piece.addresses.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless piece_params[:phones_attributes].blank?
			for attribute in piece_params[:phones_attributes]
				@piece.phones.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless piece_params[:emails_attributes].blank?
			for attribute in piece_params[:emails_attributes]
				@piece.emails.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
	end

	def edit
		@piece = Piece.find params[:id]
		build_initials_relations
	end

	def update
		@piece = Piece.find params[:id]
		older_situation_id = @piece.piece_situation_id
		if @piece.update piece_params
			if piece_params[:file_to_add] && piece_params[:file_to_add] != nil
				add_file_to_folder(piece_params)
			end
			audit = @piece.audits.last
			if audit
				audit.comment = "Editou a peça de id #"+@piece.id.to_s
				audit.save
			else
				audit = Audit.last
				if audit && audit.comment == nil && audit.auditable_type == 'piece'
					if audit.action == 'create'
						text = "Criou"
					elsif audit.action == 'update'
						text = "Editou"
					elsif audit.action == 'destroy'
						text = "Apagou"
					end
					audit.comment = text+" a peça de id #"+audit.auditable_id.to_s
					audit.save
				end
			end
			if older_situation_id != @piece.piece_situation_id
				@piece.piece_historic_situations << PieceHistoricSituation.new(:piece => @piece, :observation_id => @piece.observations.last.id, :old_piece_situation_id => older_situation_id, :new_piece_situation_id => @piece.piece_situation_id, :user => @current_user)
			end
			gflash :success => "Peça editada com sucesso"
			redirect_to edit_piece_path @piece
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@piece.errors.full_messages.join('<br>')
			build_initials_relations
			render :edit
		end
	end

	def add_file_to_folder(piece_params)
		folder_id = piece_params[:piece_process_file_id]
		if folder_id && folder_id != '' && folder_id != '0'
			folder = PieceProcessFile.find folder_id
		elsif piece_params[:folder_name] && piece_params[:folder_name] != ''
			folder = PieceProcessFile.new(:folder_name => piece_params[:folder_name])
			folder.save
		else
			folder = PieceProcessFile.find_or_create_by(:folder_name => '[sem nome]')
		end
		if folder
			if piece_params[:file_to_add] != nil 
				folder.attachments.create(:attachment => piece_params[:file_to_add])
				@piece.piece_process_files << folder
			end
		end
	end

	def destroy
		piece = Piece.find params[:id]
		if piece 
			piece.destroy
			audit = piece.audits.last
			audit.comment = "Apagou a peça de id #"+piece.id.to_s
			audit.save
			gflash :success => "Peça excluída com sucesso"
		end
		redirect_to pieces_path
	end

	def delete_observation_piece
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a observação '"+observation.observation+"' da peça de id #"+observation.observationtable.id.to_s
			audit.save
			gflash :success => "Observação de peça excluída com sucesso"
		end
		redirect_to edit_piece_path observation.observationtable_id
	end

	def delete_attachment_piece
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

	def delete_historic_situation_piece
		result = false
		historic_situation = PieceHistoricSituation.find params[:historic_situation_id]
		if historic_situation 
			if historic_situation.destroy
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

	def get_pieces_values_to_graphic
		piece_situations = PieceSituation.all
		values = Array.new;
		piece_situations.each do |piece_situation|
			pieces = Piece.where(:piece_situation_id => piece_situation.id).count
			data = {
				:name => piece_situation.name,
				:y => pieces,
				:color => get_piece_color(piece_situation.id)
			}
			values.push(data)
		end
		respond_to do |format|
			format.json {render :json => values, :status => 200}
		end
	end

	def get_piece_color(piece_situation_id)
		case piece_situation_id 
		when 1   
			return '#BEBEBE'
		when 2   
			return '#FF0000'
		when 3
			return '#00FF00'
		when 4
			return '#0000FF'
		else
			puts "it was something else"
		end
	end

	private
	def piece_params
		params.require(:piece).permit(
			:id,
			:piece_name_id,
			:judicial_type_id,
			:initial_date,
			:deadline,
			:piece_result_id,
			:client_id,
			:organ_id,
			:number,
			:process,
			:protocol_number,
			:shipping_type_id,
			:piece_situation_id,
			:modalidate_id,
			:piece_process_file_id,
			:folder_name,
			:file_to_add,
			lawyer_ids: [],
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
				]
				)
	end
end
