module Auditor
  module Model::Approving
    extend ActiveSupport::Concern

    included do
      attribute :unapproved_approvals_count, :integer, default: 0

      has_one :approval, ->{ where(approved: false).order(id: :desc) }, as: :approving
      has_many :approvals, as: :approving, autosave: true, dependent: :delete_all  # to test why autosave not works well
      has_many :unapproved_approvals, ->{ where(approved: false) }, class_name: 'Approval', as: :approving
    end

    # user: {
    #   id: 1,
    #   changes: {
    #     name: ['a', 'b']
    #   }
    # }
    # params same as as_json
    def save_with_approvals(only: [], except: [], include: [])
      for_changes = {}

      if only.present?
        for_changes[:pending_changes] = self.changes.slice(*only)
        self.assign_attributes self.changed_attributes.slice(*only)
      else
        for_changes[:pending_changes] = self.changes.except(*except)
        self.assign_attributes self.changed_attributes.except(*except)
      end

      result = {}
      include.each do |key|
        targets = self.public_send(key)
        attr_key = "#{key}_attributes"
        result[attr_key] = []

        Array(targets).each do |target|
          if target.changes.present?
            result[attr_key] << { id: target.id }.merge!(target.changes)
            target.clear_changes_information
          end
        end
      end
      for_changes[:related_changes] = result

      if for_changes[:pending_changes].present? || for_changes[:related_changes].present?
        approval = self.approvals.build(for_changes)
        self.class.transaction do
          approval.save!
          self.save!
        end
      else
        self.save
      end
    end

    def temp_apply_changes
      if approval
        assign_attributes approval.apply_attributes
      end
      self
    end

  end
end
