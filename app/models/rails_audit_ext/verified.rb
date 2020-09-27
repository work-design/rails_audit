module RailsAuditExt::Verified
  extend ActiveSupport::Concern

  included do
    has_many :verifications, -> { order(position: :asc) }, as: :verified, dependent: :delete_all
  end

  # def verifiers
  #   taxon.verifiers
  # end

  def next_verifiers
    taxon.verifiers.where.not(id: verifications.pluck(:verifier_id))
  end

  def next_verifier
    next_verifiers[0]
  end

end
