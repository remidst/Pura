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

ActiveRecord::Schema.define(version: 20171125023649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "care_manager_id"
    t.bigint "service_provider_id"
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

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.integer "project_id"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "read_marks", id: :serial, force: :cascade do |t|
    t.string "readable_type"
    t.integer "readable_id"
    t.string "reader_type"
    t.integer "reader_id"
    t.datetime "timestamp"
    t.index ["readable_type", "readable_id"], name: "index_read_marks_on_readable_type_and_readable_id"
    t.index ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true
    t.index ["reader_type", "reader_id"], name: "index_read_marks_on_reader_type_and_reader_id"
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
    t.index ["reporting_id"], name: "index_reporting_attachments_on_reporting_id"
  end

  create_table "reportings", force: :cascade do |t|
    t.string "title"
    t.text "message"
    t.bigint "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_reportings_on_contact_id"
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
    t.string "disease_evolution"
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
    t.index ["project_id"], name: "index_specs_on_project_id"
    t.index ["publisher_id"], name: "index_specs_on_publisher_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
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
  add_foreign_key "readmarks", "messages"
  add_foreign_key "readmarks", "users"
  add_foreign_key "reporting_attachments", "reportings"
  add_foreign_key "reportings", "contacts"
  add_foreign_key "specs", "projects"
  add_foreign_key "specs", "users", column: "publisher_id"
end
