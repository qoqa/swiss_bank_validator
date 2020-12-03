# frozen_string_literal: true

module ActiveModel
  module Validations
    class BankFieldValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]

        return if value.to_s =~ SwissBankValidator::BANK_REGEX

        record.errors.add(
          attribute,
          :invalid_bank_field,
          message: options[:message]
        )
      end
    end

    module ClassMethods
      # Validates whether or not the specified field bank complient.
      #
      #   class Account < ActiveRecord::Base
      #     validates_bank_field_of :name
      #   end
      #
      def validates_bank_field_of(*attr_names)
        validates_with BankFieldValidator, _merge_attributes(attr_names)
      end

      alias validates_bank_field validates_bank_field_of
    end
  end
end
