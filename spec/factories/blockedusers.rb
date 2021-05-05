FactoryBot.define do
  factory :blockeduser do
    association :user, factory: :generaluser
  end
end