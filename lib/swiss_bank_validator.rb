# frozen_string_literal: true

module SwissBankValidator
  require 'swiss_bank_validator/version'
  require 'swiss_bank_validator/constants'
  require 'swiss_bank_validator/validates_iban_format_of'

  I18n.load_path += Dir[File.join(__dir__, 'swiss_bank_validator/locale/*.yml')]
end
