#!/usr/bin/env ruby -w
require "minitest"
require "minitest/autorun"

class TestApp < Minitest::Test
  def setup
    @timer = Timer.new
  end

  def test_successful_timer
    assert_equal @timer.times("interval" => 5, "duration" => 10, "departure" => 15), [5, 10, 15]
  end

  # interval

  def test_missing_interval
    exception = assert_raises(RuntimeError) { @timer.times("duration" => 10, "departure" => 15) }
    assert_equal exception.message, "interval missing"
  end

  def test_interval_less_than_one
    exception = assert_raises(RuntimeError) { @timer.times("interval" => -5, "duration" => 10, "departure" => 15) }
    assert_equal exception.message, "interval should be > 0"
  end

  # duration

  def test_missing_duration
    exception = assert_raises(RuntimeError) { @timer.times("interval" => 5, "departure" => 15) }
    assert_equal exception.message, "duration missing"
  end

  def test_duration_less_than_one
    exception = assert_raises(RuntimeError) { @timer.times("interval" => 5, "duration" => -10, "departure" => 15) }
    assert_equal exception.message, "duration should be > 0"
  end

  def test_duration_multiple_of_interval
    exception = assert_raises(RuntimeError) { @timer.times("interval" => 5, "duration" => 11, "departure" => 15) }
    assert_equal exception.message, "duration should be multiple of interval"
  end

  # departure

  def test_missing_departure
    exception = assert_raises(RuntimeError) { @timer.times("interval" => 5, "duration" => 10) }
    assert_equal exception.message, "departure missing"
  end

  def test_departure_less_than_one
    exception = assert_raises(RuntimeError) { @timer.times("interval" => 5, "duration" => 10, "departure" => -15) }
    assert_equal exception.message, "departure should be > 0"
  end

  def test_departure_multiple_of_interval
    exception = assert_raises(RuntimeError) { @timer.times("interval" => 5, "duration" => 10, "departure" => 16) }
    assert_equal exception.message, "departure should be multiple of interval"
  end

end
