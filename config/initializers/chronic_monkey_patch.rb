# https://gist.github.com/eric1234/3739149
#
# Mass monkey-patching! Provides integration between Chronic, Ruby and
# Rails. So now these all work:
#
#     Date.parse "next summer"
#     DateTime.parse "in 3 hours"
#     Time.parse "3 months ago saturday at 5:00 pm"
#
# In addition we override String#to_date, String#to_datetime, String#to_time.
# These methods are used by older version of ActiveRecord when parsing time.
# For newer versions of ActiveRecord, Date::_parse is overridden to also
# use Chronic. This means you can assign a simple string to a ActiveRecord
# attribute:
#
#     my_obj.starts_at = "thursday last week"
#
# Also since the String method are redefined you can easily create dates
# from strings. For example if you want tomorrow at 2pm you can just do:
#
#     'tomorrow at 2pm'.to_time
#
# This is more readable than the following IMHO:
#
#     1.day.from_now.change hour: 14

module Chronic::Extensions
  module String
    def to_date
      parsed = Chronic::Extensions.safe_parse self
      return parsed.to_date if parsed
      super
    end

    def to_datetime
      parsed = Chronic::Extensions.safe_parse self
      return parsed.to_datetime if parsed
      super
    end

    def to_time
      parsed = Chronic::Extensions.safe_parse self
      return parsed.to_time if parsed
      super
    end
  end
  ::String.prepend String

  module DateTime
    def parse datetime, *args
      parsed = Chronic::Extensions.safe_parse datetime
      return parsed.to_datetime if parsed
      super
    end
  end
  ::DateTime.singleton_class.prepend DateTime

  module Date
    def _parse date, *args
      parsed = Chronic::Extensions.safe_parse(date).try :to_datetime
      if parsed
        %i(year mon mday hour min sec sec_fraction offset).inject({}) do |result, fld|
          value = case fld
            when :offset then (parsed.offset * 86400).to_i
            else parsed.send fld
          end
          result[fld] = value if value && value != 0
          result
        end
      else
        super
      end
    end

    def parse date, *args
      parsed = Chronic::Extensions.safe_parse date
      return parsed.to_date if parsed
      super
    end
  end
  ::Date.singleton_class.prepend Date

  module Time
    def parse time, now=self.now
      parsed = Chronic::Extensions.safe_parse time, now: now
      return parsed if parsed
      super
    end

    def zone
      super.tap do |cur|
        Chronic.time_class = cur
      end
    end

    def zone= timezone
      super.tap do
        Chronic.time_class = zone
      end
    end
  end
  ::Time.singleton_class.prepend Time

  def self.safe_parse value, options={}
    without_recursion { Chronic.parse value, options }
  end

  # There are cases where Chronic actually uses the Ruby date/time libraries.
  # This leads to infinate recursion as our monkey-patch will intercept the
  # built-in libraries to hand off to Chronic which in turn hands back to the
  # built-in libraries.
  #
  # To avoid this we have this function which acts as a guard to prevent the
  # recursion. If we have already proxied off to Chronic we won't proxy again.
  def self.without_recursion &blk
    unless in_recursion
      self.in_recursion = true
      ret = blk.call
      self.in_recursion = false
    end
    ret
  end
  mattr_accessor :in_recursion
end