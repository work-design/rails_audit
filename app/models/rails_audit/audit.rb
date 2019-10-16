module RailsAudit::Audit
  extend ActiveSupport::Concern
  included do
    attribute :audited_changes, :json
    attribute :related_changes, :json
    attribute :unconfirmed_changes, :json
    attribute :extra, :json, default: {}

    belongs_to :auditable, polymorphic: true
    belongs_to :operator, polymorphic: true
  end

  def audited_changes_i18n
    audited_changes.transform_keys { |key| auditable.class.human_attribute_name(key) }
  end

end
