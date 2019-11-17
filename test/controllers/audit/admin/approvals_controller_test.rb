require 'test_helper'
class Audit::Admin::ApprovalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @approval = create :approval
  end

  test 'index ok' do
    get approvals_url(@approval.approving_type, @approval.approving_id)
    assert_response :success
  end

  test 'show ok' do
    get admin_approval_url(@approval), xhr: true
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_approval_url(@approval), xhr: true
    assert_response :success
  end

  test 'update ok' do
    patch admin_approval_url(@approval), params: { }, xhr: true
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Approval.count', -1) do
      delete admin_approval_url(@approval), xhr: true
    end

    assert_response :success
  end

end
