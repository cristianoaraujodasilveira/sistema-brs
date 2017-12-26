class Responsible < ActiveRecord::Base
	belongs_to :responsibletable, :polymorphic => true

	has_many :phones, :as => :phonetable, dependent: :destroy
	accepts_nested_attributes_for :phones, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_many :emails, :as => :emailtable, dependent: :destroy
	accepts_nested_attributes_for :emails, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

	has_many :skypes, :as => :skypetable, dependent: :destroy
	accepts_nested_attributes_for :skypes, allow_destroy: true, :reject_if => proc { |attrs| attrs[:skype].blank? }

end
