module RailsAudit::Check
  extend ActiveSupport::Concern

  included do
    attribute :state, :string
    attribute :comment, :string
    attribute :confirmed, :boolean, default: true

    belongs_to :checking, polymorphic: true
    belongs_to :member, optional: true
    belongs_to :user
    belongs_to :verifier, ->(o) { where(verifiable_type: o.checking.taxon.class_name, verifiable_id: o.checking.taxon.id) }, foreign_key: :member_id, primary_key: :member_id, optional: true

    after_create_commit :checking_trigger
  end

  def checking_trigger
    if self.confirmed
      checking.do_trigger state: self.state

      if verifier
        va = verifier.verifications.build
        va.verified_type = checking_type
        va.verified_id = checking_id
        va.member_id = member_id
        va.save
      end
    end
  end

end
