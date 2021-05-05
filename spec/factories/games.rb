FactoryBot.define do
  factory :game do
    id { 0 }
    datetime { "2021-5-5 13:14:21" }
    association :hometeam, factory: :team
    association :visitorteam, factory: :team2
    ground_id { hometeam.ground_id }
  end
end