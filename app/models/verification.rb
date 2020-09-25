class Verification < ApplicationRecord
  include RailsAudit::Verification
end unless defined? Verification

