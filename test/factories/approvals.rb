FactoryBot.define do
  factory :approval do
    operator_type { "MyString" }
    operator_id { 1 }
    approving_type { "MyString" }
    approving_id { 1 }
    pending_changes { "MyString" }
    state { "MyString" }
    comment { "MyString" }
    approved_at { "2019-11-07 15:48:45" }
  end
end
