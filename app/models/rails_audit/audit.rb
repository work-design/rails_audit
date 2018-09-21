class Audit < ApplicationRecord
  serialize :audited_changes, Hash
  serialize :related_changes, Hash
  serialize :unconfirmed_changes, Hash
  serialize :extra, Hash

  belongs_to :auditable, polymorphic: true
  belongs_to :operator, polymorphic: true

  def audited_changes_i18n
    audited_changes.transform_keys { |key| auditable.class.human_attribute_name(key) }
  end

end
