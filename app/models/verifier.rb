class Verifier < ApplicationRecord
  include RailsAudit::Verifier
end unless defined? Verifier

