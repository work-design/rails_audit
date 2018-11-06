class Check < ApplicationRecord
  attribute :confirmed, :boolean, default: true

  belongs_to :checking, polymorphic: true
  belongs_to :operator, polymorphic: true

  after_create_commit :checking_trigger

  def checking_trigger
    if self.confirmed
      checking.do_trigger state: self.state
    end
  end

end
