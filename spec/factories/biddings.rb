FactoryGirl.define do
	factory :bidding do
		association :catch_user, factory: :user
		catch_date_catch {Faker::Date.between(30.days.ago, Date.today)}
		association :catch_client, factory: :client
		association :catch_organ, factory: :organ
		association :catch_capture_form, factory: :capture_form
		catch_other_capture_form {Faker::Name.name}
		catch_cost {Faker::Number.number(3)}
		association :catch_bid_newspaper, factory: :bid_newspaper
		association :catch_capture_form_presencial, factory: :capture_form_presencial
		catch_solicitation_date_organ {Faker::Date.between(30.days.ago, Date.today)}
		catch_limit_date_organ {Faker::Date.between(30.days.ago, Date.today)}
		catch_organ_notification true
		catch_organ_notification_observation {Faker::Lorem.paragraph}
		association :catch_modalidate, factory: :modalidate
		catch_other_modalidate {Faker::Name.name}
		catch_number {Faker::Number.number(5)}
		catch_process {Faker::Number.number(5)}
		association :catch_portal, factory: :portal
		catch_limit_date {Faker::Date.between(30.days.ago, Date.today)}
		catch_competition_date {Faker::Date.between(30.days.ago, Date.today)}

		association :read_user, factory: :user
		read_displacement_km {Faker::Number.number(2)}
		read_displacement {Faker::Number.number(3)}
		read_agreed_amount {Faker::Number.number(3)}
		read_date_read {Faker::Date.between(30.days.ago, Date.today)}
		read_sample true
		read_delivery_time {Faker::Date.between(30.days.ago, Date.today)}
		read_survey true
		read_deadline {Faker::Date.between(30.days.ago, Date.today)}
		read_other_judgment_form {Faker::Name.name}
		read_exclusive_me_epp true
		read_srp true
		read_installation true
		read_catalog true
		read_product_guarantee true
		read_proposal_guarantee true
		read_proposal_guarantee_value {Faker::Number.number(3)}
		read_proposal_guarantee_percent {Faker::Number.number(3)}
		read_guarantee_contractual true
		read_guarantee_contractual_value {Faker::Number.number(3)}
		read_guarantee_contractual_percent {Faker::Number.number(3)}
		read_claritication true
		read_claritication_deadline {Faker::Date.between(10.days.ago, Date.today)}
		read_claritication_motivation {Faker::Lorem.paragraph}
		read_impugnment true
		read_impugnment_deadline {Faker::Date.between(10.days.ago, Date.today)}
		read_impugnment_motivation {Faker::Lorem.paragraph}
		association :read_bidding_read_delivery, factory: :bidding_read_delivery
		read_bidding_read_delivery_deadline {Faker::Number.number(3)}

		association :participation_partner_participation, factory: :partner_participation
		participation_partner_participation_justification {Faker::Lorem.paragraph}
		association :participation_process_status, factory: :process_status
		participation_process_status_date {Faker::Date.between(30.days.ago, Date.today)}
		participation_resource true
		participation_against_reason true
		association :participation_process_location, factory: :process_location
	end
end
