class Audit < ApplicationRecord
  include RailsAudit::Audit
end unless defined? Audit
