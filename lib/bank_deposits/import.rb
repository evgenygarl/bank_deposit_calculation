# frozen_string_literal: true

require 'dry/auto_inject'
require 'bank_deposits/container'

module BankDeposits
  Import = Dry::AutoInject(Container)
end
