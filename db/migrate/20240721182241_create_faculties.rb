class CreateFaculties < ActiveRecord::Migration[7.1]
  def change
    create_table :faculties, id: :uuid do |t|
      t.string :name
      t.references :school, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
