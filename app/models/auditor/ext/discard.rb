module Auditor
  module Ext::Discard
    extend ActiveSupport::Concern

    included do
      has_many :destroyed_audits, class_name: 'Auditor::DestroyedAudit', as: :audited

      after_destroy :audit_destroyed
    end

    # user: {
    #   id: 1,
    #   changes: {
    #     name: ['a', 'b']
    #   }
    # }
    # params same as as_json
    def audit_destroyed
      audit = self.destroyed_audits.build
      audit.audited_changes = self.attributes

      result = {}
      include = []
      include.each do |key|
        targets = self.public_send(key)
        attr_key = "#{key}_attributes"
        result[attr_key] = []

        Array(targets).each do |target|
          _saved_changes = target.saved_changes.except(*RailsAudit.config.default_except)

          if _saved_changes.present?
            result[attr_key] << { id: target.id }.merge!(_saved_changes)
          end
        end
      end
      audit.related_changes = result
      audit.save
    end

  end
end
