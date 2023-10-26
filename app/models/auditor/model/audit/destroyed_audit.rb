# frozen_string_literal: true

module Auditor
  module Model::Audit::DestroyedAudit
    extend ActiveSupport::Concern

    included do

    end

    def record
      audited_type.constantize.new audited_changes
    end

  end
end
