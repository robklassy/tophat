class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :course_code
      t.string :name
      t.references :school, null: false, foreign_key: true, type: :uuid
      t.references :faculty, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
