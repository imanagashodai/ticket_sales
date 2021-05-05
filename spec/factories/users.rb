FactoryBot.define do
  factory :generaluser, class: User do
    id { 0 }
    name { 'テストユーザー(一般)' }
    email { 'general@user.com' }
    password { 'generaluser0' }
    password_confirmation { 'generaluser0' }
  end
end