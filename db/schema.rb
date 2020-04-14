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

ActiveRecord::Schema.define(version: 2020_03_14_060121) do

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "micropost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_favorites_on_micropost_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.string "introduce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "micropost_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_images_on_micropost_id"
  end

  create_table "members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.boolean "activate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invited", default: false
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["group_id"], name: "index_messages_on_group_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "microposts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reply_id"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "visited_id"
    t.bigint "member_id"
    t.string "action"
    t.boolean "checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "micropost_id"
    t.bigint "relationship_id"
    t.index ["member_id"], name: "index_notifications_on_member_id"
    t.index ["micropost_id"], name: "index_notifications_on_micropost_id"
    t.index ["relationship_id"], name: "index_notifications_on_relationship_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
  end

  create_table "participates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_participates_on_plan_id"
    t.index ["user_id", "plan_id"], name: "index_participates_on_user_id_and_plan_id", unique: true
    t.index ["user_id"], name: "index_participates_on_user_id"
  end

  create_table "plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "place"
    t.datetime "datetime"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
    t.float "latitude"
    t.float "longitude"
    t.index ["group_id"], name: "index_plans_on_group_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["user_id", "followed_id"], name: "index_relationships_on_user_id_and_followed_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "bike"
    t.integer "age"
    t.boolean "activated", default: false
    t.string "activation_digest"
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "favorites", "microposts"
  add_foreign_key "favorites", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "users"
  add_foreign_key "messages", "groups"
  add_foreign_key "messages", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "notifications", "members"
  add_foreign_key "notifications", "microposts"
  add_foreign_key "notifications", "relationships"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "visited_id"
  add_foreign_key "participates", "plans"
  add_foreign_key "participates", "users"
  add_foreign_key "plans", "groups"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "followed_id"
end
