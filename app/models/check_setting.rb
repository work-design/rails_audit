class CheckSetting < RailsAuthRecord
  include RailsAudit::CheckSetting
end unless defined? CheckSetting
