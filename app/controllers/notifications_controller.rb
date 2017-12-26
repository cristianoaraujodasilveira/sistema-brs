class NotificationsController < ApplicationController

	def index 
		@grid = NotificationsGrid.new(params[:notifications_grid])
		respond_to do |f|
			f.html do
				if @current_user.is_admin?
					@grid.scope {|scope| scope.page(params[:page]) }
				else
					@grid.scope {|scope| scope.where(:receiver_id => @current_user.id).page(params[:page]) }
				end
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Notificações-#{Time.now.to_s}.csv"
			end
		end
	end
	
	def get_new_notifications
		user_id = params[:user_id].to_i
		user = User.find user_id
		notifications_unread = Notification.where(:receiver_id => user_id).unread_by(user).order(created_at: :desc).limit(10)
		notifications_unread_length = Notification.where(:receiver_id => user_id).unread_by(user).count
		data = {
			:notifications_unread => notifications_unread, 
			:notifications_unread_length => notifications_unread_length
		}
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	def update_notifications_read
		notifications_unread = Notification.where(:receiver_id => @current_user.id).unread_by(@current_user).order(created_at: :desc).limit(10)
		notifications_unread_length = Notification.where(:receiver_id => @current_user.id).unread_by(@current_user).order(created_at: :desc).count
		for notification in notifications_unread
			notification.mark_as_read! :for => @current_user
		end
		data = {
			:notifications_unread => notifications_unread,
			:notifications_unread_length => notifications_unread_length
		}
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	def mark_as_read
		notification_unread = Notification.where(:id => params[:notification_id]).first
		notification_unread.mark_as_read! :for => @current_user
		
		notifications_unread = Notification.where(:receiver_id => @current_user.id).unread_by(@current_user).order(created_at: :desc).limit(10)
		notifications_unread_length = Notification.where(:receiver_id => @current_user.id).unread_by(@current_user).order(created_at: :desc).count
		data = {
			:notifications_unread => notifications_unread,
			:notifications_unread_length => notifications_unread_length
		}
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	def mark_as_unread
		notification_read = Notification.where(:id => params[:notification_id]).first
		ReadMark.where(readable_type: notification_read.class.name, readable_id: notification_read.id).each(&:destroy!)
		
		notifications_unread = Notification.where(:receiver_id => @current_user.id).unread_by(@current_user).order(created_at: :desc).limit(10)
		notifications_unread_length = Notification.where(:receiver_id => @current_user.id).unread_by(@current_user).order(created_at: :desc).count
		data = {
			:notifications_unread => notifications_unread,
			:notifications_unread_length => notifications_unread_length,
		}
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

end
