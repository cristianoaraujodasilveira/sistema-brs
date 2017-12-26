class AuditsController < ApplicationController

	def index
		user_id = params[:format]
		if user_id != nil && user_id != "" && user_id != "0"
			user = User.find user_id
		end
		if user
			@grid = AuditsGrid.new(params[:audits_grid]) do |scope|
				scope.where(:user_id => user.id).page(params[:page])
			end
		else
			@grid = AuditsGrid.new(params[:audits_grid]) do |scope|
				scope.page(params[:page])
			end
		end
	end

end