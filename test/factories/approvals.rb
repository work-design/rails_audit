FactoryBot.define do
  factory :approval do
    association :approving, factory: :info
    comment { 'MyString' }
    approved_at { '2019-11-07 15:48:45' }
  end
end
