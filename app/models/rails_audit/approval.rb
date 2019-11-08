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

    def pending_changes_i18n
      pending_changes.transform_keys { |key| approving.class.human_attribute_name(key) }
    end
    
    def apply_changes
      if approved
        self.approved_at = Time.current
        approving.assign_attributes apply_attributes
      else
        self.approved_at = Time.current
        approving.assign_attributes revert_attributes
      end
      
      approving.save
    end
    
    def apply_attributes
      pending_changes.transform_values { |i| i[1] }
      related_changes.transform_values do |i|
        i.map { |i| i }
      end
    end
    
    def revert_attributes
      pending_changes.transform_values { |i| i[0] }
    end
    
  end

end
