module RailsAudit::Application

  # after_action
  def mark_audits(*record_instances, **options)
    record_instances.each do |ivar|
      record = instance_variable_get(ivar)
      next unless record.is_a?(ActiveRecord::Base)
      record.save_audits(
        operator: rails_audit_user,
        controller_path: controller_path,
        action_name: action_name,
        remote_ip: request.remote_ip,
        **options.slice(:only, :except, :include, :note, :extra)
      )
    end
  end

  def rails_audit_user
    current_user
  end

end
