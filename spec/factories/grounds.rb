FactoryBot.define do
  factory :ground do
    id { 0 }
    name { "テスト球場" }
  end
  
  factory :ground2, class: Ground do
    name { "テスト球場2" }
  end
end