class Verification < ApplicationRecord
  include RailsVerify::Verification
end unless defined? Verification

