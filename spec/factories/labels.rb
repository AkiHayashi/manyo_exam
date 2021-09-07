FactoryBot.define do
  factory :label do
    name { "test_label" }
  end
  factory :second_label, class:Label do
    name { "test_label2" }
  end
end
