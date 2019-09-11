class Check < RailsAuthRecord
  include RailsAudit::Check
end unless defined? Check
