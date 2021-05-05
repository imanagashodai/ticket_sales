FactoryBot.define do
  factory :seatgroup do
    id { 0 }
    name { "テスト座席群" }
    ground
    price { 1000 }
  end
  
  factory :seatgroup2, class: Seatgroup do
    name { "テスト座席群2" }
    association :ground, factory: :ground2
    price { 2000 }
  end
end