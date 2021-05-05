FactoryBot.define do
  factory :cart do
    ticket
    association :user, factory: :generaluser
  end
end