module Auditor
  module Ext::Audited
    extend ActiveSupport::Concern

    included do
      has_many :audits, class_name: 'Auditor::Audit', as: :audited
    end

    # user: {
    #   id: 1,
    #   changes: {
    #     name: ['a', 'b']
    #   }
    # }
    # params same as as_json
    def save_audits(operator:, only: [], except: [], include: [], **extra_options)
      audit = self.audits.build
      if only.present?
        audit.audited_changes = self.saved_changes.slice(*only)
      else
        except = RailsAudit.config.default_except + except
        audit.audited_changes = self.saved_changes.except(*except)
      end

      result = {}
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

      return if audit.audited_changes.blank? && audit.related_changes.blank?

      if self.destroyed?
        audit.action = 'destroy'
      end

      audit.operator_type = operator.class.name
      audit.operator_id = operator.id
      audit.assign_attributes = extra_options.except!(:note, :controller_path, :action_name, :remote_ip)
      audit.extra = extra_options
      audit.save
    end

  end
end
