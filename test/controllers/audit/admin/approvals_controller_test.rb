require 'test_helper'
class Audit::Admin::ApprovalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @audit_admin_approval = create audit_admin_approvals
  end

  test 'index ok' do
    get admin_approvals_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_approval_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Approval.count') do
      post admin_approvals_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_approval_url(@audit_admin_approval)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_approval_url(@audit_admin_approval)
    assert_response :success
  end

  test 'update ok' do
    patch admin_approval_url(@audit_admin_approval), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Approval.count', -1) do
      delete admin_approval_url(@audit_admin_approval)
    end

    assert_response :success
  end

end
