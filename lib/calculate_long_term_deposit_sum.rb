require 'calculate_annual_deposit_sum'

class CalculateLongTermDepositSum
  def call(interest_rate, annual_addition, years, annual_compounds_count)
    calculate_annual_deposit_sum = CalculateAnnualDepositSum.new

    years.times.reduce(0) do |period_start_sum, _year|
      calculate_annual_deposit_sum.(interest_rate, (period_start_sum + annual_addition), annual_compounds_count)
    end
  end
end
