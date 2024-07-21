class CreateDiscussionQuestionRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :discussion_question_ratings, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :user_type, null: false
      t.references :discussion_question, null: false, foreign_key: true, type: :uuid
      t.boolean :liked, null: false

      t.timestamps
    end
  end
end
