# frozen_string_literal: true

require_relative 'test_helper'

# Basic test object
module Test
  IbanValidatable = Struct.new(:iban) do
    include ActiveModel::Validations

    validates :iban, iban: true
  end
end

# Validator tests with the test object
describe ActiveModel::Validations::IbanValidator, type: :model do
  subject { Test::IbanValidatable.new 'CH9300762011623852957' }

  it { is_expected.to be_valid }

  context 'With invalid IBAN' do
    it 'is invalid' do
      subject.iban = 'CH9300762011623852953'
      subject.valid?
      expect(subject.errors[:iban]).to include('Your IBAN format is not valid')
    end
  end

  context 'With Iban too short' do
    it 'is invalid' do
      subject.iban = 'CH93007620116238'
      subject.valid?
      iban_length = SwissBankValidator::IBAN_LENGTH
      expect(subject.errors[:iban]).to match_array("IBAN length is not valid. must be #{iban_length}")
    end
  end

  context 'With IBAN invalid char' do
    it 'is invalid' do
      subject.iban = 'CH930076 01162385 957'
      subject.valid?
      expect(subject.errors[:iban]).to include('Spaces are not authorized')
    end
  end

  context 'With IBAN start with LI' do
    it 'is invalid' do
      subject.iban = 'LI9300762011623852957'
      subject.valid?
      expect(subject.errors[:iban]).to include('Must start with CH')
    end
  end
end
