class LibrariesController < ApplicationController

	before_action :juridical

	def index
		@grid = LibrariesGrid.new(params[:libraries_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Publicações-#{Time.now.to_s}.csv"
			end
		end
	end

	def new
		@library = Library.new
		build_initials_relations
	end

	def build_initials_relations
		if @library.attachments.select{ |item| item[:id] == nil}.length == 0
			@library.attachments.build
		end
		if @library.words_keys.select{ |item| item[:id] == nil }.length == 0
			@library.words_keys.build
		end
	end

	def create
		@library = Library.new library_params
		if params[:add_word_key]
			@library.words_keys.build
			build_initials_relations
			render :new
		elsif params[:remove_data_1]
			build_initials_relations
			render :new
		else
			if @library.save
				audit = @library.audits.last
				audit.comment = "Cadastrou a publicação de título '"+@library.title+"' de id #"+@library.id.to_s
				audit.save
				gflash :success => "Publicação cadastrada com sucesso"
				redirect_to edit_library_path @library
			else
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@library.errors.full_messages.join('<br>')
				build_initials_relations
				render :new
			end
		end
	end

	def build_in_edit(library_params)
		unless library_params[:words_keys_attributes].blank?
			for attribute in library_params[:words_keys_attributes]
				@library.words_keys.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
	end

	def edit
		@library = Library.find params[:id]
		build_initials_relations
	end

	def update
		@library = Library.find params[:id]
		if params[:add_word_key]
			build_in_edit(library_params)
			@library.words_keys.build
			render :edit
		else
			if @library.update library_params
				audit = @library.audits.last
				if audit
					audit.comment = "Editou a publicação de id #"+@library.id.to_s
					audit.save
				else
					audit = Audit.last
					if audit && audit.comment == nil && audit.auditable_type == 'library'
						if audit.action == 'create'
							text = "Criou"
						elsif audit.action == 'update'
							text = "Editou"
						elsif audit.action == 'destroy'
							text = "Apagou"
						end
						audit.comment = text+" a publicação de id #"+audit.auditable_id.to_s
						audit.save
					end
				end
				gflash :success => "Publicação editada com sucesso"
				redirect_to edit_library_path @library
			else
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@library.errors.full_messages.join('<br>')
				build_initials_relations
				render :edit
			end
		end
	end

	def destroy
		library = Library.find params[:id]
		if library 
			library.destroy
			audit = library.audits.last
			audit.comment = "Apagou a publicação de id #"+library.id.to_s
			audit.save
			gflash :success => "Publicação excluída com sucesso"
		end
		redirect_to libraries_path
	end

	def delete_attachment_library
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

	def show_library
		@categories = LibraryCategory.all.order(:name)
		if params[:category_id]
			@publications = Library.where(:library_category_id => params[:category_id]).find_by_text(params[:text_to_find]).find_by_state(params[:state_id]).order(created_at: :desc)
			if params[:category_id] == '16'
				@show_filter_by_state = true
				@states = State.all.order(:name)
			end
		end
	end

	private
	def library_params
		params.require(:library).permit(
			:id,
			:library_category_id,
			:title,
			:author_name,
			:edition,
			:year_publication,
			:publishing_company,
			:isbn,
			:link,
			:sanctioned_date,
			:court,
			:state_id,
			:city_id,
			:document_name,
			:process_number,
			:process_date,
			:legislative_reference,
			:description,
			attachments_attributes: [
				:id,
				:attachment,
				],
				words_keys_attributes:[
					:_destroy,
					:id,
					:word
				]
				)
	end
end
