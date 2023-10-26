module Auditor
  module Controller::Application

    # after_action
    def mark_audits(instance: [], local: [], binding:, **options)
      instance_records = Array(instance).map!(&:to_sym) & valid_ivars
      instance_records.each do |ivar|
        record = instance_variable_get(ivar)
        next unless record.is_a?(ActiveRecord::Base)
        save_audits(record, **options)
      end

      local_records = Array(local).map!(&:to_sym) & local_variables
      local_records.each do |ivar|
        record = binding.local_variable_get(ivar)
        next unless record.is_a?(ActiveRecord::Base)
        save_audits(record, **options)
      end
    end

    def save_audits(record, **options)
      record.save_audits(
        operator: rails_audit_user,
        controller_path: controller_path,
        action_name: action_name,
        remote_ip: request.remote_ip,
        **options.slice(:only, :except, :include, :note, :extra)
      )
    end

    def rails_audit_user
      current_user
    end

  end
end
