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

  def save_audits(operator_type: 'User', operator_id: nil, note: nil, action: nil, saved: true, include: [])
    audit = self.audits.build
    if saved
      audit.audited_changes = self.saved_changes.except(*IGNORE)
    else
      audit.audited_changes = self.changes
    end

    if include.present?
      result = {}
      include.each do |key|
        targets = self.send(key)
        result[key] = []

        if targets.respond_to?(:each)
          targets.each do |target|
            if saved
              _changes = target.saved_changes.except(*IGNORE)
            else
              _changes = target.changes
            end

            if _changes.present?
              result[key] << {
                id: target.id,
                changes: _changes
              }
            end
          end
        else
          if saved
            _changes = targets.saved_changes.except(*IGNORE)
          else
            _changes = targets.changes
          end

          if _changes.present?
            result[key] << {
              id: targets.id,
              changes: _changes
            }
          end
        end
      end
      audit.related_changes = result
    end

    audit.operator_type = operator_type
    audit.operator_id = operator_id
    audit.note = note
    audit.action = action
    audit.save
  end

end
