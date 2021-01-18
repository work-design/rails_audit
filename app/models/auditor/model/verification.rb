module Auditor
  module Model::Verification
    extend ActiveSupport::Concern

    included do
      attribute :state, :string
      attribute :note, :string
      attribute :position, :integer
      attribute :confirmed, :boolean, default: false

      belongs_to :verified, polymorphic: true
      belongs_to :verifier
      belongs_to :member
      belongs_to :job_title

      after_initialize if: :new_record? do
        self.job_title ||= verifier.job_title
        self.member ||= verifier.member
      end
      after_create_commit :checking_trigger
    end

    def checking_trigger
      if self.confirmed
        verified.do_trigger state: self.state
      end
    end


  end
end
