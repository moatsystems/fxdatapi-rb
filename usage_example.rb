# usage_example.rb

# frozen_string_literal: true

require 'currensees'

# Authentication
username = "your_username"
password = "your_password"

# Currencies data parameters
day = 19
month = 4
year = 2024
currency_uuid = '594bffc4-d095-11ed-9e30-acde48001122'

# Historical data parameters
date = '2023_04_02'
data_id = 'fe1ee1c4-d162-11ed-a2dc-acde48001122'
date_string = '2023_04_02'

# Margins and spreads parameters
margin_spread_uuid = '02775b82-e3c1-11ed-9eab-acde48001122'

# Performances parameters
performance_id = '9010e700-e3c2-11ed-b5bd-acde48001122'

# Signals parameters
signal_id = '8e694050-e3c2-11ed-b5bd-acde48001122'

# Weekly Average data parameters
from_date = '2023_04_03'
to_date = '2023_04_07'

# Convert currency parameters
convert_date = '2023_04_19'
base_currency = 'GBP'
target_currency = 'EUR'
convert_amount = 500
amount = 120

# Using Authentication
result = Currensees::Authentication.login(username, password)
puts "Authentication result:"
puts result.inspect

# Using Currencies
currencies = Currensees::Currencies.get_currencies(username, password, day, month, year)
puts "Currencies result:"
puts currencies.inspect

currency_by_uuid = Currensees::Currencies.get_currency_by_uuid(username, password, currency_uuid, day, month, year)
puts "Currency by UUID result:"
puts currency_by_uuid.inspect

# Using Historical
historical_data = Currensees::Historical.get_historical_data(username, password, date, day, month, year)
puts "Historical data result:"
puts historical_data.inspect

historical_data_by_id = Currensees::Historical.get_historical_data_by_id(username, password, data_id, date_string, day, month, year)
puts "Historical data by ID result:"
puts historical_data_by_id.inspect

# Using MarginsSpreads
margins_spreads = Currensees::MarginsSpreads.get_margins_spreads(username, password, day, month, year)
puts "Margins and spreads result:"
puts margins_spreads.inspect

margin_spread_by_uuid = Currensees::MarginsSpreads.get_margin_spread_by_uuid(username, password, margin_spread_uuid, day, month, year)
puts "Margin and spread by UUID result:"
puts margin_spread_by_uuid.inspect

# Using Performances
performances = Currensees::Performances.get_performances(username, password)
puts "Performances result:"
puts performances.inspect

performance_by_id = Currensees::Performances.get_performance_by_id(username, password, performance_id)
puts "Performance by ID result:"
puts performance_by_id.inspect

# Using Signals
signals = Currensees::Signals.get_signals(username, password)
puts "Signals result:"
puts signals.inspect

signal_by_id = Currensees::Signals.get_signal_by_id(username, password, signal_id)
puts "Signal by ID result:"
puts signal_by_id.inspect

# Using DailyAverage
daily_average_data = Currensees::DailyAverage.get_daily_average(username, password, date)
puts "Daily average data result:"
puts daily_average_data.inspect

# Using WeeklyAverage
weekly_average = Currensees::WeeklyAverage.get_weekly_average(username, password, from_date, to_date)
puts "Weekly Average result:"
puts weekly_average.inspect

# Using Convert
converted_currency = Currensees::Convert.convert_currency(username, password, convert_date, base_currency, target_currency, convert_amount)
puts "Converted currency result:"
puts converted_currency.inspect

# Using ConvertAll
convert_all_result = Currensees::ConvertAll.convert_all(username, password, base_currency, amount, date)
puts "Conversion for all currencies result:"
puts convert_all_result.inspect
