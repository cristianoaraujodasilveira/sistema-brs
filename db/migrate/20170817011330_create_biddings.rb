class CreateBiddings < ActiveRecord::Migration
	def change
		create_table :biddings do |t|
			t.references :catch_user, references: :users
			t.datetime :catch_date_catch
			t.references :catch_client, references: :clients
			t.references :catch_organ, references: :organs
			t.references :catch_capture_form, references: :capture_forms
			t.string :catch_other_capture_form
			t.string :catch_cost
			t.references :catch_bid_newspaper, references: :bid_newspapers
			t.references :catch_capture_form_presencial, references: :capture_form_presencials
			t.datetime :catch_solicitation_date_organ
			t.datetime :catch_limit_date_organ
			t.boolean :catch_organ_notification
			t.text :catch_organ_notification_observation
			t.references :catch_modalidate, references: :modalidates
			t.string :catch_other_modalidate
			t.string :catch_number
			t.string :catch_process
			t.references :catch_portal, references: :portals
			t.datetime :catch_limit_date
			t.datetime :catch_competition_date

			t.references :read_user, references: :users
			t.integer :read_displacement_km
			t.string :read_displacement
			t.string :read_agreed_amount
			t.datetime :read_date_read
			t.boolean :read_sample
			t.datetime :read_delivery_time
			t.boolean :read_survey
			t.datetime :read_deadline
			t.references :read_judgment_form, references: :judgment_forms
			t.string :read_other_judgment_form
			t.boolean :read_exclusive_me_epp
			t.boolean :read_srp
			t.boolean :read_installation
			t.boolean :read_catalog
			t.boolean :read_product_guarantee
			t.boolean :read_proposal_guarantee
			t.string :read_proposal_guarantee_value
			t.string :read_proposal_guarantee_percent
			t.boolean :read_guarantee_contractual
			t.string :read_guarantee_contractual_value
			t.string :read_guarantee_contractual_percent
			t.boolean :read_claritication
			t.date :read_claritication_deadline
			t.text :read_claritication_motivation
			t.boolean :read_impugnment
			t.date :read_impugnment_deadline
			t.text :read_impugnment_motivation
			t.references :read_bidding_read_delivery, references: :bidding_read_deliveries
			t.integer :read_bidding_read_delivery_deadline
			
			t.datetime :participation_return_date
			t.references :participation_partner_participation, references: :partner_participations
			t.text :participation_partner_participation_justification
			t.references :participation_process_status, references: :process_statuses
			t.datetime :participation_process_status_date
			t.boolean :participation_resource
			t.boolean :participation_against_reason
			t.references :participation_process_location, references: :process_locations

			t.timestamps null: false
		end
	end
end
