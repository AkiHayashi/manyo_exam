FactoryBot.define do
  factory :user do
    id{1}
    user_name { "ユーザー1" }
    email { "user@ex.jp" }
    password { "11111111" }
    password_confirmation { "11111111" }
    admin {"false"}
  end
  factory :admin_user, class:User do
    id{2}
    user_name { "管理者" }
    email { "admin@ex.jp" }
    password { "11111111" }
    password_confirmation { "11111111" }
    admin {"true"}
  end
end
