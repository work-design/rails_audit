module RailsAudit::Approving
  extend ActiveSupport::Concern

  included do
    has_many :approvals, as: :approving
  end

  # user: {
  #   id: 1,
  #   changes: {
  #     name: ['a', 'b']
  #   }
  # }
  # params same as as_json
  def save_approvals(operator:, only: [], except: [], **extra_options)
    approval = self.approvals.build
    if only.present?
      approval.pending_changes = self.changes.slice(*only)
    else
      approval.pending_changes = self.changes.except(*except)
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
    approval.related_changes = result
    
    return if approval.pending_changes.blank? && approval.related_changes.blank?

    approval.operator_type = operator.class.name
    approval.operator_id = operator.id
    approval.note = extra_options.delete(:note)
    approval.controller_path = extra_options.delete(:controller_path)
    approval.action_name = extra_options.delete(:action_name)
    approval.remote_ip = extra_options.delete(:remote_ip)
    approval.extra = extra_options
    approval.save
  end

end
