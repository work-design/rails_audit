module RailsAudit::Audited
  extend ActiveSupport::Concern

  included do
    has_many :audits, as: :audited
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
      audit.unconfirmed_changes = self.changes.slice(*only)
    else
      except = RailsAudit.config.default_except + except
      audit.audited_changes = self.saved_changes.except(*except)
      audit.unconfirmed_changes = self.changes.except(*except)
    end
    
    result = {}
    include.each do |key|
      targets = self.public_send(key)
      result[key] = []

      Array(targets).each do |target|
        _saved_changes = target.saved_changes.except(*RailsAudit.config.default_except)
        _changes = target.changes

        if _saved_changes.present? || _changes.present?
          result[key] << {
            id: target.id,
            saved_changes: _saved_changes,
            changes: _changes
          }
        end
      end
    end
    audit.related_changes = result
    
    return if audit.audited_changes.blank? && audit.unconfirmed_changes.blank? && audit.related_changes.blank?

    if self.destroyed?
      audit.action = 'destroy'
    end

    audit.operator_type = operator.class.name
    audit.operator_id = operator.id
    audit.note = extra_options.delete(:note)
    audit.controller_path = extra_options.delete(:controller_path)
    audit.action_name = extra_options.delete(:action_name)
    audit.remote_ip = extra_options.delete(:remote_ip)
    audit.extra = extra_options
    audit.save
  end

end
