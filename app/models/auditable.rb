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

  def save_audits(operator_type: 'User', operator_id: nil, note: '', previous: true, include: [])
    audit = self.audits.build
    if previous
      audit.audited_changes = self.previous_changes.except(*IGNORE)
    else
      audit.audited_changes = self.changes
    end

    if include.present?
      result = {}
      include.each do |key|
        target = self.association(key).target

        if previous
          _changes = target.previous_changes.except(*IGNORE)
        else
          _changes = target.changes
        end

        if _changes.present?
          result[key] = {
            id: target.id,
            changes: _changes
          }
        end
      end
      audit.related_changes = result
    end

    audit.operator_type = operator_type
    audit.operator_id = operator_id
    audit.note = note
    audit.save
  end


end
