class CreateCourseProfessors < ActiveRecord::Migration[7.1]
  def change
    create_table :course_professors, id: :uuid do |t|
      t.references :course, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, polymorphic: true, type: :uuid
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
