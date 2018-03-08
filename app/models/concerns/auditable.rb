module Auditable
  extend ActiveSupport::Concern
  IGNORE = ['updated_at']

  included do
    has_many :audits, as: :auditable
  end

  # user: {
  #   id: 1,
  #   changes: {
  #     name: ['a', 'b']
  #   }
  # }

  def save_audits(current_operator: current_operator, include: [], **extra_options)
    audit = self.audits.build
    audit.audited_changes = self.saved_changes.except(*IGNORE)
    audit.unconfirmed_changes = self.changes

    if include.present?
      result = {}
      
      include.each do |key|
        targets = self.send(key)
        result[key] = []
        
        Array(targets).each do |target|
          _saved_changes = target.saved_changes.except(*IGNORE)
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
    end
    
    if self.destroyed?
      audit.action = 'destroy'
    end

    audit.operator_type = current_operator.class.name
    audit.operator_id = current_operator.id
    audit.note = extra_options.delete(:note)
    audit.controller_path = extra_options.delete(:controller_path)
    audit.action_name = extra_options.delete(:action_name)
    audit.remote_ip = extra_options.delete(:remote_ip)
    audit.extra = extra_options
    audit.save
  end

end
