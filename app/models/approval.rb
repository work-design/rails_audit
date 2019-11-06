class Approval < RailsAuthRecord
  include RailsAudit::Approval
end unless defined? Approval
