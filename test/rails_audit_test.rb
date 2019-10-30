require 'test_helper'

class RailsAuditTest < ActiveSupport::TestCase
  
  test 'truth' do
    assert_kind_of Module, RailsAudit
  end
  
end
