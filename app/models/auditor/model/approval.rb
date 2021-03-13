module Auditor
  module Model::Approval
    extend ActiveSupport::Concern

    included do
      attribute :approved, :boolean, default: false
      attribute :pending_changes, :json, default: {}
      attribute :related_changes, :json, default: {}
      attribute :comment, :string
      attribute :approved_at, :datetime
      attribute :unapproved_approvals_count, :integer, default: 0

      belongs_to :approving, polymorphic: true
      belongs_to :operator, polymorphic: true, optional: true

      enum state: {
        init: 'init'
      }, _default: 'init'

      before_update :apply_changes, if: -> { approved_changed? }

      def pending_changes_i18n
        pending_changes.transform_keys { |key| approving.class.human_attribute_name(key) }
      end

      def apply_changes
        if approved
          self.approved_at = Time.current
          approving.assign_attributes apply_attributes
        else
          self.approved_at = Time.current
          approving.assign_attributes revert_attributes
        end

        approving.save
      end

      def apply_attributes
        r1 = pending_changes.transform_values { |i| i[-1] }
        r2 = related_changes.transform_values do |i|
          i.map { |si| si.transform_values(&->(c){ Array(c)[-1] }) }
        end

        r1.merge! r2
      end

      def revert_attributes
        r1 = pending_changes.transform_values { |i| i[0] }
        r2 = related_changes.transform_values do |i|
          i.map { |si| si.transform_values(&->(c){ Array(c)[0] }) }
        end

        r1.merge! r2
      end

    end

  end
end
