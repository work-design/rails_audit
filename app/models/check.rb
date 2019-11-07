class Check < ApplicationRecord
  include RailsAudit::Check
end unless defined? Check
