class OrgansController < ApplicationController
	
	before_action :register
	
	def index
		@grid_organs = OrgansGrid.new(params[:organs_grid]) do |scope|
			scope.page(params[:page])
		end
		organ_id = params[:format]
		if organ_id
			@organ = Organ.find organ_id
			@show_grid_sector = true
			@grid_sectors = SectorsGrid.new(params[:sectors_grid]) do |scope|
				scope.where(:organ_id => organ_id.to_i).page(params[:page])	
			end
		else
			@show_grid_sector = false
			@grid_sectors = SectorsGrid.new(params[:sectors_grid]) do |scope|
				scope.page(params[:page])	
			end
		end
	end

	def edit
		@organ = Organ.find params[:id]
		if @organ.sectors.length == 0 
			@organ.sectors.build
		end
		build_sectors_attributes
	end

	def new
		@organ = Organ.new
		@organ.sectors.build
		build_sectors_attributes
	end

	def create
		@organ = Organ.new(organ_params)
		if params[:add_branch]
		    # add empty organ associated with @organ
		    @organ.organs.build
		    build_sectors_attributes
		    render :new
		elsif params[:add_sector]
			@organ.sectors.build
			build_sectors_attributes
			render :new
		elsif params[:add_electronic_portal]
			@organ.electronic_portals.build
			build_sectors_attributes
			render :new
		elsif params[:remove_data]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    build_sectors_attributes
		    render :new
		else
	        # save goes like usual
	        if @organ.save
	        	audit = @organ.audits.last
	        	audit.comment = "Criou o orgão '"+@organ.name+"' de id #"+@organ.id.to_s
	        	audit.save
	        	gflash :success => "Orgão cadastrado com sucesso"
	        	redirect_to organs_path
	        else
	        	build_sectors_attributes
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@organ.errors.full_messages.join('<br>')
	        	render :new
	        end
	    end
	end

	def build_sectors_attributes
		@organ.sectors.each do |sector|
			sector.phone_sectors.build
			sector.email_sectors.build
		end
		if @organ.electronic_portals.length == 0
			@organ.electronic_portals.build
		end
	end

	def update
		@organ = Organ.find(params[:id])

		if params[:add_branch]
			# rebuild the organs attributes that doesn't have an id
			unless organ_params[:organs_attributes].blank?
				for attribute in organ_params[:organs_attributes]
					@organ.organs.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
				end
			end
	      	# add one more empty organ attribute
	      	@organ.organs.build
	      	build_sectors_attributes
	      	render :edit
	      elsif params[:add_sector]
	      	unless organ_params[:sectors_attributes].blank?
	      		for attribute in organ_params[:sectors_attributes]
	      			@organ.sectors.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	      		end
	      	end
	      	# add one more empty sector attribute
	      	@organ.sectors.build
	      	build_sectors_attributes
	      	render :edit
	      elsif params[:add_electronic_portal]
	      	unless organ_params[:electronic_portals_attributes].blank?
	      		for attribute in organ_params[:electronic_portals_attributes]
	      			@organ.electronic_portals.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	      		end
	      	end
	      	# add one more empty eletronic_portal attribute
	      	@organ.electronic_portals.build
	      	build_sectors_attributes
	      	render :edit
	      elsif params[:remove_data]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    build_sectors_attributes
		    render :edit
		else
	        # save goes like usual
	        if @organ.update_attributes organ_params
	        	audit = @organ.audits.last
	        	if audit
	        		audit.comment = "Editou o orgão '"+@organ.name+"' de id #"+@organ.id.to_s
	        		audit.save
	        	else
	        		audit = Audit.last
	        		if audit && audit.comment == nil && audit.auditable_type == 'Sector'
	        			if audit.action == 'create'
	        				text = "Criou"
	        			elsif audit.action == 'update'
	        				text = "Editou"
	        			elsif audit.action == 'destroy'
	        				text = "Apagou"
	        			end
	        			audit.comment = text+" o setor de id #"+audit.auditable_id.to_s+" do orgão de id #"+@organ.id.to_s
	        			audit.save
	        		end
	        	end
	        	gflash :success => "Orgão editado com sucesso"
	        	redirect_to edit_organ_path @organ
	        else
	        	build_sectors_attributes
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@organ.errors.full_messages.join('<br>')
	        	render :edit
	        end
	    end
	end

	def destroy
		organ = Organ.find params[:id]
		if organ 
			organ.destroy
			audit = organ.audits.last
			audit.comment = "Apagou o orgão '"+organ.name+"' de id #"+organ.id.to_s
			audit.save
			gflash :success => "Orgão excluído com sucesso"
		end
		redirect_to organs_path
	end

	def delete_sector
		sector = Sector.find params[:format]
		if sector 
			sector.destroy
			audit = sector.audits.last
			audit.comment = "Apagou o setor '"+sector.name+"' de id #"+sector.id.to_s+" do orgão de id #"+sector.organ_id.to_s
			audit.save
			gflash :success => "Setor excluído com sucesso"
		end
		redirect_to :back
	end

	def get_organs_values_to_graphic
		spheres = Sphere.all
		values = Array.new;
		spheres.each do |sp|
			organs = Organ.where(:sphere_id => sp.id).count
			data = {
				:name => sp.name,
				:y => organs
			}
			values.push(data)
		end
		respond_to do |format|
			format.json {render :json => values, :status => 200}
		end
	end

	private
	def organ_params
		params.require(:organ).permit(
			:name,
			:email,
			:cnpj,
			:site,
			:phone,
			:eletronic_portal,
			:zipcode,
			:address,
			:district,
			:number,
			:complement,
			:sphere_id,
			:state_id, 
			:city_id,
			:observation,
			:identification_number,
			:portal_ids => [],
			organs_attributes: [
				:name,
				:email,
				:cnpj,
				:site,
				:phone,
				:eletronic_portal,
				:zipcode,
				:address,
				:district,
				:number,
				:complement,
				:sphere_id,
				:state_id, 
				:city_id,
				:observation,
				:identification_number,
				:organ_id,
				:_destroy,
				sectors_attributes: [
					:id,
					:name,
					:office,
					:department,
					:observation,
					:responsible_name,
					:_destroy,
					email_sectors_attributes: [
						:id,
						:email,
						:_destroy
						],
						phone_sectors_attributes: [
							:id,
							:phone,
							:extension,
							:_destroy
						]
					]
					],
					sectors_attributes: [
						:id,
						:name,
						:office,
						:department,
						:observation,
						:responsible_name,
						:_destroy,
						email_sectors_attributes: [
							:id,
							:email,
							:_destroy
							],
							phone_sectors_attributes: [
								:id,
								:phone,
								:extension,
								:_destroy
							]
							],
							electronic_portals_attributes: [
								:id,
								:_destroy,
								:value
							]
							)
	end
end
