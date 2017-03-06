require 'task_progress_bar/version'

class TaskProgressBar
  def initialize(total)
    @total      = total || 1
    @total_bar  = ( total < 50 ? total : 50 )
    @start_time = Time.now
    @i          = 0
  end

  def step
    self.count
    print "\r[%d/%d][%s][%d%%][%s][%s]" % [@i, @total, elapsed_bar.green, elapsed_percent, elapsed_time_formated, time_left]
  end

  def count(value = 1)
    @i += value
  end

  def symbol
    '#'
  end

  def total_progress
    @total / @total_bar
  end

  def bar_quantity
    ((@i*1.00/total_progress).to_i)
  end

  def elapsed_bar
    "%-#{@total_bar}s" % [symbol * bar_quantity]
  end

  def elapsed_percent
    ((@i*1.00/@total)*100).to_i
  end

  def elapsed_time
    Time.now - @start_time
  end

  def elapsed_time_formated
    time_formated( elapsed_time )
  end

  def time_left_in_seconds
    return 0 if @i == 0
    ( (elapsed_time / @i) * (@total.to_f - @i) ).to_i
  end

  def time_left
    time_formated( time_left_in_seconds )
  end

  def time_formated( value )
    Time.at( value ).utc.strftime("%H:%M:%S")
  end
end

