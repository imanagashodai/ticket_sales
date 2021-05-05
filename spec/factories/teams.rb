FactoryBot.define do
  factory :team do
    id { 0 }
    name { "テスト球団" }
    ground
  end
  
  factory :team2, class: Team do
    name { "テスト球団2" }
  end
end