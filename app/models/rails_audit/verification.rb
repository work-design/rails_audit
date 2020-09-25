module RailsVerify::Verification
  extend ActiveSupport::Concern

  included do
    attribute :note, :string
    attribute :position, :integer

    belongs_to :verified, polymorphic: true
    belongs_to :verifier
    belongs_to :member
  end

end
