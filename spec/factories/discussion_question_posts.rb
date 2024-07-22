FactoryBot.define do
  factory :discussion_question_post do
    course { nil }
    user { nil }
    content { "MyText" }
    posted_at { "2024-07-21 15:40:49" }
    archived_at { "2024-07-21 15:40:49" }
    deleted_at { "2024-07-21 15:40:49" }
    edited_at { "2024-07-21 15:40:49" }
    state { "MyString" }
    like_count { 1 }
    discusstion_topic_post { nil }
    discussion_question { nil }
  end
end
