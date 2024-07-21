class CreateSchoolProfessors < ActiveRecord::Migration[7.1]
  def change
    create_table :school_professors, id: :uuid do |t|
      t.boolean :active, default: true
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :school, null: false, foreign_key: true, type: :uuid
      t.string :user_type, null: false

      t.timestamps
    end
  end
end
