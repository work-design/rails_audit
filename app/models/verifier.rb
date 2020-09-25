class Verifier < ApplicationRecord
  include RailsVerify::Verifier
end unless defined? Verifier

