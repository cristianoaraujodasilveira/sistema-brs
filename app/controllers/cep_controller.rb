class CepController < ApplicationController
	#skip_before_action :only_admin_permited, :authenticate_user
	def find_cep
		require 'correios-cep'

		address = ""
		Correios::CEP.configure do |config|
	      config.request_timeout = 120 # It configures timeout to 120 seconds
	    end

	    cep = params[:cep].gsub(/[.,-]/, "")
	    if cep.length == 8 && !!(cep =~ /\A[-+]?[0-9]+\z/)
			address = Correios::CEP::AddressFinder.get(cep)
	    end
	  #   if address
			# coordenate = Geocoder.geocode(address[:address])
	  #   end
		data = {
	      :address => address
	      # :coordenate => coordenate
	    }

	    # Encaminha a resposta
	    respond_to do |format|
	    	format.json {render :json => data, :status => 200}
	    end

	end
end
