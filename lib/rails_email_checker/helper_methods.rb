# frozen_string_literal: true

module ActiveModel
  module Validations
    module HelperMethods
      def validates_email(*attrs)
        validates_with EmailValidator, _merge_attributes(attrs)
      end
    end
  end
end
