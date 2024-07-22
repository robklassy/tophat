FactoryBot.define do
  factory :discussion_question_rating do
    user { nil }
    discussion_question { nil }
    liked { false }
  end
end
