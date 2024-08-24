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

ActiveRecord::Schema[7.0].define(version: 2024_08_24_060212) do
  create_table "aparelhos", force: :cascade do |t|
    t.string "imei"
    t.string "serial"
    t.string "modelo"
    t.string "marca"
    t.integer "cliente_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_aparelhos_on_cliente_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.string "cpf"
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registro", force: :cascade do |t|
    t.string "data_abertura"
    t.string "data_fechamento"
    t.string "descricao"
    t.string "status"
    t.string "comentario"
    t.string "sintoma"
    t.string "anexo"
    t.integer "aparelho_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pecas"
    t.index ["aparelho_id"], name: "index_registro_on_aparelho_id"
    t.index ["user_id"], name: "index_registro_on_user_id"
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

  add_foreign_key "aparelhos", "clientes"
  add_foreign_key "registro", "aparelhos"
  add_foreign_key "registro", "users"
end
