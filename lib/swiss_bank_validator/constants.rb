# frozen_string_literal: true

module SwissBankValidator
  IBAN_REGEX = /\ACH[A-Z0-9]{2}\d{5}[A-Z0-9]{12}\z/.freeze
  IBAN_LENGTH = 21
end
