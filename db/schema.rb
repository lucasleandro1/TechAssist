# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_08_22_113852) do
  create_table "clients", force: :cascade do |t|
    t.string "cpf"
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mobile_devices", force: :cascade do |t|
    t.string "imei"
    t.string "serial"
    t.string "modelo"
    t.string "marca"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_id", null: false
    t.index ["client_id"], name: "index_mobile_devices_on_client_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.date "data_abertura"
    t.date "data_fechamento"
    t.string "descricao"
    t.integer "status"
    t.string "comentario"
    t.integer "sintoma"
    t.string "anexo"
    t.integer "pecas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "mobile_device_id", null: false
    t.index ["mobile_device_id"], name: "index_tickets_on_mobile_device_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "mobile_devices", "clients"
  add_foreign_key "tickets", "mobile_devices"
  add_foreign_key "tickets", "users"
end
