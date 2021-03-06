# frozen_string_literal: true

require 'bank_deposits/display_investment_growth'
require 'bank_deposits/deposit'

RSpec.describe BankDeposits::DisplayInvestmentGrowth, '#call' do
  subject do
    display_investment_growth.call(deposit, years, annual_addition)
  end

  let(:display_investment_growth) do
    described_class.new(calculate_long_term_deposit_sum: calculate_long_term_deposit_sum)
  end

  let(:calculate_long_term_deposit_sum) do
    ->(_interest_rate, annual_addition, years, _annual_compounds_count) { annual_addition * years * 2 }
  end

  context 'when deposit currency is USD' do
    let(:deposit) do
      BankDeposits::Deposit.new(name: 'USD Deposit', currency: 'USD', interest_rate: 9.5, annual_compounds_count: 4)
    end
    let(:years) { 10 }
    let(:annual_addition) { 1000 }

    it 'returns correct information about investment growth' do
      investment_growth_information = <<~INVESTMENT_GROWTH
        After 10 years your investment will be worth 20000.00 USD
        Average investment is 10000.00 USD
        Interest is 10000.00 USD
      INVESTMENT_GROWTH

      expect { subject }.to output(investment_growth_information).to_stdout
    end
  end

  context 'when deposit currency is BYN' do
    let(:deposit) do
      BankDeposits::Deposit.new(name: 'BYN Deposit', currency: 'BYN', interest_rate: 9.0, annual_compounds_count: 12)
    end
    let(:years) { 8 }
    let(:annual_addition) { 2000 }

    it 'returns correct information about investment growth' do
      investment_growth_information = <<~INVESTMENT_GROWTH
        After 8 years your investment will be worth 32000.00 BYN
        Average investment is 16000.00 BYN
        Interest is 16000.00 BYN
      INVESTMENT_GROWTH

      expect { subject }.to output(investment_growth_information).to_stdout
    end
  end
end
