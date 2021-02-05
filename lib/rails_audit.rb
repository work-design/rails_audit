# frozen_string_literal: true

require 'rails_audit/engine'
require 'rails_audit/config'

module Auditor

  def self.use_relative_model_naming?
    true
  end

end
