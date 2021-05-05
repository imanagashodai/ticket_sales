FactoryBot.define do
  factory :purchase do
    ticket
    association :user, factory: :generaluser
  end
end