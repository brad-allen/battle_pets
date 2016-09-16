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

ActiveRecord::Schema.define(version: 20160908164438) do

  create_table "accounts", force: :cascade do |t|
    t.string   "username"
    t.string   "about"
    t.integer  "user_id"
    t.string   "email"
    t.string   "image"
    t.string   "permission"
    t.string   "status"
    t.integer  "level",      default: 1, null: false
    t.integer  "experience", default: 0, null: false
    t.integer  "gold",       default: 0, null: false
    t.integer  "won",        default: 0, null: false
    t.integer  "lost",       default: 0, null: false
    t.integer  "tied",       default: 0, null: false
    t.string   "town"
    t.string   "planet"
    t.string   "galaxy"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["email"], name: "accounts_email_idx"
    t.index ["gold"], name: "accounts_gold_idx"
    t.index ["status"], name: "accounts_status_idx"
    t.index ["user_id"], name: "accounts_user_id_idx"
    t.index ["username"], name: "accounts_username_idx"
    t.index ["won"], name: "accounts_won_idx"
  end

  create_table "arenas", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "rated"
    t.string   "url"
    t.integer  "port"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "arenas_name_idx"
    t.index ["rated"], name: "arenas_rated_idx"
  end

  create_table "battle_pets", force: :cascade do |t|
    t.string   "name"
    t.string   "about"
    t.string   "image"
    t.integer  "level",                                default: 1,     null: false
    t.integer  "experience",                           default: 0,     null: false
    t.integer  "won",                                  default: 0,     null: false
    t.integer  "lost",                                 default: 0,     null: false
    t.integer  "tied",                                 default: 0,     null: false
    t.string   "town"
    t.string   "planet"
    t.string   "galaxy"
    t.boolean  "retired",                              default: false, null: false
    t.boolean  "auto_accept_play_for_points_requests", default: false, null: false
    t.string   "status"
    t.integer  "account_id"
    t.integer  "previous_owner_id"
    t.integer  "original_owner_id"
    t.integer  "strength",                             default: 0,     null: false
    t.integer  "agility",                              default: 0,     null: false
    t.integer  "wit",                                  default: 0,     null: false
    t.integer  "speed",                                default: 0,     null: false
    t.integer  "wisdom",                               default: 0,     null: false
    t.integer  "intelligence",                         default: 0,     null: false
    t.integer  "magic",                                default: 0,     null: false
    t.integer  "chi",                                  default: 0,     null: false
    t.integer  "healing_power",                        default: 0,     null: false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["account_id"], name: "battle_pets_account_id_idx"
    t.index ["experience"], name: "battle_pets_experience_idx"
    t.index ["name"], name: "battle_pets_name_idx"
    t.index ["won"], name: "battle_pets_won_idx"
  end

  create_table "battles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "call_auth_code"
    t.integer  "arena_id"
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "pet1_id"
    t.integer  "pet2_id"
    t.datetime "battled_on"
    t.integer  "winning_pet_id"
    t.integer  "winning_user_id"
    t.integer  "battle_game_id"
    t.string   "status"
    t.decimal  "score"
    t.boolean  "play_for_keeps",    default: false, null: false
    t.boolean  "is_tie",            default: false, null: false
    t.integer  "winner_experience", default: 0,     null: false
    t.integer  "loser_experience",  default: 0,     null: false
    t.integer  "winner_gold",       default: 0,     null: false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["battled_on"], name: "battles_battled_on_idx"
    t.index ["call_auth_code"], name: "battles_call_auth_code_idx"
    t.index ["name"], name: "battles_name_idx"
    t.index ["pet1_id"], name: "battles_pet1_id_idx"
    t.index ["pet2_id"], name: "battles_pet2_id_idx"
    t.index ["user1_id"], name: "battles_user1_id_idx"
    t.index ["user2_id"], name: "battles_user2_id_idx"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
