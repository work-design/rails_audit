module Auditor
  module Ext::Verifiable
    extend ActiveSupport::Concern

    included do
      has_many :verifiers, -> { order(position: :asc) }, class_name: 'Auditor::Verifier', as: :verifiable, dependent: :delete_all
    end

  end
end
