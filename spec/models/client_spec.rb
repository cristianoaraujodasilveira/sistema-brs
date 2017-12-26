require 'rails_helper'

RSpec.describe Client, type: :model do
	it 'has a valid factory' do
		expect(create :client).to be_valid
	end

	it { should have_many :proposals }
	it { should have_many :clients }
	it { should have_many :client_clients }
	it { should have_many :client_banks }
	it { should have_many :client_documents }
	
	it { should belong_to :client_company_size }
	it { should belong_to :client_periodicity }
	it { should belong_to :client_type }
	it { should belong_to :client_status }
	it { should belong_to :client }
	it { should belong_to :client_class }
	it { should have_one :client_segment }
	it { should have_one :client_contability }
	it { should have_and_belong_to_many :users }
	
end
