module RailsAudit::Verifiable
  extend ActiveSupport::Concern

  included do
    has_many :verifiers, -> { order(position: :asc) }, as: :verifiable, dependent: :delete_all
  end


end
