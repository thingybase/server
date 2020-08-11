# Changes what `to_s` returns on date/time objects in rails.

# Outputs a long format like, "August 2, 2019"
DEFAULT_DATE_FORMAT = "%B %-d, %Y".freeze

Date::DATE_FORMATS[:default] = DEFAULT_DATE_FORMAT
Time::DATE_FORMATS[:default] = DEFAULT_DATE_FORMAT