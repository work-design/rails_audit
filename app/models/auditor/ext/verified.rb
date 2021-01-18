module Auditor
  module Ext::Verified
    extend ActiveSupport::Concern

    included do
      include RailsCom::StateMachine
      has_many :verifications, -> { order(position: :asc) }, as: :verified, dependent: :delete_all, inverse_of: :verified
    end

    def all_verifications
      verifiers.map do |verifier|
        verifications.find(&->(i){ i.verifier_id == verifier.id }) || verifications.build(verifier: verifier)
      end
    end

    def next_verifiers
      taxon.verifiers.where.not(id: verifications.pluck(:verifier_id))
    end

    def next_verifier
      next_verifiers[0]
    end

  end
end
