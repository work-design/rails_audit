module Auditor
  class DestroyedAudit < Audit
    include Model::Audit::DestroyedAudit
  end
end
