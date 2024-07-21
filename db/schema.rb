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

ActiveRecord::Schema[7.1].define(version: 2024_07_21_230948) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "course_professors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "course_id", null: false
    t.uuid "user_id", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_professors_on_course_id"
    t.index ["user_id"], name: "index_course_professors_on_user_id"
  end

  create_table "course_students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "course_id", null: false
    t.uuid "user_id", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_students_on_course_id"
    t.index ["user_id"], name: "index_course_students_on_user_id"
  end

  create_table "courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "course_code"
    t.string "name"
    t.uuid "school_id", null: false
    t.uuid "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_courses_on_faculty_id"
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "discussion_question_post_ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "user_type", null: false
    t.uuid "discussion_question_post_id", null: false
    t.boolean "liked", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_question_post_id"], name: "idx_on_discussion_question_post_id_e744f6f989"
    t.index ["user_id"], name: "index_discussion_question_post_ratings_on_user_id"
  end

  create_table "discussion_question_posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "course_id", null: false
    t.uuid "user_id", null: false
    t.text "content"
    t.datetime "posted_at"
    t.datetime "archived_at"
    t.datetime "deleted_at"
    t.datetime "edited_at"
    t.string "state"
    t.integer "like_count"
    t.uuid "discussion_question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "discussion_question_post_id"
    t.string "user_type", null: false
    t.index ["course_id"], name: "index_discussion_question_posts_on_course_id"
    t.index ["discussion_question_id"], name: "index_discussion_question_posts_on_discussion_question_id"
    t.index ["discussion_question_post_id"], name: "index_discussion_question_posts_on_discussion_question_post_id"
    t.index ["user_id"], name: "index_discussion_question_posts_on_user_id"
  end

  create_table "discussion_question_ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "user_type", null: false
    t.uuid "discussion_question_id", null: false
    t.boolean "liked", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_question_id"], name: "index_discussion_question_ratings_on_discussion_question_id"
    t.index ["user_id"], name: "index_discussion_question_ratings_on_user_id"
  end

  create_table "discussion_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "course_id", null: false
    t.uuid "user_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "posted_at"
    t.datetime "archived_at"
    t.datetime "deleted_at"
    t.datetime "edited_at"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type", null: false
    t.index ["course_id"], name: "index_discussion_questions_on_course_id"
    t.index ["user_id"], name: "index_discussion_questions_on_user_id"
  end

  create_table "faculties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_faculties_on_school_id"
  end

  create_table "faculty_professors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "user_type", null: false
    t.uuid "user_id", null: false
    t.uuid "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_faculty_professors_on_faculty_id"
    t.index ["user_type", "user_id"], name: "index_faculty_professors_on_user"
  end

  create_table "faculty_students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "user_type", null: false
    t.uuid "user_id", null: false
    t.uuid "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_faculty_students_on_faculty_id"
    t.index ["user_type", "user_id"], name: "index_faculty_students_on_user"
  end

  create_table "school_professors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "active", default: true
    t.uuid "user_id", null: false
    t.uuid "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_school_professors_on_school_id"
    t.index ["user_id"], name: "index_school_professors_on_user_id"
  end

  create_table "school_students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "active"
    t.uuid "user_id", null: false
    t.uuid "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_school_students_on_school_id"
    t.index ["user_id"], name: "index_school_students_on_user_id"
  end

  create_table "schools", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "course_professors", "courses"
  add_foreign_key "course_students", "courses"
  add_foreign_key "course_students", "users"
  add_foreign_key "courses", "faculties"
  add_foreign_key "courses", "schools"
  add_foreign_key "discussion_question_post_ratings", "discussion_question_posts"
  add_foreign_key "discussion_question_post_ratings", "users"
  add_foreign_key "discussion_question_posts", "courses"
  add_foreign_key "discussion_question_posts", "discussion_question_posts"
  add_foreign_key "discussion_question_posts", "discussion_questions"
  add_foreign_key "discussion_question_posts", "users"
  add_foreign_key "discussion_question_ratings", "discussion_questions"
  add_foreign_key "discussion_question_ratings", "users"
  add_foreign_key "discussion_questions", "courses"
  add_foreign_key "discussion_questions", "users"
  add_foreign_key "faculties", "schools"
  add_foreign_key "faculty_professors", "faculties"
  add_foreign_key "faculty_students", "faculties"
  add_foreign_key "school_professors", "schools"
  add_foreign_key "school_professors", "users"
  add_foreign_key "school_students", "schools"
  add_foreign_key "school_students", "users"
end
