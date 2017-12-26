class LibraryCategoriesController < ApplicationController

	before_action :juridical
	
	def index
		@grid = LibraryCategoriesGrid.new(params[:library_categories_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Categorias-#{Time.now.to_s}.csv"
			end
		end
	end

	def new
		@library_category = LibraryCategory.new
	end

	def create
		@library_category = LibraryCategory.new library_category_params

		if @library_category.save
			audit = @library_category.audits.last
			audit.comment = "Cadastrou a categoria '"+@library_category.name+"' de id #"+@library_category.id.to_s
			audit.save
			gflash :success => "Categoria cadastrada com sucesso"
			redirect_to library_categories_path
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@library_category.errors.full_messages.join('<br>')
			build_initials_relations
			render :new
		end
	end

	def edit
		@library_category = LibraryCategory.find params[:id]
	end

	def update
		@library_category = LibraryCategory.find params[:id]
		if @library_category.update library_category_params
			audit = @library_category.audits.last
			if audit
				audit.comment = "Editou a categoria de id #"+@library_category.id.to_s
				audit.save
			else
				audit = Audit.last
				if audit && audit.comment == nil && audit.auditable_type == 'library_category'
					if audit.action == 'create'
						text = "Criou"
					elsif audit.action == 'update'
						text = "Editou"
					elsif audit.action == 'destroy'
						text = "Apagou"
					end
					audit.comment = text+" a categoria de id #"+audit.auditable_id.to_s
					audit.save
				end
			end
			gflash :success => "Categoria editado com sucesso"
			redirect_to library_categories_path
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@library_category.errors.full_messages.join('<br>')
			build_initials_relations
			render :edit
		end
	end

	def destroy
		library_category = LibraryCategory.find params[:id]
		if library_category 
			if library_category.destroy
				audit = library_category.audits.last
				audit.comment = "Apagou a categoria '"+library_category.name+"' de id #"+library_category.id.to_s
				audit.save
				gflash :success => "Categoria excluída com sucesso"
			else
				gflash :now, :error => "Categoria não pode ser excluída. Existem vínculos com a mesma."
			end
		end
		redirect_to library_categories_path
	end

	private
	def library_category_params
		params.require(:library_category).permit(
			:id,
			:name)
	end
end
