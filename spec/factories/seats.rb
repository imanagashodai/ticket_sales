FactoryBot.define do
  factory :seat do
    id { 0 }
    seatgroup
    name { "テスト座席" }
  end
  
  factory :seat2, class: Seat do
    association :seatgroup, factory: :seatgroup2
    name { "テスト座席2" }
  end
end