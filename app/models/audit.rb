class Audit < RailsAuthRecord
  include RailsAudit::Audit
end unless defined? Audit
