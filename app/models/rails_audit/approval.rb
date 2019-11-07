module RailsAudit::Approval
  extend ActiveSupport::Concern
  included do
    attribute :pending_changes, :json, default: {}
    attribute :related_changes, :json, default: {}
    attribute :state, :string, default: 'init'
    attribute :approved, :boolean, default: false
    
    belongs_to :approving, polymorphic: true
    belongs_to :operator, polymorphic: true, optional: true
    
    enum state: {
      init: 'init'
    }
    
    before_update :apply_changes, if: -> { approved_changed? }
    
    def apply_changes
      if approved
        approving.update pending_changes.transform_values { |i| i[1] }
      else
        approving.update pending_changes.transform_values { |i| i[0] }
      end
    end
    
  end

end
