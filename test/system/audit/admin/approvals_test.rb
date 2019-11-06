require "application_system_test_case"

class ApprovalsTest < ApplicationSystemTestCase
  setup do
    @audit_admin_approval = audit_admin_approvals(:one)
  end

  test "visiting the index" do
    visit audit_admin_approvals_url
    assert_selector "h1", text: "Approvals"
  end

  test "creating a Approval" do
    visit audit_admin_approvals_url
    click_on "New Approval"

    fill_in "Approved at", with: @audit_admin_approval.approved_at
    fill_in "Note", with: @audit_admin_approval.note
    fill_in "Pending changes", with: @audit_admin_approval.pending_changes
    fill_in "State", with: @audit_admin_approval.state
    click_on "Create Approval"

    assert_text "Approval was successfully created"
    click_on "Back"
  end

  test "updating a Approval" do
    visit audit_admin_approvals_url
    click_on "Edit", match: :first

    fill_in "Approved at", with: @audit_admin_approval.approved_at
    fill_in "Note", with: @audit_admin_approval.note
    fill_in "Pending changes", with: @audit_admin_approval.pending_changes
    fill_in "State", with: @audit_admin_approval.state
    click_on "Update Approval"

    assert_text "Approval was successfully updated"
    click_on "Back"
  end

  test "destroying a Approval" do
    visit audit_admin_approvals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Approval was successfully destroyed"
  end
end
