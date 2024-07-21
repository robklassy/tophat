class CreateSchoolStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :school_students, id: :uuid do |t|
      t.boolean :active
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :user_type, null: false
      t.references :school, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
    end
  end
end
