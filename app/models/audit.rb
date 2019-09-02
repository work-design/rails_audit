class Audit < RailsAuthRecord
  include RailsAuth::Audit
end unless defined? Audit
