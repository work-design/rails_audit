class Check < ApplicationRecord
  attribute :verified, :boolean, default: true

  belongs_to :checking, polymorphic: true
  belongs_to :member

  after_create_commit :checking_trigger

  def checking_trigger
    if self.verified
      checking.do_trigger state: self.state
    end
  end

end
