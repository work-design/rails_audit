class Audit < ApplicationRecord
  serialize :audited_changes, Hash

  belongs_to :auditable, polymorphic: true
  belongs_to :operator, polymorphic: true

end
