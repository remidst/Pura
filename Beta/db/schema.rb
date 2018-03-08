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

ActiveRecord::Schema.define(version: 20180308165837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "care_manager_id"
    t.bigint "service_provider_id"
    t.string "email"
    t.index ["care_manager_id"], name: "index_contacts_on_care_manager_id"
    t.index ["service_provider_id"], name: "index_contacts_on_service_provider_id"
  end

  create_table "conversation_users", force: :cascade do |t|
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_conversation_users_on_conversation_id"
    t.index ["user_id"], name: "index_conversation_users_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_conversations_on_project_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.string "category"
    t.string "name"
    t.bigint "publisher_id"
    t.index ["id"], name: "index_documents_on_id"
    t.index ["project_id"], name: "index_documents_on_project_id"
    t.index ["publisher_id"], name: "index_documents_on_publisher_id"
  end

  create_table "documentships", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_documentships_on_document_id"
    t.index ["user_id"], name: "index_documentships_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["project_id"], name: "index_memberships_on_project_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "conversation_id"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["id"], name: "index_messages_on_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.text "content"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_notifications_on_project_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "leader_id"
    t.index ["leader_id"], name: "index_projects_on_leader_id"
  end

  create_table "publication_attachments", force: :cascade do |t|
    t.bigint "publication_id"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_attachments_on_publication_id"
  end

  create_table "publication_comment_attachments", force: :cascade do |t|
    t.bigint "publication_comment_id"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_comment_id"], name: "index_publication_comment_attachments_on_publication_comment_id"
  end

  create_table "publication_comment_readmarks", force: :cascade do |t|
    t.boolean "read"
    t.bigint "publication_comment_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_comment_id"], name: "index_publication_comment_readmarks_on_publication_comment_id"
    t.index ["user_id"], name: "index_publication_comment_readmarks_on_user_id"
  end

  create_table "publication_comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "publisher_id"
    t.index ["publication_id"], name: "index_publication_comments_on_publication_id"
    t.index ["publisher_id"], name: "index_publication_comments_on_publisher_id"
  end

  create_table "publication_readmarks", force: :cascade do |t|
    t.bigint "publication_id"
    t.bigint "user_id"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_readmarks_on_publication_id"
    t.index ["user_id"], name: "index_publication_readmarks_on_user_id"
  end

  create_table "publications", force: :cascade do |t|
    t.text "message"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "publisher_id"
    t.index ["project_id"], name: "index_publications_on_project_id"
    t.index ["publisher_id"], name: "index_publications_on_publisher_id"
  end

  create_table "readmarks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "message_id"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_readmarks_on_message_id"
    t.index ["user_id"], name: "index_readmarks_on_user_id"
  end

  create_table "reporting_attachments", force: :cascade do |t|
    t.bigint "reporting_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment"
    t.index ["reporting_id"], name: "index_reporting_attachments_on_reporting_id"
  end

  create_table "reporting_readmarks", force: :cascade do |t|
    t.boolean "read"
    t.bigint "reporting_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reporting_id"], name: "index_reporting_readmarks_on_reporting_id"
    t.index ["user_id"], name: "index_reporting_readmarks_on_user_id"
  end

  create_table "reportings", force: :cascade do |t|
    t.string "title"
    t.text "message"
    t.bigint "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "publisher_id"
    t.boolean "confirmed"
    t.index ["contact_id"], name: "index_reportings_on_contact_id"
    t.index ["publisher_id"], name: "index_reportings_on_publisher_id"
  end

  create_table "specs", force: :cascade do |t|
    t.bigint "project_id"
    t.date "creation_date"
    t.integer "insurance_number"
    t.boolean "gender"
    t.date "birthday"
    t.text "address"
    t.string "phone"
    t.string "cellphone"
    t.string "kaigo_level"
    t.date "kaigo_validity_from"
    t.date "kaigo_validity_until"
    t.string "dependency_physical"
    t.string "dependency_mental"
    t.string "handicap_physical"
    t.string "home_is_owner"
    t.string "economics"
    t.string "emergency_contact_name"
    t.text "emergency_contact_relation"
    t.string "emergency_contact_address_phone"
    t.string "emergency_contact_name_2"
    t.text "emergency_contact_relation_2"
    t.string "emergency_contact_address_phone_2"
    t.string "emergency_contact_name_3"
    t.text "emergency_contact_relation_3"
    t.string "emergency_contact_address_phone_3"
    t.text "genogram"
    t.string "doctor_name"
    t.string "hospital_name"
    t.string "doctor_phone"
    t.text "doctor_address"
    t.string "disease_from"
    t.string "disease_name"
    t.string "disease_doctor"
    t.text "disease_evolution"
    t.date "disease_from_2"
    t.string "disease_name_2"
    t.string "disease_doctor_2"
    t.string "disease_evolution_2"
    t.text "other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "publisher_id"
    t.string "handicap_rehabilitation"
    t.string "handicap_psychological"
    t.string "handicap_disease"
    t.boolean "home_is_house"
    t.boolean "home_has_room"
    t.boolean "home_has_stairs"
    t.date "evaluation_date"
    t.integer "payment_ratio"
    t.integer "insurance_issuer"
    t.integer "birthday_era"
    t.integer "birthday_year"
    t.integer "birthday_month"
    t.integer "birthday_day"
    t.index ["project_id"], name: "index_specs_on_project_id"
    t.index ["publisher_id"], name: "index_specs_on_publisher_id"
  end

  create_table "timelines", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_timelines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "company"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "deleted_at"
    t.string "authentication_token", limit: 30
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contacts", "users", column: "care_manager_id"
  add_foreign_key "contacts", "users", column: "service_provider_id"
  add_foreign_key "documents", "projects"
  add_foreign_key "documents", "users", column: "publisher_id"
  add_foreign_key "documentships", "documents"
  add_foreign_key "documentships", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "projects"
  add_foreign_key "notifications", "users"
  add_foreign_key "projects", "users", column: "leader_id"
  add_foreign_key "publication_attachments", "publications"
  add_foreign_key "publication_comment_attachments", "publication_comments"
  add_foreign_key "publication_comments", "publications"
  add_foreign_key "publication_comments", "users", column: "publisher_id"
  add_foreign_key "publication_readmarks", "publications"
  add_foreign_key "publication_readmarks", "users"
  add_foreign_key "publications", "users", column: "publisher_id"
  add_foreign_key "readmarks", "messages"
  add_foreign_key "readmarks", "users"
  add_foreign_key "reporting_attachments", "reportings"
  add_foreign_key "reporting_readmarks", "reportings"
  add_foreign_key "reporting_readmarks", "users"
  add_foreign_key "reportings", "contacts"
  add_foreign_key "reportings", "users", column: "publisher_id"
  add_foreign_key "specs", "projects"
  add_foreign_key "specs", "users", column: "publisher_id"
  add_foreign_key "timelines", "users"
end
