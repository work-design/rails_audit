module RailsAudit::CheckSetting
  extend ActiveSupport::Concern

  included do
    attribute :code, :string

    belongs_to :checking, polymorphic: true
  end

end
