# frozen_string_literal: true

module SwissBankValidator
  IBAN_REGEX = /\ACH[A-Z0-9]{2}\d{5}[A-Z0-9]{12}\z/.freeze
  IBAN_LENGTH = 21

  # Regex that allow only field accepted by Swiss bank to initiate a payment
  # rubocop:disable Style/RedundantRegexpEscape
  BANK_REGEX = %r{\A[a-zA-Z0-9\.\,\;\:\’\+\-\(\)\?\*\[\]\{\}\`\´\~\'\s\!\“#%÷=@_$£àáâäçèéêëìíîïñòóôöùúûüýßÀÁÂÄÇÈÉÊËÌÍÎÏ
  ÒÓÔÖÙÚÛÜÑ]*\z}.freeze
  # rubocop:enable Style/RedundantRegexpEscape
end
