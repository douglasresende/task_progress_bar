require File.dirname(__FILE__) + '/test_helper.rb'

describe TaskProgressBar do
  parallelize_me!

  let(:total)            { 100 }
  let(:task_progress_bar){ TaskProgressBar.new( total ) }

  describe '#step' do
    subject { task_progress_bar.step() }

    it 'returns the output bar string' do
      expected_result = ''
      STDOUT.stub :print, expected_result do
        assert_equal expected_result, subject
      end
    end
  end

  describe '#bar' do
    subject { task_progress_bar.bar() }

    it 'should return a Bar as a string' do
      expected_result = "\r[0/100][##   ][0%][00:00:00][00:00:01]"

      task_progress_bar.stub(:green_elapsed_bar, '##   ') do
        task_progress_bar.stub(:elapsed_percent, 0) do
          task_progress_bar.stub(:elapsed_time_formated, '00:00:00') do
            task_progress_bar.stub(:time_left, '00:00:01') do
              assert_equal expected_result, subject
            end
          end
        end
      end
    end
  end

  describe '#count' do
    describe 'value default' do
      subject { task_progress_bar.count() }

      it 'should sum @i with 1' do
        assert_equal 1, subject
      end

      describe 'many count method called' do
        it 'it should sum @i many count method called' do
          task_progress_bar.count()
          task_progress_bar.count()
          task_progress_bar.count()
          task_progress_bar.count()
          assert_equal 5, subject
        end
      end
    end

    describe 'value by param' do
      subject { task_progress_bar.count( 3 ) }

      it 'should sum @i with value' do
        assert_equal 3, subject
      end
    end
  end

  describe '#symbol' do
    subject { task_progress_bar.symbol }

    it 'should return the default symbol' do
      assert_equal '#', subject
    end
  end

  describe '#green_elapsed_bar' do
    subject { task_progress_bar.green_elapsed_bar() }

    it 'return the elapsed_bar with green terminal output string' do
      expected_result = 10
      task_progress_bar.stub(:elapsed_bar, expected_result) do
        assert_equal "\033[32m#{ expected_result }\033[0m", subject
      end
    end
  end

  describe '#elapsed_bar' do
    it 'returns the string with percentage and symbols bar quantity' do
      task_progress_bar.count()
      task_progress_bar.stub :bar_quantity, 10 do
        assert_equal task_progress_bar.elapsed_bar, "##########                                        "
      end
    end
  end

  describe '#elapsed_percent' do
    it 'returns the integer percentage' do
      0..(total/2).times { task_progress_bar.count() }
      assert_equal 50, task_progress_bar.elapsed_percent
    end
  end

  describe '#elapsed_time' do
    it 'should return the Time now less @start_time' do
      task_progress_bar.count()
      Time.stub :now, Time.at( Time.now.to_i + 11 ) do
        assert_equal 10, task_progress_bar.elapsed_time.to_i
      end
    end
  end

  describe '#elapsed_time_formated' do
    it 'should return the Time now less @start_time formated with %H:%M:%S' do
      task_progress_bar.count()
      Time.stub :now, Time.at( Time.now.to_i + 11 ) do
        assert_equal '00:00:10', task_progress_bar.elapsed_time_formated
      end
    end
  end

  describe '#time_left_in_seconds' do
    subject { task_progress_bar.time_left_in_seconds }

    describe '@i is zero' do
      it 'should return 0' do
        assert_equal 0, subject
      end
    end

    describe '@i isnt zero' do
      it 'should return the time elapsed in seconds' do
        0..50.times { task_progress_bar.count() }

        Time.stub :now, Time.at( Time.now.to_i + 11 ) do
          assert_equal 10, subject
        end
      end
    end
  end

  describe '#time_left' do
    it 'should return the Time at time_left_in_seconds formated with %H:%M:%S' do
      task_progress_bar.stub :time_left_in_seconds, 3930 do
        assert_equal '01:05:30', task_progress_bar.time_left
      end
    end
  end

  describe '#time_formated' do
    it 'should return the Time formated with %H:%M:%S' do
      value = Time.at( 3930 )
      assert_equal '01:05:30', task_progress_bar.time_formated( value )
    end
  end

end
