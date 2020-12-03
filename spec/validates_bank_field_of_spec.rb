# frozen_string_literal: true

require_relative 'test_helper'

# Basic test object
module Test
  BankFieldValidatable = Struct.new(:name) do
    include ActiveModel::Validations

    validates :name, bank_field: true
  end
end

# Validator tests with the test object
describe ActiveModel::Validations::BankFieldValidator, type: :model do
  subject { Test::BankFieldValidatable.new 'Ben et Léo' }

  it { is_expected.to be_valid }

  invalid_chars = '&/<>°\\|'
  invalid_chars.each_char do |char|
    context "With invalid char #{char}" do
      it 'is invalid' do
        subject.name = "Ben #{char} Léo"
        subject.valid?
        expect(subject.errors[:name]).to include(
          'Not a valid Bank field. It does not accept special character (&/<>°\\|...)'
        )
      end
    end
  end

  context 'With special accepted char' do
    it 'is valid' do
      subject.name = ".,;:’+-()?*[]{}`´~'s!“#%÷=@_$£"
      is_expected.to be_valid

      subject.name = 'àáâäçèéêëìíîïñòóôöùúûüýßÀÁÂÄÇÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜÑ'
      is_expected.to be_valid
    end
  end
end
