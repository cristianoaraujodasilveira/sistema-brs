class BiddingProposalsController < ApplicationController

	before_action :financial

	def index 
		@grid = BiddingProposalsGrid.new(params[:bidding_proposals_grid])
		respond_to do |f|
			f.html do
				@grid.scope {|scope| scope.page(params[:page]) }
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Processos-#{Time.now.to_s}.csv"
			end
		end
	end

end
