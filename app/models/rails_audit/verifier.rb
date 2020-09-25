module RailsAudit::Verifier
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :position, :integer

    belongs_to :verifiable, polymorphic: true
    belongs_to :member, optional: true
    belongs_to :job_title, optional: true

    acts_as_list
  end


end
