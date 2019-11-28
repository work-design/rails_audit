module RailsAudit::Check
  extend ActiveSupport::Concern

  included do
    attribute :state, :string
    attribute :comment, :string
    attribute :confirmed, :boolean, default: true
  
    belongs_to :checking, polymorphic: true
    belongs_to :operator, polymorphic: true
  
    after_create_commit :checking_trigger
  end
  
  def checking_trigger
    if self.confirmed
      checking.do_trigger state: self.state
    end
  end

end
