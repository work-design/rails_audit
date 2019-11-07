module RailsAudit::Application

  # after_action
  def mark_audits(record_class, **options)
    valid_ivars.find do |ivar|
      record = instance_variable_get(ivar)
      if record.is_a? record_class
        record.save_audits(
          operator: rails_audit_user,
          controller_path: controller_path,
          action_name: action_name,
          remote_ip: request.remote_ip,
          **options.slice(:only, :except, :include, :note, :extra)
        )
      end
    end
  end

  def rails_audit_user
    current_user
  end

end
