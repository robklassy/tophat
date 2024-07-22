FactoryBot.define do
  factory :discussion_question do
    course { nil }
    user { nil }
    title { "MyString" }
    content { "MyText" }
    posted_at { "2024-07-21 15:32:21" }
    archived_at { "2024-07-21 15:32:21" }
    deleted_at { "2024-07-21 15:32:21" }
    edited_at { "2024-07-21 15:32:21" }
    state { "MyString" }
  end
end
