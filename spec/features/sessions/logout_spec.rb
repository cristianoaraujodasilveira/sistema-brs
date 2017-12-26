require "rails_helper"

feature 'Logout', js: true do
	scenario 'success' do
		user = create(:user)
		login(user.email, user.password)
		logout()
		expect(page).to have_content "Até logo"
		expect(current_path).to eq new_session_path
	end
end
