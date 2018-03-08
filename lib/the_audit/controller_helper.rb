module TheAudit::ControllerHelper
  
  def mark_audits(**options)
    record_classes = options.select { |k, _|
      record_class = k.to_s.safe_constantize
      record_class && record_class.ancestors.include?(ActiveRecord::Base)
    }
    
    record_classes.each do |record_symbol, includes|
      record_class = record_symbol.to_s.constantize
      valid_ivars.find do |ivar|
        record = instance_variable_get(ivar)
        if record.is_a? record_class
          record.save_audits current_operator: the_audit_user,
                             includes: includes,
                             note: options[:note],
                             controller_path: controller_path,
                             action_name: action_name,
                             remote_ip: request.remote_ip,
                             extra: options[:extra]
        end
      end
    end
  end
  
  def the_audit_user
    current_user
  end

  def valid_ivars
    _except = self._protected_ivars.to_a + [:@marked_for_same_origin_verification]
    self.instance_variables - _except
  end

end

ActiveSupport.on_load :action_controller_base do
  include TheAudit::ControllerHelper
end
