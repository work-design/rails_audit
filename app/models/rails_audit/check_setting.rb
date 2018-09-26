class CheckSetting < ApplicationRecord
  belongs_to :checking, polymorphic: true

end
