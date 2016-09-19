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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140925004533) do

  create_table "addresses", :force => true do |t|
    t.integer "addressable_id"
    t.string  "addressable_type"
    t.string  "name"
    t.string  "country"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "lat"
    t.string  "long"
  end

  create_table "api_keys", :force => true do |t|
    t.string   "company_name"
    t.string   "application_name"
    t.string   "key"
    t.string   "contact_email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "api_keys", ["key"], :name => "index_api_keys_on_key"

  create_table "appliance_manufacturers", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "appliance_models", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "appliance_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "appliances", :force => true do |t|
    t.integer  "binder_id"
    t.string   "name"
    t.integer  "appliance_type_id"
    t.integer  "appliance_manufacturer_id"
    t.integer  "appliance_model_id"
    t.string   "model_number"
    t.string   "serial_no"
    t.string   "warranty"
    t.string   "user_guide_url"
    t.text     "details"
    t.integer  "created_by"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.date     "last_recall_check"
    t.string   "upc"
    t.string   "appliance_type"
    t.string   "manufacturer"
    t.string   "model"
    t.date     "install_date"
  end

  create_table "area_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "areas", :force => true do |t|
    t.integer  "binder_id"
    t.string   "name"
    t.integer  "structure_id"
    t.text     "details"
    t.string   "dimensions"
    t.integer  "area_type_id"
    t.integer  "created_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "area_type"
  end

  create_table "areas_paints", :id => false, :force => true do |t|
    t.integer "area_id"
    t.integer "paint_id"
  end

  create_table "binder_contractors", :force => true do |t|
    t.integer  "binder_id"
    t.integer  "contractor_id"
    t.integer  "created_by"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "details"
    t.string   "account_number"
    t.string   "contact"
  end

  create_table "binders", :force => true do |t|
    t.string   "name"
    t.boolean  "primary"
    t.boolean  "active",     :default => true
    t.integer  "created_by"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "binders_users", :id => false, :force => true do |t|
    t.integer "binder_id"
    t.integer "user_id"
  end

  create_table "building_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "construction_styles", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "construction_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "contractor_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "contractors", :force => true do |t|
    t.integer  "contractor_type_id"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "url"
    t.string   "account_number"
    t.string   "contact"
    t.text     "details"
    t.integer  "created_by"
    t.boolean  "verified"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "contractor_type"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "documents", :force => true do |t|
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.string   "name"
    t.string   "location"
    t.string   "key"
    t.string   "bucket"
    t.string   "etag"
    t.text     "details"
    t.integer  "created_by"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "binder_id"
    t.integer  "file_size"
  end

  create_table "finish_makes", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "finish_models", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "finishes", :force => true do |t|
    t.integer  "binder_id"
    t.string   "name"
    t.integer  "finish_make_id"
    t.integer  "finish_model_id"
    t.string   "style_color"
    t.text     "details"
    t.integer  "created_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "make"
    t.string   "model"
  end

  create_table "free_trials", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "partner_type"
    t.string   "trial_type"
    t.string   "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "comments"
  end

  create_table "heat_sources", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "heat_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "images", :force => true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "location"
    t.string   "key"
    t.string   "bucket"
    t.string   "etag"
    t.text     "details"
    t.integer  "created_by"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "binder_id"
    t.integer  "file_size"
    t.string   "name"
  end

  create_table "inventory_item_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "inventory_items", :force => true do |t|
    t.integer  "binder_id"
    t.integer  "inventory_item_type_id"
    t.string   "name"
    t.integer  "value_cents",            :default => 0,     :null => false
    t.string   "value_currency",         :default => "USD", :null => false
    t.text     "details"
    t.integer  "created_by"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "inventory_item_type"
  end

  create_table "logos", :force => true do |t|
    t.integer  "partner_id"
    t.string   "name"
    t.string   "location"
    t.string   "key"
    t.string   "bucket"
    t.string   "etag"
    t.text     "details"
    t.integer  "created_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "maintenance_cycles", :force => true do |t|
    t.string "name"
  end

  create_table "maintenance_events", :force => true do |t|
    t.integer  "maintenance_item_id"
    t.integer  "contractor_id"
    t.date     "do_date"
    t.date     "completed_date"
    t.integer  "created_by"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "maintenance_items", :force => true do |t|
    t.integer  "binder_id"
    t.integer  "appliance_id"
    t.integer  "area_id"
    t.integer  "structure_id"
    t.integer  "maintenance_type_id"
    t.integer  "maintenance_cycle_id"
    t.string   "name"
    t.text     "details"
    t.integer  "interval"
    t.integer  "created_by"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "maintenance_type"
    t.string   "maintenance_cycle"
  end

  create_table "maintenance_types", :force => true do |t|
    t.string  "name"
    t.integer "interval"
    t.integer "maintenance_cycle_id"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "notes", :force => true do |t|
    t.text     "content"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.integer  "access_level"
    t.integer  "created_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "paint_manufacturers", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "paint_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "paints", :force => true do |t|
    t.integer  "created_by"
    t.integer  "binder_id"
    t.string   "name"
    t.integer  "paint_manufacturer_id"
    t.string   "code"
    t.string   "makeup"
    t.text     "details"
    t.integer  "paint_type_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "paint_type"
    t.string   "manufacturer"
  end

  create_table "partners", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "contact"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "code"
    t.string   "partner_type"
    t.integer  "binder_logo_id"
    t.integer  "sellers_logo_id"
  end

  create_table "pdfs", :force => true do |t|
    t.integer  "pdfable_id"
    t.string   "pdfable_type"
    t.string   "location"
    t.string   "key"
    t.string   "bucket"
    t.string   "etag"
    t.string   "details"
    t.integer  "created_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "project_statuses", :force => true do |t|
    t.string "name"
  end

  create_table "project_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "projects", :force => true do |t|
    t.integer  "binder_id"
    t.integer  "project_type_id"
    t.integer  "project_status_id"
    t.string   "name"
    t.text     "details"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "cost_cents",        :default => 0,     :null => false
    t.string   "cost_currency",     :default => "USD", :null => false
    t.integer  "created_by"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "project_type"
    t.string   "status"
  end

  create_table "promo_codes", :force => true do |t|
    t.integer  "partner_id"
    t.string   "coupon_id"
    t.boolean  "active"
    t.boolean  "RevenueShare"
    t.string   "share_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "properties", :force => true do |t|
    t.integer  "binder_id"
    t.integer  "property_type_id"
    t.string   "apn"
    t.string   "country"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "county"
    t.string   "lat"
    t.string   "long"
    t.text     "details"
    t.decimal  "acres"
    t.integer  "created_by"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "property_type"
  end

  create_table "property_types", :force => true do |t|
    t.string  "name"
    t.integer "created_by"
    t.boolean "verified"
  end

  create_table "purchases", :force => true do |t|
    t.integer  "store_id"
    t.date     "date"
    t.integer  "price_cents",       :default => 0,     :null => false
    t.string   "price_currency",    :default => "USD", :null => false
    t.integer  "created_by"
    t.integer  "purchaseable_id"
    t.string   "purchaseable_type"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "receipts", :force => true do |t|
    t.integer  "binder_id"
    t.string   "name"
    t.text     "details"
    t.boolean  "deductable"
    t.integer  "created_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "seller_report_items", :force => true do |t|
    t.integer "seller_reportable_id"
    t.string  "seller_reportable_type"
    t.boolean "include"
    t.integer "sort_index"
  end

  create_table "seller_reports", :force => true do |t|
    t.integer  "binder_id"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "public"
  end

  create_table "sessions", :force => true do |t|
    t.string   "token"
    t.string   "user_token"
    t.integer  "binder_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shares", :force => true do |t|
    t.integer  "shared_by_id"
    t.integer  "shared_with_id"
    t.string   "shared_with_email"
    t.integer  "sharable_id"
    t.string   "sharable_type"
    t.string   "role_name"
    t.string   "status"
    t.boolean  "expirable"
    t.date     "expires_on"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "shares", ["shared_by_id"], :name => "index_shares_on_shared_by_id"
  add_index "shares", ["shared_with_id"], :name => "index_shares_on_shared_with_id"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.integer  "created_by"
    t.boolean  "verified"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "structures", :force => true do |t|
    t.integer  "binder_id"
    t.string   "name"
    t.integer  "year_built"
    t.integer  "beds"
    t.decimal  "baths"
    t.integer  "sq_ft"
    t.integer  "building_type_id"
    t.integer  "construction_style_id"
    t.integer  "construction_type_id"
    t.integer  "heat_type_id"
    t.integer  "heat_source_id"
    t.text     "details"
    t.integer  "created_by"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "building_type"
    t.string   "construction_type"
    t.string   "construction_style"
    t.string   "heat_type"
    t.string   "heat_source"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "binder_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "plan_id"
    t.string   "customer_id"
    t.string   "payment_status"
  end

  create_table "tags", :force => true do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.string   "tag"
    t.boolean  "auto_generated", :default => true
    t.integer  "created_by"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "transfers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "binder_id"
    t.string   "transfer_to"
    t.string   "transfer_type"
    t.string   "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "uploaders", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.date     "dob"
    t.string   "sex"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "monthly_email", :default => true
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",     :null => false
    t.string   "encrypted_password",     :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "account_type",           :default => "user"
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "authentication_token"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
