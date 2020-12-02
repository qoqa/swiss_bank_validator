# frozen_string_literal: true

# Based on http://www.swissiban.com/fr.htm
module ActiveModel
  module Validations
    class IbanValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]

        return unless validate_iban_length(record, attribute, value, options)

        validate_start_with_ch(record, attribute, value, options)
        validate_iban_with_regex(record, attribute, value, options)
        validate_iban_format(record, attribute, value, options)
      end

      def validate_iban_length(record, attribute, value, options)
        return true if value.length == SwissBankValidator::IBAN_LENGTH

        record.errors.add(
          attribute,
          :invalid_iban_length,
          message: options[:message],
          value: SwissBankValidator::IBAN_LENGTH
        )

        false
      end

      def validate_iban_with_regex(record, attribute, value, options)
        return if SwissBankValidator::IBAN_REGEX.match(value).present?

        record.errors.add(
          attribute,
          :space_not_authorized_in_iban,
          message: options[:message],
          value: value
        )
      end

      def validate_iban_format(record, attribute, value, options)
        return if iban_format_valid?(value)

        record.errors.add(
          attribute,
          :iban_format_not_valid,
          message: options[:message],
          value: value
        )
      end

      def validate_start_with_ch(record, attribute, value, options)
        return if value.downcase.start_with?('ch')

        record.errors.add(
          attribute,
          :must_start_with_ch,
          message: options[:message],
          value: value
        )
      end

      def iban_format_valid?(iban)
        iban_numerified = numerify_iban(iban)
        return false if iban_numerified.nil?

        iban_numerified.to_i % 97 == 1
      end

      def numerify_iban(iban)
        return '' if iban.blank?

        numerified = ''
        code = iban.to_s.strip.gsub(/\s+/, '').upcase
        (code[4..] + code[0..3]).each_byte do |byte|
          numerified += case byte
                          # 0..9
                        when 48..57 then byte.chr
                          # 'A'..'Z'
                        when 65..90 then (byte - 55).to_s # 55 = 'A'.ord + 10
                        else
                          return nil
                        end
        end
        numerified
      end
    end

    module ClassMethods
      # Validates whether or not the specified iban is valid.
      #
      #   class account < ActiveRecord::Base
      #     validates_iban_format_of :iban
      #   end
      #
      def validates_iban_format_of(*attr_names)
        validates_with IbanValidator, _merge_attributes(attr_names)
      end

      alias validates_iban validates_iban_format_of
    end
  end
end
