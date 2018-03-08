module TheAudit::ControllerHelper
  
 
  
  def mark_audits(*record_classes, **options)
    
    valid_ivars.find { |ivar| record_classes.include?(ivar.class) }.each do |record|
      record.save_audits current_operator: the_audit_user,
                         note: options[:note],
                         
    end
    
  end
  
  def the_audit_user
    current_user
  end
  
  def sync_audit_infos
    {
      current_operator: current_user,
      remote_ip: request.remote_ip
    }
  end

  def valid_ivars
    _except = self._protected_ivars.to_a + [:@marked_for_same_origin_verification]
    self.instance_variables - _except
  end

end

ActiveSupport.on_load :action_controller_base do
  include TheAudit::ControllerHelper
end
