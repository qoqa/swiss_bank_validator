# frozen_string_literal: true

module SwissBankValidator
  IBAN_REGEX = /\ACH[A-Z0-9]{2}\d{5}[A-Z0-9]{12}\z/
  IBAN_LENGTH = 21

  # Regex that allow only field accepted by Swiss bank to initiate a payment
  BANK_REGEX = %r{\A[a-zA-Z0-9.,;:’+\-()?*\[\]{}`´~'\s!“#%÷=@_$£
                     àáâäçèéêëìíîïñòóôöùúûüýßÀÁÂÄÇÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜÑ]*\z}x
end
