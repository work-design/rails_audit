module RailsAudit::Application

  def mark_audits(record_class, **options)
    valid_ivars.find do |ivar|
      record = instance_variable_get(ivar)
      if record.is_a? record_class
        record.save_audits(
          operator: rails_audit_user,
          include: options[:include],
          note: options[:note],
          controller_path: controller_path,
          action_name: action_name,
          remote_ip: request.remote_ip,
          extra: options[:extra]
        )
      end
    end
  end

  def rails_audit_user
    current_user
  end

end
