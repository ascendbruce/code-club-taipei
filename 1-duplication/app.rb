# Modified from "Refactoring in Ruby" (William C. Wake and Kevin Rutherford) Exercises 8.3: Environment Variables (p. 87)

# 1. run "ruby app.rb" and make sure that it passes all tests
# 2. refactoring app.rb
# 3. run "ruby app.rb" again
# 4. discuss with friends about your solution

class Timer
  def times(env)
    value_s = env['interval']
    if value_s == nil
      raise "interval missing"
    end
    value = Integer(value_s)
    if value <= 0
      raise "interval should be > 0"
    end
    check_interval = value

    value_s = env['duration']
    raise "duration missing" if value_s.nil?
    value = Integer(value_s)
    if value <= 0
      raise "duration should be > 0"
    end
    if (value % check_interval) != 0
      raise "duration should be multiple of interval"
    end
    monitor_time = value

    value_s = env['departure']
    if value_s.nil?
      raise "departure missing"
    end
    value = Integer(value_s)
    raise "departure should be > 0" if value <= 0
    if (value % check_interval) != 0
      raise "departure should be multiple of interval"
    end
    departure_offset = value

    [check_interval, monitor_time, departure_offset]
  end
end

require './tests' if __FILE__ == $0

