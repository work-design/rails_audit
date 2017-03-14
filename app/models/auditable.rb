module Auditable
  extend ActiveSupport::Concern
  IGNORE = ['updated_at']

  included do
    has_many :audits, as: :auditable
  end

  def save_audits(operator_type: 'User', operator_id: nil, note: '', previous: true)
    audit = self.audits.build
    if previous
      audit.audited_changes = self.previous_changes.except(*IGNORE)
    else
      audit.audited_changes = self.changes
    end
    audit.operator_type = operator_type
    audit.operator_id = operator_id
    audit.note = note
    audit.save
  end


end
