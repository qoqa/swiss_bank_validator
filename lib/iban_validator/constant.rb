module IbanValidator
  IBAN_REGEX = /\ACH[A-Z0-9]{2}\d{5}[A-Z0-9]{12}\z/.freeze
  BANK_REGEX = %r{\A[a-zA-Z0-9\.\,\;\:\’\+\-\(\)\?\*\[\]\{\}\`\´\~\'\s\!\“#%÷=@_$£àáâäçèéêëìíîïñòóôöùúûüýßÀÁÂÄÇÈÉÊËÌÍÎÏ
  ÒÓÔÖÙÚÛÜÑ]*\z}.freeze
end
