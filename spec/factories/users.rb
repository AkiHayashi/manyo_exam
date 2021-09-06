FactoryBot.define do
  factory :user do
    user_name { "ユーザー1" }
    email { "user@ex.jp" }
    password { "11111111" }
    password_confirmation { "11111111" }
    admin {"false"}
  end
  factory :admin_user, class:User do
    user_name { "管理者" }
    email { "admin@ex.jp" }
    password { "11111111" }
    password_confirmation { "11111111" }
    admin {"true"}
  end
  factory :model_test_user1, class:User do
    user_name { "model_user1" }
    email { "model_user1@ex.jp" }
    password { "11111111" }
    password_confirmation { "11111111" }
    admin { "false" }
  end
  factory :model_test_user2, class:User do
    user_name { "model_user2" }
    email { "model_user2@ex.jp" }
    password { "11111111" }
    password_confirmation { "11111111" }
    admin { "false" }
  end
end
