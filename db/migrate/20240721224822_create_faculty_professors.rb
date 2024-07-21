class CreateFacultyProfessors < ActiveRecord::Migration[7.1]
  def change
    create_table :faculty_professors, id: :uuid do |t|
      t.references :user, polymorphic: true, null: false, type: :uuid
      t.references :faculty, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
