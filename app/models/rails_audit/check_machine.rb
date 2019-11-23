module RailsAudit::CheckMachine
  extend ActiveSupport::Concern

  included do
    include RailsCom::StateMachine
    has_many :checks, as: :checking
  end

end
