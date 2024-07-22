FactoryBot.define do
  factory :discussion_question_post_rating do
    user { nil }
    discussion_question_post { nil }
    liked { false }
  end
end
