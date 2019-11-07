module RailsAudit::Approval
  extend ActiveSupport::Concern
  included do
    attribute :pending_changes, :json, default: {}
    attribute :related_changes, :json, default: {}

    belongs_to :approving, polymorphic: true
    belongs_to :operator, polymorphic: true
  end

end
