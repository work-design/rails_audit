module RailsAudit::CheckSetting
  extend ActiveSupport::Concern
  included do
    belongs_to :checking, polymorphic: true
  end
  
end
