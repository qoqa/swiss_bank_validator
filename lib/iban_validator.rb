require "iban_validator/version"

class IbanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.length != 21
      record.errors[attribute] << ("n'est pas valide. Longueur pas correct.")
    end
    if IbanValidator::IBAN_REGEX.match(value).nil?
      record.errors[attribute] << ("n'est pas valide. Les espaces ne sont pas autorisés.")
    end
    unless self.class.iban_format_valid?(value)
      record.errors[attribute] << ("n'est pas valide. Format pas correct.")
    end
  end

  private

  def self.iban_format_valid?(iban)
    iban_numerified = numerify_iban(iban)
    return false if iban_numerified.nil?

    iban_numerified.to_i % 97 == 1
  end

  def self.numerify_iban(iban)
    return "" if iban.blank?

    numerified = ""
    code = iban.to_s.strip.gsub(/\s+/, '').upcase
    (code[4..-1] + code[0..3]).each_byte do |byte|
      numerified += case byte
                      # 0..9
                    when 48..57 then byte.chr
                      # 'A'..'Z'
                    when 65..90 then (byte - 55).to_s # 55 = 'A'.ord + 10
                    else
                      errors.add(:iban, I18n.t('validators.partner_info.iban.not_valid'))
                      return nil
                    end
    end
    numerified
  end
end
