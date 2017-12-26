require 'rails_helper'

RSpec.describe User, type: :model do
	it 'has a valid factory' do
		expect(create :user).to be_valid
	end

	describe 'Validations' do
		it { should have_secure_password }
		it { should validate_presence_of :name }
		it { should validate_presence_of :email }
		it { should validate_presence_of :password }
		it { should validate_presence_of :profile_id }
		
		it { should validate_presence_of :city_id }
		it { should validate_presence_of :state_id }
		it { should validate_presence_of :zipcode }
		it { should validate_presence_of :address }
		it { should validate_presence_of :district }
		it { should validate_presence_of :number }
		it { should validate_presence_of :cpf }
		it { should validate_presence_of :rg }
		it { should validate_presence_of :birth_date }

		it { should validate_uniqueness_of :cpf }
		it { should validate_uniqueness_of :rg }
		it { should validate_uniqueness_of :email }
		it { should validate_email_format_of(:email).with_message('inválido') }
	end

	describe 'Relations' do
		it { should belong_to :profile }
		it { should belong_to :state }
		it { should belong_to :city }
		it { should belong_to :calendar_color }
		it { should have_many :email_users }
		it { should have_many :phone_users }
		it { should have_many :observations }
		it { should have_and_belong_to_many :proposals }
		it { should have_and_belong_to_many :clients }
		it { should have_and_belong_to_many :permission_profiles }
	end
end
