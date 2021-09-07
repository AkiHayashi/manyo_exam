FactoryBot.define do
  factory :task do
    title { 'test_title' }
    description { 'test_description' }
    progress {'未着手'}
    expired_at {'2021-08-30 00:00:00'}
    association :user
  end
  factory :second_task, class: Task do
    title { 'test_title2' }
    description { 'test_description2' }
    progress {'着手中'}
    expired_at {'2021-08-30 00:00:00'}
  end
  factory :third_task, class: Task do
    title { 'test_title3' }
    description { 'test_description3' }
    progress {'完了'}
    expired_at {'2021-08-30 00:00:00'}
  end
end
