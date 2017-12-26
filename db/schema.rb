# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171009024546) do

  create_table "account_bank_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "accreditation_presentials", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "action_notifications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "addresstable_id",   limit: 4,   null: false
    t.string   "addresstable_type", limit: 30,  null: false
    t.string   "zipcode",           limit: 255
    t.string   "address",           limit: 255
    t.string   "district",          limit: 255
    t.string   "number",            limit: 255
    t.string   "complement",        limit: 255
    t.integer  "type",              limit: 4
    t.integer  "state_id",          limit: 4
    t.integer  "city_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "address_type",      limit: 4
  end

  add_index "addresses", ["addresstable_id", "addresstable_type"], name: "my_index", using: :btree
  add_index "addresses", ["city_id"], name: "index_addresses_on_city_id", using: :btree
  add_index "addresses", ["state_id"], name: "index_addresses_on_state_id", using: :btree

  create_table "area_notifications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachmentable_id",       limit: 4,   null: false
    t.string   "attachmentable_type",     limit: 30,  null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.datetime "attachment_updated_at"
    t.integer  "type",                    limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "attachment_type",         limit: 4
  end

  add_index "attachments", ["attachmentable_id", "attachmentable_type"], name: "index_attachments_on_attachmentable_id_and_attachmentable_type", using: :btree

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id",    limit: 4
    t.string   "auditable_type",  limit: 255
    t.integer  "associated_id",   limit: 4
    t.string   "associated_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.string   "user_type",       limit: 255
    t.string   "username",        limit: 255
    t.string   "action",          limit: 255
    t.text     "audited_changes", limit: 4294967295
    t.integer  "version",         limit: 4,          default: 0
    t.string   "comment",         limit: 255
    t.string   "remote_address",  limit: 255
    t.string   "request_uuid",    limit: 255
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "bid_newspapers", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "client_id",    limit: 4
    t.string   "name",         limit: 255
    t.string   "social_name",  limit: 255
    t.string   "cnpj",         limit: 255
    t.date     "initial_date"
    t.date     "final_date"
    t.string   "phone_brs",    limit: 255
    t.string   "email_brs",    limit: 255
    t.string   "site",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "bid_newspapers", ["client_id"], name: "index_bid_newspapers_on_client_id", using: :btree
  add_index "bid_newspapers", ["user_id"], name: "index_bid_newspapers_on_user_id", using: :btree

  create_table "bidder_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "bidding_proposals", force: :cascade do |t|
    t.integer  "bidding_id",              limit: 4
    t.integer  "price_offer_id",          limit: 4
    t.string   "another_price_offer",     limit: 255
    t.integer  "registration_form_id",    limit: 4
    t.boolean  "technical_offer"
    t.integer  "judgment_form_id",        limit: 4
    t.string   "quoted_value",            limit: 255
    t.string   "discount_percent",        limit: 255
    t.string   "item_number",             limit: 255
    t.text     "description",             limit: 65535
    t.integer  "quantity",                limit: 4
    t.string   "unitary_value",           limit: 255
    t.string   "total_value",             limit: 255
    t.string   "global_value",            limit: 255
    t.string   "partner_rank_text",       limit: 255
    t.integer  "partner_rank_id",         limit: 4
    t.integer  "participation_result_id", limit: 4
    t.integer  "competition_status_id",   limit: 4
    t.string   "auctioned_value",         limit: 255
    t.integer  "unit_id",                 limit: 4
    t.string   "traded_value",            limit: 255
    t.string   "bidder_name",             limit: 255
    t.string   "representative_name",     limit: 255
    t.string   "cnpj",                    limit: 255
    t.string   "past_due",                limit: 255
    t.integer  "bidder_status_id",        limit: 4
    t.string   "another_bidder_status",   limit: 255
    t.integer  "provenance_id",           limit: 4
    t.integer  "country_id",              limit: 4
    t.string   "site",                    limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "brs_comission",           limit: 255
    t.string   "consultant_comission",    limit: 255
    t.string   "intermediary_comission",  limit: 255
    t.string   "indication_pessoal",      limit: 255
    t.string   "indication_value",        limit: 255
    t.string   "brs_comission_final",     limit: 255
  end

  add_index "bidding_proposals", ["bidder_status_id"], name: "index_bidding_proposals_on_bidder_status_id", using: :btree
  add_index "bidding_proposals", ["bidding_id"], name: "index_bidding_proposals_on_bidding_id", using: :btree
  add_index "bidding_proposals", ["competition_status_id"], name: "index_bidding_proposals_on_competition_status_id", using: :btree
  add_index "bidding_proposals", ["country_id"], name: "index_bidding_proposals_on_country_id", using: :btree
  add_index "bidding_proposals", ["judgment_form_id"], name: "index_bidding_proposals_on_judgment_form_id", using: :btree
  add_index "bidding_proposals", ["participation_result_id"], name: "index_bidding_proposals_on_participation_result_id", using: :btree
  add_index "bidding_proposals", ["partner_rank_id"], name: "index_bidding_proposals_on_partner_rank_id", using: :btree
  add_index "bidding_proposals", ["price_offer_id"], name: "index_bidding_proposals_on_price_offer_id", using: :btree
  add_index "bidding_proposals", ["provenance_id"], name: "index_bidding_proposals_on_provenance_id", using: :btree
  add_index "bidding_proposals", ["registration_form_id"], name: "index_bidding_proposals_on_registration_form_id", using: :btree
  add_index "bidding_proposals", ["unit_id"], name: "index_bidding_proposals_on_unit_id", using: :btree

  create_table "bidding_read_deliveries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "bidding_resources", force: :cascade do |t|
    t.integer  "bidding_id",            limit: 4
    t.integer  "bidding_proposal_id",   limit: 4
    t.integer  "type",                  limit: 4
    t.datetime "initial_date"
    t.datetime "final_date"
    t.datetime "insertion_portal_date"
    t.integer  "result_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "resource_type",         limit: 4
  end

  add_index "bidding_resources", ["bidding_id"], name: "index_bidding_resources_on_bidding_id", using: :btree
  add_index "bidding_resources", ["bidding_proposal_id"], name: "index_bidding_resources_on_bidding_proposal_id", using: :btree
  add_index "bidding_resources", ["result_id"], name: "index_bidding_resources_on_result_id", using: :btree

  create_table "bidding_responsibles", force: :cascade do |t|
    t.integer  "bidding_id",   limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "initial_date"
    t.datetime "final_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "bidding_responsibles", ["bidding_id"], name: "index_bidding_responsibles_on_bidding_id", using: :btree
  add_index "bidding_responsibles", ["user_id"], name: "index_bidding_responsibles_on_user_id", using: :btree

  create_table "biddings", force: :cascade do |t|
    t.integer  "catch_user_id",                                     limit: 4
    t.datetime "catch_date_catch"
    t.integer  "catch_client_id",                                   limit: 4
    t.integer  "catch_organ_id",                                    limit: 4
    t.integer  "catch_capture_form_id",                             limit: 4
    t.string   "catch_other_capture_form",                          limit: 255
    t.string   "catch_cost",                                        limit: 255
    t.integer  "catch_bid_newspaper_id",                            limit: 4
    t.integer  "catch_capture_form_presencial_id",                  limit: 4
    t.datetime "catch_solicitation_date_organ"
    t.datetime "catch_limit_date_organ"
    t.boolean  "catch_organ_notification"
    t.text     "catch_organ_notification_observation",              limit: 65535
    t.integer  "catch_modalidate_id",                               limit: 4
    t.string   "catch_other_modalidate",                            limit: 255
    t.string   "catch_number",                                      limit: 255
    t.string   "catch_process",                                     limit: 255
    t.integer  "catch_portal_id",                                   limit: 4
    t.datetime "catch_limit_date"
    t.datetime "catch_competition_date"
    t.integer  "read_user_id",                                      limit: 4
    t.integer  "read_displacement_km",                              limit: 4
    t.string   "read_displacement",                                 limit: 255
    t.string   "read_agreed_amount",                                limit: 255
    t.datetime "read_date_read"
    t.boolean  "read_sample"
    t.datetime "read_delivery_time"
    t.boolean  "read_survey"
    t.datetime "read_deadline"
    t.integer  "read_judgment_form_id",                             limit: 4
    t.string   "read_other_judgment_form",                          limit: 255
    t.boolean  "read_exclusive_me_epp"
    t.boolean  "read_srp"
    t.boolean  "read_installation"
    t.boolean  "read_catalog"
    t.boolean  "read_product_guarantee"
    t.boolean  "read_proposal_guarantee"
    t.string   "read_proposal_guarantee_value",                     limit: 255
    t.string   "read_proposal_guarantee_percent",                   limit: 255
    t.boolean  "read_guarantee_contractual"
    t.string   "read_guarantee_contractual_value",                  limit: 255
    t.string   "read_guarantee_contractual_percent",                limit: 255
    t.boolean  "read_claritication"
    t.date     "read_claritication_deadline"
    t.text     "read_claritication_motivation",                     limit: 65535
    t.boolean  "read_impugnment"
    t.date     "read_impugnment_deadline"
    t.text     "read_impugnment_motivation",                        limit: 65535
    t.integer  "read_bidding_read_delivery_id",                     limit: 4
    t.integer  "read_bidding_read_delivery_deadline",               limit: 4
    t.datetime "participation_return_date"
    t.integer  "participation_partner_participation_id",            limit: 4
    t.text     "participation_partner_participation_justification", limit: 65535
    t.integer  "participation_process_status_id",                   limit: 4
    t.datetime "participation_process_status_date"
    t.boolean  "participation_resource"
    t.boolean  "participation_against_reason"
    t.integer  "participation_process_location_id",                 limit: 4
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.datetime "scheduling_date"
    t.boolean  "ride_in_process"
    t.integer  "organ_ride_id",                                     limit: 4
    t.string   "contract_number",                                   limit: 255
    t.string   "contract_value",                                    limit: 255
    t.date     "initial_date"
    t.date     "final_date"
    t.string   "percent",                                           limit: 255
    t.string   "residual_value_contract",                           limit: 255
    t.string   "brs_comission",                                     limit: 255
    t.date     "date_payment_comission"
    t.string   "comission_received",                                limit: 255
    t.datetime "catch_suspension_communication_date"
    t.datetime "catch_reopened_date"
    t.datetime "catch_publication_date"
    t.string   "catch_bidding_id",                                  limit: 255
    t.datetime "read_claritication_solicitation_date"
    t.datetime "read_impugnment_solicitation_date"
  end

  create_table "biddings_accreditation_presentials", force: :cascade do |t|
    t.integer  "bidding_id",                  limit: 4
    t.integer  "accreditation_presential_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "biddings_accreditation_presentials", ["accreditation_presential_id"], name: "accreditation_id", using: :btree
  add_index "biddings_accreditation_presentials", ["bidding_id"], name: "bidding_id", using: :btree

  create_table "biddings_good_habits", force: :cascade do |t|
    t.integer  "bidding_id",    limit: 4
    t.integer  "good_habit_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "biddings_good_habits", ["bidding_id"], name: "index_biddings_good_habits_on_bidding_id", using: :btree
  add_index "biddings_good_habits", ["good_habit_id"], name: "index_biddings_good_habits_on_good_habit_id", using: :btree

  create_table "biddings_habilitations", force: :cascade do |t|
    t.integer  "bidding_id",      limit: 4
    t.integer  "habilitation_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "biddings_habilitations", ["bidding_id"], name: "index_biddings_habilitations_on_bidding_id", using: :btree
  add_index "biddings_habilitations", ["habilitation_id"], name: "index_biddings_habilitations_on_habilitation_id", using: :btree

  create_table "biddings_users", force: :cascade do |t|
    t.integer  "bidding_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "biddings_users", ["bidding_id"], name: "index_biddings_users_on_bidding_id", using: :btree
  add_index "biddings_users", ["user_id"], name: "index_biddings_users_on_user_id", using: :btree

  create_table "calendar_colors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "calendar_events", force: :cascade do |t|
    t.integer  "calendar_event_id",      limit: 4
    t.integer  "entity_class_id",        limit: 4
    t.string   "name",                   limit: 255
    t.integer  "user_id",                limit: 4
    t.integer  "calendar_color_id",      limit: 4
    t.integer  "calendar_type_event_id", limit: 4
    t.boolean  "shared"
    t.string   "zipcode",                limit: 255
    t.string   "address",                limit: 255
    t.string   "district",               limit: 255
    t.string   "number",                 limit: 255
    t.string   "complement",             limit: 255
    t.integer  "state_id",               limit: 4
    t.integer  "city_id",                limit: 4
    t.boolean  "send_notification"
    t.boolean  "repeat"
    t.integer  "quantity_repetition",    limit: 4
    t.integer  "calendar_repetition_id", limit: 4
    t.text     "observation",            limit: 65535
    t.date     "initial_date"
    t.time     "initial_time"
    t.time     "final_time"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "calendar_events", ["calendar_color_id"], name: "index_calendar_events_on_calendar_color_id", using: :btree
  add_index "calendar_events", ["calendar_event_id"], name: "index_calendar_events_on_calendar_event_id", using: :btree
  add_index "calendar_events", ["calendar_repetition_id"], name: "index_calendar_events_on_calendar_repetition_id", using: :btree
  add_index "calendar_events", ["calendar_type_event_id"], name: "index_calendar_events_on_calendar_type_event_id", using: :btree
  add_index "calendar_events", ["city_id"], name: "index_calendar_events_on_city_id", using: :btree
  add_index "calendar_events", ["entity_class_id"], name: "index_calendar_events_on_entity_class_id", using: :btree
  add_index "calendar_events", ["state_id"], name: "index_calendar_events_on_state_id", using: :btree
  add_index "calendar_events", ["user_id"], name: "index_calendar_events_on_user_id", using: :btree

  create_table "calendar_events_users", force: :cascade do |t|
    t.integer  "calendar_event_id", limit: 4
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "calendar_events_users", ["calendar_event_id"], name: "index_calendar_events_users_on_calendar_event_id", using: :btree
  add_index "calendar_events_users", ["user_id"], name: "index_calendar_events_users_on_user_id", using: :btree

  create_table "calendar_events_weekdays", id: false, force: :cascade do |t|
    t.integer  "calendar_event_id", limit: 4
    t.integer  "weekday_id",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "calendar_events_weekdays", ["calendar_event_id"], name: "index_calendar_events_weekdays_on_calendar_event_id", using: :btree
  add_index "calendar_events_weekdays", ["weekday_id"], name: "index_calendar_events_weekdays_on_weekday_id", using: :btree

  create_table "calendar_repetitions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "calendar_type_events", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "capture_form_presencials", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "capture_forms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "state_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "client_banks", force: :cascade do |t|
    t.string   "owner_account",        limit: 255
    t.string   "bank_name",            limit: 255
    t.string   "bank_code",            limit: 255
    t.string   "agency_number",        limit: 255
    t.string   "agency_name",          limit: 255
    t.string   "cnpj",                 limit: 255
    t.string   "operation",            limit: 255
    t.integer  "account_bank_type_id", limit: 4
    t.integer  "client_id",            limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "account_number",       limit: 255
  end

  add_index "client_banks", ["account_bank_type_id"], name: "index_client_banks_on_account_bank_type_id", using: :btree
  add_index "client_banks", ["client_id"], name: "index_client_banks_on_client_id", using: :btree

  create_table "client_classes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "client_clients", force: :cascade do |t|
    t.integer  "client_id",          limit: 4
    t.integer  "client_children_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "client_clients", ["client_id"], name: "index_client_clients_on_client_id", using: :btree

  create_table "client_company_sizes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "client_contabilities", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "zipcode",            limit: 255
    t.string   "address",            limit: 255
    t.string   "district",           limit: 255
    t.string   "number",             limit: 255
    t.string   "complement",         limit: 255
    t.integer  "client_id",          limit: 4
    t.integer  "state_id",           limit: 4
    t.integer  "city_id",            limit: 4
    t.boolean  "extern_contability"
    t.boolean  "intern_contability"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "client_contabilities", ["city_id"], name: "index_client_contabilities_on_city_id", using: :btree
  add_index "client_contabilities", ["client_id"], name: "index_client_contabilities_on_client_id", using: :btree
  add_index "client_contabilities", ["state_id"], name: "index_client_contabilities_on_state_id", using: :btree

  create_table "client_contact_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "client_contacts", force: :cascade do |t|
    t.string   "zipcode",                limit: 255
    t.string   "address",                limit: 255
    t.string   "number",                 limit: 255
    t.string   "complement",             limit: 255
    t.string   "district",               limit: 255
    t.string   "responsible_name",       limit: 255
    t.string   "office",                 limit: 255
    t.string   "department",             limit: 255
    t.string   "whatsapp",               limit: 255
    t.string   "skype",                  limit: 255
    t.integer  "client_id",              limit: 4
    t.integer  "state_id",               limit: 4
    t.integer  "city_id",                limit: 4
    t.integer  "client_contact_type_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "client_class_id",        limit: 4
  end

  add_index "client_contacts", ["city_id"], name: "index_client_contacts_on_city_id", using: :btree
  add_index "client_contacts", ["client_class_id"], name: "index_client_contacts_on_client_class_id", using: :btree
  add_index "client_contacts", ["client_contact_type_id"], name: "index_client_contacts_on_client_contact_type_id", using: :btree
  add_index "client_contacts", ["client_id"], name: "index_client_contacts_on_client_id", using: :btree
  add_index "client_contacts", ["state_id"], name: "index_client_contacts_on_state_id", using: :btree

  create_table "client_document_notifications", force: :cascade do |t|
    t.integer  "days",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "client_document_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "color",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "client_document_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "client_documents", force: :cascade do |t|
    t.string   "document_file_name",              limit: 255
    t.string   "document_content_type",           limit: 255
    t.integer  "document_file_size",              limit: 4
    t.datetime "document_updated_at"
    t.date     "due_date"
    t.integer  "client_id",                       limit: 4
    t.integer  "client_document_type_id",         limit: 4
    t.integer  "client_document_status_id",       limit: 4
    t.integer  "client_document_notification_id", limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.date     "emission_date"
    t.integer  "subfolder_document_id",           limit: 4
  end

  add_index "client_documents", ["client_document_notification_id"], name: "index_client_documents_on_client_document_notification_id", using: :btree
  add_index "client_documents", ["client_document_status_id"], name: "index_client_documents_on_client_document_status_id", using: :btree
  add_index "client_documents", ["client_document_type_id"], name: "index_client_documents_on_client_document_type_id", using: :btree
  add_index "client_documents", ["client_id"], name: "index_client_documents_on_client_id", using: :btree
  add_index "client_documents", ["subfolder_document_id"], name: "index_client_documents_on_subfolder_document_id", using: :btree

  create_table "client_periodicities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "client_segments", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "products_services", limit: 65535
    t.integer  "client_id",         limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "client_segments", ["client_id"], name: "index_client_segments_on_client_id", using: :btree

  create_table "client_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "client_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "logo_file_name",         limit: 255
    t.string   "logo_content_type",      limit: 255
    t.integer  "logo_file_size",         limit: 4
    t.datetime "logo_updated_at"
    t.string   "stamp_file_name",        limit: 255
    t.string   "stamp_content_type",     limit: 255
    t.integer  "stamp_file_size",        limit: 4
    t.datetime "stamp_updated_at"
    t.string   "social_name",            limit: 255
    t.string   "fantasy_name",           limit: 255
    t.string   "cnpj",                   limit: 255
    t.string   "site",                   limit: 255
    t.string   "municipal_registration", limit: 255
    t.string   "state_registration",     limit: 255
    t.boolean  "bid_participant"
    t.boolean  "needs_update"
    t.integer  "client_id",              limit: 4
    t.integer  "client_children_id",     limit: 4
    t.integer  "client_company_size_id", limit: 4
    t.integer  "client_periodicity_id",  limit: 4
    t.integer  "client_type_id",         limit: 4
    t.integer  "client_status_id",       limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "proposal_id",            limit: 4
    t.integer  "client_class_id",        limit: 4
  end

  add_index "clients", ["client_class_id"], name: "index_clients_on_client_class_id", using: :btree
  add_index "clients", ["client_company_size_id"], name: "index_clients_on_client_company_size_id", using: :btree
  add_index "clients", ["client_id"], name: "index_clients_on_client_id", using: :btree
  add_index "clients", ["client_periodicity_id"], name: "index_clients_on_client_periodicity_id", using: :btree
  add_index "clients", ["client_status_id"], name: "index_clients_on_client_status_id", using: :btree
  add_index "clients", ["client_type_id"], name: "index_clients_on_client_type_id", using: :btree
  add_index "clients", ["proposal_id"], name: "index_clients_on_proposal_id", using: :btree

  create_table "clients_users", id: false, force: :cascade do |t|
    t.integer  "client_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "clients_users", ["client_id"], name: "index_clients_users_on_client_id", using: :btree
  add_index "clients_users", ["user_id"], name: "index_clients_users_on_user_id", using: :btree

  create_table "communication_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "communications", force: :cascade do |t|
    t.integer  "user_id",                 limit: 4
    t.integer  "communication_status_id", limit: 4
    t.integer  "department_notified_id",  limit: 4
    t.integer  "client_id",               limit: 4
    t.integer  "organ_id",                limit: 4
    t.integer  "modalidate_id",           limit: 4
    t.string   "subject",                 limit: 255
    t.text     "description",             limit: 65535
    t.string   "modalidate_number",       limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "communications", ["client_id"], name: "index_communications_on_client_id", using: :btree
  add_index "communications", ["communication_status_id"], name: "index_communications_on_communication_status_id", using: :btree
  add_index "communications", ["department_notified_id"], name: "index_communications_on_department_notified_id", using: :btree
  add_index "communications", ["modalidate_id"], name: "index_communications_on_modalidate_id", using: :btree
  add_index "communications", ["organ_id"], name: "index_communications_on_organ_id", using: :btree
  add_index "communications", ["user_id"], name: "index_communications_on_user_id", using: :btree

  create_table "communications_users", force: :cascade do |t|
    t.integer "communication_id", limit: 4
    t.integer "user_id",          limit: 4
  end

  add_index "communications_users", ["communication_id"], name: "index_communications_users_on_communication_id", using: :btree
  add_index "communications_users", ["user_id"], name: "index_communications_users_on_user_id", using: :btree

  create_table "competition_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contability_contacts", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "client_contability_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "contability_contacts", ["client_contability_id"], name: "index_contability_contacts_on_client_contability_id", using: :btree

  create_table "contability_secondary_contacts", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "client_contability_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "contability_secondary_contacts", ["client_contability_id"], name: "index_contability_secondary_contacts_on_client_contability_id", using: :btree

  create_table "contract_models", force: :cascade do |t|
    t.text     "draft_contact", limit: 4294967295
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "contract_payments", force: :cascade do |t|
    t.integer  "contract_id",              limit: 4
    t.integer  "payment_form_id",          limit: 4
    t.integer  "payment_from_id",          limit: 4
    t.integer  "payment_sugestion_day_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "all_scope"
  end

  add_index "contract_payments", ["contract_id"], name: "index_contract_payments_on_contract_id", using: :btree
  add_index "contract_payments", ["payment_form_id"], name: "index_contract_payments_on_payment_form_id", using: :btree
  add_index "contract_payments", ["payment_from_id"], name: "index_contract_payments_on_payment_from_id", using: :btree
  add_index "contract_payments", ["payment_sugestion_day_id"], name: "index_contract_payments_on_payment_sugestion_day_id", using: :btree

  create_table "contract_payments_payment_scopes", force: :cascade do |t|
    t.integer  "contract_payment_id", limit: 4
    t.integer  "payment_scope_id",    limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "contract_payments_payment_scopes", ["contract_payment_id"], name: "index_contract_payments_payment_scopes_on_contract_payment_id", using: :btree
  add_index "contract_payments_payment_scopes", ["payment_scope_id"], name: "index_contract_payments_payment_scopes_on_payment_scope_id", using: :btree

  create_table "contract_responsible_financials", force: :cascade do |t|
    t.integer  "contract_id", limit: 4
    t.string   "name",        limit: 255
    t.string   "office",      limit: 255
    t.string   "department",  limit: 255
    t.string   "whatsapp",    limit: 255
    t.string   "skype",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "contract_responsible_financials", ["contract_id"], name: "index_contract_responsible_financials_on_contract_id", using: :btree

  create_table "contract_responsibles", force: :cascade do |t|
    t.integer  "contract_id", limit: 4
    t.string   "name",        limit: 255
    t.string   "office",      limit: 255
    t.string   "department",  limit: 255
    t.string   "whatsapp",    limit: 255
    t.string   "skype",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "contract_responsibles", ["contract_id"], name: "index_contract_responsibles_on_contract_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.integer  "client_id",                    limit: 4
    t.string   "title",                        limit: 255
    t.string   "monthly_fixed_payment",        limit: 255
    t.string   "monthly_payment",              limit: 255
    t.string   "monthly_discount",             limit: 255
    t.date     "monthly_initial_date"
    t.date     "monthly_final_date"
    t.string   "comission_fixed_payment",      limit: 255
    t.string   "comission_payment",            limit: 255
    t.string   "comission_discount",           limit: 255
    t.date     "comission_initial_date"
    t.date     "comission_final_date"
    t.string   "fixed_value",                  limit: 255
    t.string   "comission_value",              limit: 255
    t.string   "discount_value",               limit: 255
    t.date     "pre_established_initial_date"
    t.date     "pre_established_final_date"
    t.boolean  "undetermined"
    t.text     "draft_contact",                limit: 4294967295
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "proposal_id",                  limit: 4
    t.integer  "user_id",                      limit: 4
    t.integer  "comercial_agent_id",           limit: 4
    t.integer  "intermediary_id",              limit: 4
    t.string   "fixed_value_intermediary",     limit: 255
    t.string   "discount_value_intermediary",  limit: 255
    t.string   "comission_value_intermediary", limit: 255
  end

  add_index "contracts", ["client_id"], name: "index_contracts_on_client_id", using: :btree
  add_index "contracts", ["proposal_id"], name: "index_contracts_on_proposal_id", using: :btree
  add_index "contracts", ["user_id"], name: "index_contracts_on_user_id", using: :btree

  create_table "contracts_users", id: false, force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "contract_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "contracts_users", ["contract_id"], name: "index_contracts_users_on_contract_id", using: :btree
  add_index "contracts_users", ["user_id"], name: "index_contracts_users_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "department_notifieds", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "diligent_profiles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "diligent_services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "efforts", force: :cascade do |t|
    t.integer  "bidding_id",     limit: 4
    t.string   "number",         limit: 255
    t.string   "value",          limit: 255
    t.date     "signature_date"
    t.date     "initial_date"
    t.date     "final_date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "efforts", ["bidding_id"], name: "index_efforts_on_bidding_id", using: :btree

  create_table "electronic_portals", force: :cascade do |t|
    t.integer  "organ_id",   limit: 4
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "electronic_portals", ["organ_id"], name: "index_electronic_portals_on_organ_id", using: :btree

  create_table "email_sectors", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.integer  "sector_id",  limit: 4
    t.integer  "organ_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "email_sectors", ["organ_id"], name: "index_email_sectors_on_organ_id", using: :btree
  add_index "email_sectors", ["sector_id"], name: "index_email_sectors_on_sector_id", using: :btree

  create_table "email_users", force: :cascade do |t|
    t.string   "email",                             limit: 255
    t.integer  "user_id",                           limit: 4
    t.integer  "registration_unit_id",              limit: 4
    t.integer  "responsible_registration_unit_id",  limit: 4
    t.integer  "client_contability_id",             limit: 4
    t.integer  "client_contact_id",                 limit: 4
    t.integer  "contract_responsible_id",           limit: 4
    t.integer  "contract_responsible_financial_id", limit: 4
    t.integer  "entity_class_responsible_id",       limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "email_users", ["client_contability_id"], name: "index_email_users_on_client_contability_id", using: :btree
  add_index "email_users", ["client_contact_id"], name: "index_email_users_on_client_contact_id", using: :btree
  add_index "email_users", ["contract_responsible_financial_id"], name: "index_email_users_on_contract_responsible_financial_id", using: :btree
  add_index "email_users", ["contract_responsible_id"], name: "index_email_users_on_contract_responsible_id", using: :btree
  add_index "email_users", ["entity_class_responsible_id"], name: "index_email_users_on_entity_class_responsible_id", using: :btree
  add_index "email_users", ["registration_unit_id"], name: "index_email_users_on_registration_unit_id", using: :btree
  add_index "email_users", ["responsible_registration_unit_id"], name: "index_email_users_on_responsible_registration_unit_id", using: :btree
  add_index "email_users", ["user_id"], name: "index_email_users_on_user_id", using: :btree

  create_table "emails", force: :cascade do |t|
    t.integer  "emailtable_id",   limit: 4,   null: false
    t.string   "emailtable_type", limit: 30,  null: false
    t.string   "email",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "email_type",      limit: 4
  end

  add_index "emails", ["emailtable_id", "emailtable_type"], name: "index_emails_on_emailtable_id_and_emailtable_type", using: :btree

  create_table "entity_class_responsibles", force: :cascade do |t|
    t.integer  "entity_class_id", limit: 4
    t.string   "name",            limit: 255
    t.string   "office",          limit: 255
    t.string   "department",      limit: 255
    t.string   "whatsapp",        limit: 255
    t.string   "skype",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "entity_class_responsibles", ["entity_class_id"], name: "index_entity_class_responsibles_on_entity_class_id", using: :btree

  create_table "entity_classes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "zipcode",     limit: 255
    t.string   "address",     limit: 255
    t.string   "number",      limit: 255
    t.string   "complement",  limit: 255
    t.string   "district",    limit: 255
    t.integer  "state_id",    limit: 4
    t.integer  "city_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "entity_classes", ["city_id"], name: "index_entity_classes_on_city_id", using: :btree
  add_index "entity_classes", ["state_id"], name: "index_entity_classes_on_state_id", using: :btree

  create_table "financial_invoices", force: :cascade do |t|
    t.integer  "bidding_id",            limit: 4
    t.date     "emission_date"
    t.date     "certify_date"
    t.date     "due_date_payment"
    t.string   "total_value",           limit: 255
    t.string   "organ_value",           limit: 255
    t.string   "received_value",        limit: 255
    t.string   "residual_value",        limit: 255
    t.date     "payment_date_residual"
    t.date     "liquidation_date"
    t.date     "payment_partner_date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "financial_invoices", ["bidding_id"], name: "index_financial_invoices_on_bidding_id", using: :btree

  create_table "financial_third_services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "financial_thirds", force: :cascade do |t|
    t.integer  "financial_id",               limit: 4
    t.integer  "third_type_id",              limit: 4
    t.integer  "third_id",                   limit: 4
    t.integer  "lawyer_id",                  limit: 4
    t.integer  "financial_third_service_id", limit: 4
    t.string   "name",                       limit: 255
    t.string   "fantasy_name",               limit: 255
    t.string   "social_name",                limit: 255
    t.string   "value",                      limit: 255
    t.string   "quantity",                   limit: 255
    t.date     "date"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "financial_thirds", ["financial_id"], name: "index_financial_thirds_on_financial_id", using: :btree
  add_index "financial_thirds", ["financial_third_service_id"], name: "index_financial_thirds_on_financial_third_service_id", using: :btree
  add_index "financial_thirds", ["lawyer_id"], name: "index_financial_thirds_on_lawyer_id", using: :btree
  add_index "financial_thirds", ["third_id"], name: "index_financial_thirds_on_third_id", using: :btree
  add_index "financial_thirds", ["third_type_id"], name: "index_financial_thirds_on_third_type_id", using: :btree

  create_table "financial_tickets", force: :cascade do |t|
    t.integer  "financial_id",        limit: 4
    t.date     "emission_date"
    t.date     "due_date"
    t.string   "ticket_file_name",    limit: 255
    t.string   "ticket_content_type", limit: 255
    t.integer  "ticket_file_size",    limit: 4
    t.datetime "ticket_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.date     "payment_date"
  end

  add_index "financial_tickets", ["financial_id"], name: "index_financial_tickets_on_financial_id", using: :btree

  create_table "financials", force: :cascade do |t|
    t.integer  "client_id",                limit: 4
    t.integer  "contract_id",              limit: 4
    t.string   "indication_value",         limit: 255
    t.string   "indication_pessoal",       limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "contractual_mulct",        limit: 255
    t.string   "reason_contractual_mulct", limit: 255
  end

  add_index "financials", ["client_id"], name: "index_financials_on_client_id", using: :btree
  add_index "financials", ["contract_id"], name: "index_financials_on_contract_id", using: :btree

  create_table "good_habits", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "habilitations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "honorary_forms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "judgment_forms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "judicial_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lawyer_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lawyers", force: :cascade do |t|
    t.integer  "lawyer_type_id",         limit: 4
    t.string   "name",                   limit: 255
    t.string   "office",                 limit: 255
    t.datetime "created_date"
    t.string   "cpf",                    limit: 255
    t.string   "cnpj",                   limit: 255
    t.string   "oab",                    limit: 255
    t.string   "municipal_registration", limit: 255
    t.integer  "honorary_form_id",       limit: 4
    t.string   "honorary_value",         limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "state_id",               limit: 4
    t.integer  "city_id",                limit: 4
  end

  add_index "lawyers", ["city_id"], name: "index_lawyers_on_city_id", using: :btree
  add_index "lawyers", ["honorary_form_id"], name: "index_lawyers_on_honorary_form_id", using: :btree
  add_index "lawyers", ["lawyer_type_id"], name: "index_lawyers_on_lawyer_type_id", using: :btree
  add_index "lawyers", ["state_id"], name: "index_lawyers_on_state_id", using: :btree

  create_table "lawyers_pieces", force: :cascade do |t|
    t.integer  "lawyer_id",  limit: 4
    t.integer  "piece_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lawyers_pieces", ["lawyer_id"], name: "index_lawyers_pieces_on_lawyer_id", using: :btree
  add_index "lawyers_pieces", ["piece_id"], name: "index_lawyers_pieces_on_piece_id", using: :btree

  create_table "libraries", force: :cascade do |t|
    t.integer  "library_category_id",   limit: 4
    t.string   "title",                 limit: 255
    t.string   "author_name",           limit: 255
    t.string   "edition",               limit: 255
    t.string   "year_publication",      limit: 255
    t.string   "publishing_company",    limit: 255
    t.string   "isbn",                  limit: 255
    t.string   "link",                  limit: 255
    t.datetime "sanctioned_date"
    t.string   "court",                 limit: 255
    t.integer  "state_id",              limit: 4
    t.integer  "city_id",               limit: 4
    t.string   "document_name",         limit: 255
    t.string   "process_number",        limit: 255
    t.datetime "process_date"
    t.string   "legislative_reference", limit: 255
    t.text     "description",           limit: 65535
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "libraries", ["city_id"], name: "index_libraries_on_city_id", using: :btree
  add_index "libraries", ["library_category_id"], name: "index_libraries_on_library_category_id", using: :btree
  add_index "libraries", ["state_id"], name: "index_libraries_on_state_id", using: :btree

  create_table "library_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "modalidates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "monthly_values", force: :cascade do |t|
    t.integer  "proposal_id",          limit: 4
    t.string   "percentual_discounts", limit: 255
    t.text     "observation",          limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "monthly_values", ["proposal_id"], name: "index_monthly_values_on_proposal_id", using: :btree

  create_table "motoboy_services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "action_notification_id", limit: 4
    t.integer  "area_notification_id",   limit: 4
    t.integer  "sender_id",              limit: 4
    t.integer  "receiver_id",            limit: 4
    t.string   "text",                   limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "notifications", ["action_notification_id"], name: "index_notifications_on_action_notification_id", using: :btree
  add_index "notifications", ["area_notification_id"], name: "index_notifications_on_area_notification_id", using: :btree

  create_table "observations", force: :cascade do |t|
    t.integer  "observationtable_id",   limit: 4,     null: false
    t.string   "observationtable_type", limit: 30,    null: false
    t.integer  "user_id",               limit: 4
    t.text     "observation",           limit: 65535
    t.integer  "type",                  limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "observation_type",      limit: 4
  end

  add_index "observations", ["observationtable_id", "observationtable_type"], name: "my_index", using: :btree
  add_index "observations", ["user_id"], name: "index_observations_on_user_id", using: :btree

  create_table "official_diaries", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "sphere_id",   limit: 4
    t.string   "name",        limit: 255
    t.string   "social_name", limit: 255
    t.string   "cnpj",        limit: 255
    t.string   "phone_brs",   limit: 255
    t.string   "email_brs",   limit: 255
    t.string   "site",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "official_diaries", ["sphere_id"], name: "index_official_diaries_on_sphere_id", using: :btree
  add_index "official_diaries", ["user_id"], name: "index_official_diaries_on_user_id", using: :btree

  create_table "organs", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "cnpj",                  limit: 255
    t.string   "site",                  limit: 255
    t.string   "email",                 limit: 255
    t.string   "phone",                 limit: 255
    t.string   "eletronic_portal",      limit: 255
    t.string   "address",               limit: 255
    t.string   "zipcode",               limit: 255
    t.string   "district",              limit: 255
    t.string   "number",                limit: 255
    t.string   "complement",            limit: 255
    t.string   "identification_number", limit: 255
    t.text     "observation",           limit: 65535
    t.integer  "city_id",               limit: 4
    t.integer  "state_id",              limit: 4
    t.integer  "sphere_id",             limit: 4
    t.integer  "organ_id",              limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "organs", ["city_id"], name: "index_organs_on_city_id", using: :btree
  add_index "organs", ["organ_id"], name: "index_organs_on_organ_id", using: :btree
  add_index "organs", ["sphere_id"], name: "index_organs_on_sphere_id", using: :btree
  add_index "organs", ["state_id"], name: "index_organs_on_state_id", using: :btree

  create_table "organs_portals", force: :cascade do |t|
    t.integer "organ_id",  limit: 4
    t.integer "portal_id", limit: 4
  end

  add_index "organs_portals", ["organ_id"], name: "index_organs_portals_on_organ_id", using: :btree
  add_index "organs_portals", ["portal_id"], name: "index_organs_portals_on_portal_id", using: :btree

  create_table "participation_results", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "partner_participations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "partner_ranks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "payment_forms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "payment_froms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "payment_scopes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "acronym",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "payment_sugestion_days", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "permission_profiles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "permission_profiles_users", force: :cascade do |t|
    t.integer "permission_profile_id", limit: 4
    t.integer "user_id",               limit: 4
  end

  add_index "permission_profiles_users", ["permission_profile_id"], name: "index_permission_profiles_users_on_permission_profile_id", using: :btree
  add_index "permission_profiles_users", ["user_id"], name: "index_permission_profiles_users_on_user_id", using: :btree

  create_table "phone_sectors", force: :cascade do |t|
    t.string   "phone",      limit: 255
    t.string   "extension",  limit: 255
    t.integer  "sector_id",  limit: 4
    t.integer  "organ_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "phone_sectors", ["organ_id"], name: "index_phone_sectors_on_organ_id", using: :btree
  add_index "phone_sectors", ["sector_id"], name: "index_phone_sectors_on_sector_id", using: :btree

  create_table "phone_users", force: :cascade do |t|
    t.string   "phone",                             limit: 255
    t.integer  "user_id",                           limit: 4
    t.integer  "registration_unit_id",              limit: 4
    t.integer  "responsible_registration_unit_id",  limit: 4
    t.integer  "client_contability_id",             limit: 4
    t.integer  "client_contact_id",                 limit: 4
    t.integer  "contract_responsible_id",           limit: 4
    t.integer  "contract_responsible_financial_id", limit: 4
    t.integer  "entity_class_responsible_id",       limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "phone_users", ["client_contability_id"], name: "index_phone_users_on_client_contability_id", using: :btree
  add_index "phone_users", ["client_contact_id"], name: "index_phone_users_on_client_contact_id", using: :btree
  add_index "phone_users", ["contract_responsible_financial_id"], name: "index_phone_users_on_contract_responsible_financial_id", using: :btree
  add_index "phone_users", ["contract_responsible_id"], name: "index_phone_users_on_contract_responsible_id", using: :btree
  add_index "phone_users", ["entity_class_responsible_id"], name: "index_phone_users_on_entity_class_responsible_id", using: :btree
  add_index "phone_users", ["registration_unit_id"], name: "index_phone_users_on_registration_unit_id", using: :btree
  add_index "phone_users", ["responsible_registration_unit_id"], name: "index_phone_users_on_responsible_registration_unit_id", using: :btree
  add_index "phone_users", ["user_id"], name: "index_phone_users_on_user_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.integer  "phonetable_id",   limit: 4,   null: false
    t.string   "phonetable_type", limit: 30,  null: false
    t.string   "phone",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "phone_type",      limit: 4
  end

  add_index "phones", ["phonetable_id", "phonetable_type"], name: "index_phones_on_phonetable_id_and_phonetable_type", using: :btree

  create_table "piece_historic_situations", force: :cascade do |t|
    t.integer  "piece_id",               limit: 4
    t.integer  "old_piece_situation_id", limit: 4
    t.integer  "new_piece_situation_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id",                limit: 4
    t.integer  "observation_id",         limit: 4
  end

  add_index "piece_historic_situations", ["new_piece_situation_id"], name: "index_piece_historic_situations_on_new_piece_situation_id", using: :btree
  add_index "piece_historic_situations", ["observation_id"], name: "index_piece_historic_situations_on_observation_id", using: :btree
  add_index "piece_historic_situations", ["old_piece_situation_id"], name: "index_piece_historic_situations_on_old_piece_situation_id", using: :btree
  add_index "piece_historic_situations", ["piece_id"], name: "index_piece_historic_situations_on_piece_id", using: :btree
  add_index "piece_historic_situations", ["user_id"], name: "index_piece_historic_situations_on_user_id", using: :btree

  create_table "piece_names", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "piece_process_files", force: :cascade do |t|
    t.string   "folder_name", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "piece_id",    limit: 4
  end

  add_index "piece_process_files", ["piece_id"], name: "index_piece_process_files_on_piece_id", using: :btree

  create_table "piece_results", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "piece_situations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pieces", force: :cascade do |t|
    t.integer  "piece_name_id",      limit: 4
    t.integer  "judicial_type_id",   limit: 4
    t.datetime "initial_date"
    t.datetime "deadline"
    t.integer  "piece_result_id",    limit: 4
    t.integer  "client_id",          limit: 4
    t.integer  "organ_id",           limit: 4
    t.string   "number",             limit: 255
    t.string   "process",            limit: 255
    t.string   "protocol_number",    limit: 255
    t.integer  "shipping_type_id",   limit: 4
    t.integer  "piece_situation_id", limit: 4
    t.integer  "modalidate_id",      limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "pieces", ["client_id"], name: "index_pieces_on_client_id", using: :btree
  add_index "pieces", ["judicial_type_id"], name: "index_pieces_on_judicial_type_id", using: :btree
  add_index "pieces", ["modalidate_id"], name: "index_pieces_on_modalidate_id", using: :btree
  add_index "pieces", ["organ_id"], name: "index_pieces_on_organ_id", using: :btree
  add_index "pieces", ["piece_name_id"], name: "index_pieces_on_piece_name_id", using: :btree
  add_index "pieces", ["piece_result_id"], name: "index_pieces_on_piece_result_id", using: :btree
  add_index "pieces", ["piece_situation_id"], name: "index_pieces_on_piece_situation_id", using: :btree
  add_index "pieces", ["shipping_type_id"], name: "index_pieces_on_shipping_type_id", using: :btree

  create_table "portals", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "client_id",         limit: 4
    t.string   "name",              limit: 255
    t.date     "initial_date"
    t.date     "final_date"
    t.string   "site",              limit: 255
    t.string   "phone",             limit: 255
    t.string   "email",             limit: 255
    t.string   "responsible",       limit: 255
    t.string   "registration_unit", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "portals", ["client_id"], name: "index_portals_on_client_id", using: :btree
  add_index "portals", ["user_id"], name: "index_portals_on_user_id", using: :btree

  create_table "post_office_services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "price_offers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "process_locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "process_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "proposal_historics", force: :cascade do |t|
    t.text     "comment",     limit: 65535
    t.integer  "proposal_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "proposal_historics", ["proposal_id"], name: "index_proposal_historics_on_proposal_id", using: :btree
  add_index "proposal_historics", ["user_id"], name: "index_proposal_historics_on_user_id", using: :btree

  create_table "proposal_situations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.integer  "client_id",             limit: 4
    t.integer  "proposal_situation_id", limit: 4
    t.text     "observation",           limit: 65535
    t.text     "notes",                 limit: 65535
    t.string   "title",                 limit: 255
    t.string   "cnpj",                  limit: 255
    t.string   "social_name",           limit: 255
    t.string   "fantasy_name",          limit: 255
    t.string   "proposed_value",        limit: 255
    t.string   "closed_value",          limit: 255
    t.string   "minimum_value",         limit: 255
    t.string   "proposed_percentage",   limit: 255
    t.string   "closed_percentage",     limit: 255
    t.string   "minimum_percentage",    limit: 255
    t.string   "commission_percentage", limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id",               limit: 4
    t.integer  "visits_report_id",      limit: 4
  end

  add_index "proposals", ["client_id"], name: "index_proposals_on_client_id", using: :btree
  add_index "proposals", ["proposal_situation_id"], name: "index_proposals_on_proposal_situation_id", using: :btree
  add_index "proposals", ["user_id"], name: "index_proposals_on_user_id", using: :btree
  add_index "proposals", ["visits_report_id"], name: "index_proposals_on_visits_report_id", using: :btree

  create_table "proposals_users", id: false, force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "proposal_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "proposals_users", ["proposal_id"], name: "index_proposals_users_on_proposal_id", using: :btree
  add_index "proposals_users", ["user_id"], name: "index_proposals_users_on_user_id", using: :btree

  create_table "provenances", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id",   limit: 4
    t.string   "readable_type", limit: 255, null: false
    t.integer  "reader_id",     limit: 4
    t.string   "reader_type",   limit: 255, null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true, using: :btree

  create_table "registration_forms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "registration_units", force: :cascade do |t|
    t.integer  "organ_id",             limit: 4
    t.string   "name",                 limit: 255
    t.string   "site",                 limit: 255
    t.string   "zipcode",              limit: 255
    t.string   "address",              limit: 255
    t.string   "district",             limit: 255
    t.string   "number",               limit: 255
    t.string   "complement",           limit: 255
    t.integer  "state_id",             limit: 4
    t.integer  "city_id",              limit: 4
    t.integer  "registration_unit_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "registration_units", ["city_id"], name: "index_registration_units_on_city_id", using: :btree
  add_index "registration_units", ["organ_id"], name: "index_registration_units_on_organ_id", using: :btree
  add_index "registration_units", ["registration_unit_id"], name: "index_registration_units_on_registration_unit_id", using: :btree
  add_index "registration_units", ["state_id"], name: "index_registration_units_on_state_id", using: :btree

  create_table "registry_services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "responsible_registration_units", force: :cascade do |t|
    t.integer  "registration_unit_id", limit: 4
    t.string   "name",                 limit: 255
    t.string   "office",               limit: 255
    t.string   "department",           limit: 255
    t.string   "whatsapp",             limit: 255
    t.string   "skype",                limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "responsible_registration_units", ["registration_unit_id"], name: "index_responsible_registration_units_on_registration_unit_id", using: :btree

  create_table "responsibles", force: :cascade do |t|
    t.integer  "responsibletable_id",   limit: 4,   null: false
    t.string   "responsibletable_type", limit: 30,  null: false
    t.string   "name",                  limit: 255
    t.string   "office",                limit: 255
    t.string   "department",            limit: 255
    t.string   "phone",                 limit: 255
    t.string   "email",                 limit: 255
    t.string   "skype",                 limit: 255
    t.string   "whatsapp",              limit: 255
    t.integer  "type",                  limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.date     "emission_date"
    t.string   "site",                  limit: 255
  end

  add_index "responsibles", ["responsibletable_id", "responsibletable_type"], name: "my_index", using: :btree

  create_table "results", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "scales", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sectors", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "office",           limit: 255
    t.text     "observation",      limit: 65535
    t.string   "responsible_name", limit: 255
    t.integer  "organ_id",         limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "department",       limit: 255
  end

  add_index "sectors", ["organ_id"], name: "index_sectors_on_organ_id", using: :btree

  create_table "shipping_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "skypes", force: :cascade do |t|
    t.integer  "skypetable_id",   limit: 4,   null: false
    t.string   "skypetable_type", limit: 30,  null: false
    t.string   "skype",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "skypes", ["skypetable_id", "skypetable_type"], name: "index_skypes_on_skypetable_id_and_skypetable_type", using: :btree

  create_table "spheres", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "acronym",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "subfolder_documents", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.integer  "client_document_type_id", limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "subfolder_documents", ["client_document_type_id"], name: "index_subfolder_documents_on_client_document_type_id", using: :btree

  create_table "third_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "thirds", force: :cascade do |t|
    t.string   "register_number",     limit: 255
    t.string   "name",                limit: 255
    t.string   "fantasy_name",        limit: 255
    t.string   "social_name",         limit: 255
    t.string   "rg",                  limit: 255
    t.string   "cpf",                 limit: 255
    t.integer  "diligent_profile_id", limit: 4
    t.integer  "third_type_id",       limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "cnpj",                limit: 255
    t.string   "phone",               limit: 255
  end

  add_index "thirds", ["diligent_profile_id"], name: "index_thirds_on_diligent_profile_id", using: :btree
  add_index "thirds", ["third_type_id"], name: "index_thirds_on_third_type_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "upload_proposals", force: :cascade do |t|
    t.integer  "proposal_id",       limit: 4
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "upload_proposals", ["proposal_id"], name: "index_upload_proposals_on_proposal_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.string   "password_digest",   limit: 255
    t.string   "recovery_token",    limit: 255
    t.datetime "last_access"
    t.string   "zipcode",           limit: 255
    t.string   "address",           limit: 255
    t.string   "district",          limit: 255
    t.string   "number",            limit: 255
    t.string   "complement",        limit: 255
    t.string   "office",            limit: 255
    t.string   "department",        limit: 255
    t.string   "rg",                limit: 255
    t.string   "cpf",               limit: 255
    t.date     "birth_date"
    t.string   "whatsapp",          limit: 255
    t.string   "skype",             limit: 255
    t.boolean  "is_blocked"
    t.string   "password_to_save",  limit: 255
    t.integer  "state_id",          limit: 4
    t.integer  "city_id",           limit: 4
    t.integer  "office_state_id",   limit: 4
    t.integer  "office_city_id",    limit: 4
    t.integer  "profile_id",        limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "calendar_color_id", limit: 4
    t.datetime "last_logout"
  end

  add_index "users", ["calendar_color_id"], name: "index_users_on_calendar_color_id", using: :btree
  add_index "users", ["city_id"], name: "index_users_on_city_id", using: :btree
  add_index "users", ["profile_id"], name: "index_users_on_profile_id", using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree

  create_table "visits_reports", force: :cascade do |t|
    t.integer  "client_id",             limit: 4
    t.string   "social_name",           limit: 255
    t.datetime "date_and_time"
    t.integer  "scale_id",              limit: 4
    t.string   "subject",               limit: 255
    t.string   "proposal_text",         limit: 255
    t.string   "site",                  limit: 255
    t.string   "responsible_name",      limit: 255
    t.string   "intermediary",          limit: 255
    t.string   "contacts",              limit: 255
    t.string   "phone",                 limit: 255
    t.string   "email",                 limit: 255
    t.string   "segment",               limit: 255
    t.string   "cnpj",                  limit: 255
    t.string   "products_and_services", limit: 255
    t.boolean  "bid_participant"
    t.boolean  "participate_brs"
    t.text     "observation",           limit: 65535
    t.integer  "user_id",               limit: 4
    t.string   "zipcode",               limit: 255
    t.string   "address",               limit: 255
    t.string   "district",              limit: 255
    t.string   "number",                limit: 255
    t.string   "complement",            limit: 255
    t.boolean  "shared"
    t.integer  "state_id",              limit: 4
    t.integer  "city_id",               limit: 4
    t.float    "lat",                   limit: 24
    t.float    "lng",                   limit: 24
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fantasy_name",          limit: 255
  end

  add_index "visits_reports", ["city_id"], name: "index_visits_reports_on_city_id", using: :btree
  add_index "visits_reports", ["client_id"], name: "index_visits_reports_on_client_id", using: :btree
  add_index "visits_reports", ["scale_id"], name: "index_visits_reports_on_scale_id", using: :btree
  add_index "visits_reports", ["state_id"], name: "index_visits_reports_on_state_id", using: :btree
  add_index "visits_reports", ["user_id"], name: "index_visits_reports_on_user_id", using: :btree

  create_table "weekdays", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "acronym",    limit: 255
    t.integer  "value",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "words_keys", force: :cascade do |t|
    t.string   "word",              limit: 255
    t.integer  "client_segment_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "library_id",        limit: 4
  end

  add_index "words_keys", ["client_segment_id"], name: "index_words_keys_on_client_segment_id", using: :btree
  add_index "words_keys", ["library_id"], name: "index_words_keys_on_library_id", using: :btree

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "states"
  add_foreign_key "bid_newspapers", "clients"
  add_foreign_key "bid_newspapers", "users"
  add_foreign_key "bidding_proposals", "bidder_statuses"
  add_foreign_key "bidding_proposals", "biddings"
  add_foreign_key "bidding_proposals", "competition_statuses"
  add_foreign_key "bidding_proposals", "countries"
  add_foreign_key "bidding_proposals", "judgment_forms"
  add_foreign_key "bidding_proposals", "participation_results"
  add_foreign_key "bidding_proposals", "partner_ranks"
  add_foreign_key "bidding_proposals", "price_offers"
  add_foreign_key "bidding_proposals", "provenances"
  add_foreign_key "bidding_proposals", "registration_forms"
  add_foreign_key "bidding_proposals", "units"
  add_foreign_key "bidding_resources", "bidding_proposals"
  add_foreign_key "bidding_resources", "biddings"
  add_foreign_key "bidding_resources", "results"
  add_foreign_key "bidding_responsibles", "biddings"
  add_foreign_key "bidding_responsibles", "users"
  add_foreign_key "calendar_events", "calendar_colors"
  add_foreign_key "calendar_events", "calendar_events"
  add_foreign_key "calendar_events", "calendar_repetitions"
  add_foreign_key "calendar_events", "calendar_type_events"
  add_foreign_key "calendar_events", "cities"
  add_foreign_key "calendar_events", "entity_classes"
  add_foreign_key "calendar_events", "states"
  add_foreign_key "calendar_events", "users"
  add_foreign_key "calendar_events_users", "calendar_events"
  add_foreign_key "calendar_events_users", "users"
  add_foreign_key "calendar_events_weekdays", "calendar_events"
  add_foreign_key "calendar_events_weekdays", "weekdays"
  add_foreign_key "cities", "states"
  add_foreign_key "client_banks", "account_bank_types"
  add_foreign_key "client_banks", "clients"
  add_foreign_key "client_clients", "clients"
  add_foreign_key "client_contabilities", "cities"
  add_foreign_key "client_contabilities", "clients"
  add_foreign_key "client_contabilities", "states"
  add_foreign_key "client_contacts", "cities"
  add_foreign_key "client_contacts", "client_classes"
  add_foreign_key "client_contacts", "client_contact_types"
  add_foreign_key "client_contacts", "clients"
  add_foreign_key "client_contacts", "states"
  add_foreign_key "client_documents", "client_document_notifications"
  add_foreign_key "client_documents", "client_document_statuses"
  add_foreign_key "client_documents", "client_document_types"
  add_foreign_key "client_documents", "clients"
  add_foreign_key "client_documents", "subfolder_documents"
  add_foreign_key "client_segments", "clients"
  add_foreign_key "clients", "client_classes"
  add_foreign_key "clients", "client_company_sizes"
  add_foreign_key "clients", "client_periodicities"
  add_foreign_key "clients", "client_statuses"
  add_foreign_key "clients", "client_types"
  add_foreign_key "clients", "clients"
  add_foreign_key "clients", "proposals"
  add_foreign_key "clients_users", "clients"
  add_foreign_key "clients_users", "users"
  add_foreign_key "communications", "clients"
  add_foreign_key "communications", "communication_statuses"
  add_foreign_key "communications", "department_notifieds"
  add_foreign_key "communications", "modalidates"
  add_foreign_key "communications", "organs"
  add_foreign_key "communications", "users"
  add_foreign_key "contability_contacts", "client_contabilities"
  add_foreign_key "contability_secondary_contacts", "client_contabilities"
  add_foreign_key "contract_payments", "contracts"
  add_foreign_key "contract_payments", "payment_forms"
  add_foreign_key "contract_payments", "payment_froms"
  add_foreign_key "contract_payments", "payment_sugestion_days"
  add_foreign_key "contract_payments_payment_scopes", "contract_payments"
  add_foreign_key "contract_payments_payment_scopes", "payment_scopes"
  add_foreign_key "contract_responsible_financials", "contracts"
  add_foreign_key "contract_responsibles", "contracts"
  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "proposals"
  add_foreign_key "contracts", "users"
  add_foreign_key "contracts_users", "contracts"
  add_foreign_key "contracts_users", "users"
  add_foreign_key "efforts", "biddings"
  add_foreign_key "electronic_portals", "organs"
  add_foreign_key "email_sectors", "organs"
  add_foreign_key "email_sectors", "sectors"
  add_foreign_key "email_users", "client_contabilities"
  add_foreign_key "email_users", "client_contacts"
  add_foreign_key "email_users", "contract_responsible_financials"
  add_foreign_key "email_users", "contract_responsibles"
  add_foreign_key "email_users", "entity_class_responsibles"
  add_foreign_key "email_users", "registration_units"
  add_foreign_key "email_users", "responsible_registration_units"
  add_foreign_key "email_users", "users"
  add_foreign_key "entity_class_responsibles", "entity_classes"
  add_foreign_key "entity_classes", "cities"
  add_foreign_key "entity_classes", "states"
  add_foreign_key "financial_invoices", "biddings"
  add_foreign_key "financial_thirds", "financial_third_services"
  add_foreign_key "financial_thirds", "financials"
  add_foreign_key "financial_thirds", "lawyers"
  add_foreign_key "financial_thirds", "third_types"
  add_foreign_key "financial_thirds", "thirds"
  add_foreign_key "financial_tickets", "financials"
  add_foreign_key "financials", "clients"
  add_foreign_key "financials", "contracts"
  add_foreign_key "lawyers", "cities"
  add_foreign_key "lawyers", "honorary_forms"
  add_foreign_key "lawyers", "lawyer_types"
  add_foreign_key "lawyers", "states"
  add_foreign_key "libraries", "cities"
  add_foreign_key "libraries", "library_categories"
  add_foreign_key "libraries", "states"
  add_foreign_key "monthly_values", "proposals"
  add_foreign_key "notifications", "action_notifications"
  add_foreign_key "notifications", "area_notifications"
  add_foreign_key "observations", "users"
  add_foreign_key "official_diaries", "spheres"
  add_foreign_key "official_diaries", "users"
  add_foreign_key "organs", "cities"
  add_foreign_key "organs", "organs"
  add_foreign_key "organs", "spheres"
  add_foreign_key "organs", "states"
  add_foreign_key "phone_sectors", "organs"
  add_foreign_key "phone_sectors", "sectors"
  add_foreign_key "phone_users", "client_contabilities"
  add_foreign_key "phone_users", "client_contacts"
  add_foreign_key "phone_users", "contract_responsible_financials"
  add_foreign_key "phone_users", "contract_responsibles"
  add_foreign_key "phone_users", "entity_class_responsibles"
  add_foreign_key "phone_users", "registration_units"
  add_foreign_key "phone_users", "responsible_registration_units"
  add_foreign_key "phone_users", "users"
  add_foreign_key "piece_historic_situations", "observations"
  add_foreign_key "piece_historic_situations", "pieces"
  add_foreign_key "piece_historic_situations", "users"
  add_foreign_key "piece_process_files", "pieces"
  add_foreign_key "pieces", "clients"
  add_foreign_key "pieces", "judicial_types"
  add_foreign_key "pieces", "modalidates"
  add_foreign_key "pieces", "organs"
  add_foreign_key "pieces", "piece_names"
  add_foreign_key "pieces", "piece_results"
  add_foreign_key "pieces", "piece_situations"
  add_foreign_key "pieces", "shipping_types"
  add_foreign_key "portals", "clients"
  add_foreign_key "portals", "users"
  add_foreign_key "proposal_historics", "proposals"
  add_foreign_key "proposal_historics", "users"
  add_foreign_key "proposals", "clients"
  add_foreign_key "proposals", "proposal_situations"
  add_foreign_key "proposals", "users"
  add_foreign_key "proposals", "visits_reports"
  add_foreign_key "proposals_users", "proposals"
  add_foreign_key "proposals_users", "users"
  add_foreign_key "registration_units", "cities"
  add_foreign_key "registration_units", "organs"
  add_foreign_key "registration_units", "registration_units"
  add_foreign_key "registration_units", "states"
  add_foreign_key "responsible_registration_units", "registration_units"
  add_foreign_key "sectors", "organs"
  add_foreign_key "subfolder_documents", "client_document_types"
  add_foreign_key "thirds", "diligent_profiles"
  add_foreign_key "thirds", "third_types"
  add_foreign_key "upload_proposals", "proposals"
  add_foreign_key "users", "calendar_colors"
  add_foreign_key "users", "cities"
  add_foreign_key "users", "profiles"
  add_foreign_key "users", "states"
  add_foreign_key "visits_reports", "cities"
  add_foreign_key "visits_reports", "clients"
  add_foreign_key "visits_reports", "scales"
  add_foreign_key "visits_reports", "states"
  add_foreign_key "visits_reports", "users"
  add_foreign_key "words_keys", "client_segments"
  add_foreign_key "words_keys", "libraries"
end
