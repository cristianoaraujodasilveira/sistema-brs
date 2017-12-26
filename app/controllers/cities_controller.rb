class CitiesController < ApplicationController
	skip_before_action :authenticate_user
  # Coleta todas as cidades a partir de um ID de um estado
  def by_state
  	data = City.where('state_id = ?', params[:state_id]).order(:name)
  	respond_to do |format|
  		format.json {render :json => data, :status => 200}
  	end
  end
end
