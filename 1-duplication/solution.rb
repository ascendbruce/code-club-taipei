#!/usr/bin/env ruby -w
class Timer
  def integer(env, name)
    value = env[name]
    raise "#{name} missing" if value.nil?
    result = Integer(value)
    raise "#{name} should be > 0" if result <= 0
    result
  end

  def multiple(env, name, check_interval)
    value = integer(env, name)
    raise "#{name} should be multiple of interval" unless value % check_interval == 0
    value
  end

  def times(env)
    check_interval   = integer(env, "interval")
    monitor_time     = multiple(env, "duration", check_interval)
    departure_offset = multiple(env, "departure", check_interval)

    [check_interval, monitor_time, departure_offset]
  end
end

require './tests' if __FILE__ == $0
