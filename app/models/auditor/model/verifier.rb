module Auditor
  module Model::Verifier
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer

      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :job_title, class_name: 'Org::JobTitle', optional: true

      belongs_to :verifiable, polymorphic: true
      has_many :verifications, dependent: :destroy, inverse_of: :verifier

      acts_as_list
    end


  end
end
