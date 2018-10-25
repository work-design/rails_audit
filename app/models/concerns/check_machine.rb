module CheckMachine
  extend ActiveSupport::Concern

  included do
    include StateMachine
    has_many :checks, as: :checking
  end


end
