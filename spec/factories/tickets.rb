FactoryBot.define do
  factory :ticket do
    id { 0 }
    game
    association :seat, factory: :ticket_seat
  end
  
  factory :ticket_seat, class: Seat do
    association :seatgroup, factory: :ticket_seatgroup
    name { "チケットテスト座席" }
  end
  
  factory :ticket_seatgroup, class: Seatgroup do
    name { "チケットテスト座席群" }
    ground_id { 0 }
    price { 10000 }
  end
end