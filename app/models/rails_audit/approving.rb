module RailsAudit::Approving
  extend ActiveSupport::Concern

  included do
    attribute :unapproved_approvals_count, :integer, default: 0
    
    has_one :approval, ->{ where(approved: false).order(id: :desc) }, as: :approving
    has_many :approvals, as: :approving, autosave: true  # to test why autosave not works well
    has_many :unapproved_approvals, ->{ where(approved: false) }, class_name: 'Approval', as: :approving
  end

  # user: {
  #   id: 1,
  #   changes: {
  #     name: ['a', 'b']
  #   }
  # }
  # params same as as_json
  def save_with_approvals(only: [], except: [], include: [])
    for_changes = {}
    
    if only.present?
      for_changes[:pending_changes] = self.changes.slice(*only)
      self.assign_attributes self.changed_attributes.slice(*only)
    else
      for_changes[:pending_changes] = self.changes.except(*except)
      self.assign_attributes self.changed_attributes.except(*except)
    end
    
    result = {}
    include.each do |key|
      targets = self.public_send(key)
      result[key] = []

      Array(targets).each do |target|
        _changes = target.changes

        if _saved_changes.present? || _changes.present?
          result[key] << {
            id: target.id,
            changes: _changes
          }
        end
      end
    end
    for_changes[:related_changes] = result
    
    if for_changes[:pending_changes].present? || for_changes[:related_changes].present?
      approval = self.approvals.build(for_changes)
      self.class.transaction do
        approval.save!
        self.save!
      end
    else
      self.save
    end
  end
  
  def pending_changes
    if approval
      approval.pending_changes.transform_values { |i| i[0] }
    else
      {}
    end
  end

end
