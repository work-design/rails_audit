module RailsAudit::Verification
  extend ActiveSupport::Concern

  included do
    attribute :state, :string
    attribute :note, :string
    attribute :position, :integer
    attribute :confirmed, :boolean, default: true

    belongs_to :verified, polymorphic: true
    belongs_to :verifier
    belongs_to :member

    after_create_commit :checking_trigger
  end

  def checking_trigger
    if self.confirmed
      verified.do_trigger state: self.state
    end
  end


end
