require 'rails_helper'

RSpec.describe ClientContact, type: :model do
	it 'has a valid factory' do
		expect(create :client_contact).to be_valid
	end

	it { should belong_to :client }
	it { should belong_to :state }
	it { should belong_to :city }
	it { should belong_to :client_contact_type }
	it { should belong_to :client_class }

	it { should have_many :phone_users }
	it { should have_many :email_users }

	it { should validate_presence_of :zipcode }
	it { should validate_presence_of :address }
	it { should validate_presence_of :number }
	it { should validate_presence_of :district }
	it { should validate_presence_of :responsible_name }
	it { should validate_presence_of :state_id }
	it { should validate_presence_of :city_id }

end
