module RailsAudit::Audit
  extend ActiveSupport::Concern
  included do
    attribute :action, :string, default: 'update'
    attribute :audited_changes, :json, default: {}
    attribute :related_changes, :json, default: {}
    attribute :extra, :json, default: {}
    attribute :note, :string, limit: 1024
    attribute :remote_ip, :string
    attribute :controller_path, :string
    attribute :action_name, :string
    attribute :created_at, :datetime, index: true, null: false

    belongs_to :audited, polymorphic: true
    belongs_to :operator, polymorphic: true
  end

  def audited_changes_i18n
    audited_changes.transform_keys { |key| audited.class.human_attribute_name(key) }
  end

end
