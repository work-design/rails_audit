class Approval < ApplicationRecord
  include RailsAudit::Approval
end unless defined? Approval
