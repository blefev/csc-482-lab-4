require_relative 'functions'
require_relative 'tests'
require 'benchmark'

N = 2
INCREMENT = 2 # actually a scale.
SORTING_FUNCTIONS = %w(bubble_sort insertion_sort merge_sort quick_sort naive_quick_sort)
TRIALS_PER_FUNCTION = {
    'bubble_sort' => 13,
    'insertion_sort' => 13,
    'merge_sort' => 20,
    'quick_sort' => 20,
    'naive_quick_sort' => 20
}

def test_everything
  SORTING_FUNCTIONS.each do |func|
    test_sorting_algorithm(function_name: func)
  end
end

def benchmark_function(function_name, use_average_times = false, pre_sort_arrays = false, file_prefix = "", trials = nil)
  puts "#{function_name}"

  n = N
  increment = INCREMENT
  trials = TRIALS_PER_FUNCTION[function_name] if trials.nil?
  sub_trials = 20

  unless Dir.exists? "output"
    Dir.mkdir "output"
  end

  File.open("output/" + file_prefix + function_name, 'w') do |f|
    #f.puts "n\tTime"
    puts "n\tTime"

    prev = 0
    trials.times.map do
      sum = 0
      sub_trials.times.map do

        arr = gen_arr(n, -99999, 99999)

        if pre_sort_arrays
          arr.sort!
        end

        bm = Benchmark.realtime do |b|
          send(function_name, arr)
        end

        sum += bm

        unless use_average_times
          f.puts("#{n}\t#{bm}")
          puts("#{n},\t#{bm},")
        end

      end

      avg = sum / sub_trials

      if prev != 0
        dbl_ratio = avg / prev
        puts "Doubling time: #{dbl_ratio}"
        puts
      end

      if use_average_times
        f.puts("#{n}\t#{avg}\t#{dbl_ratio}")
        puts("#{n},\t#{avg}\t#{dbl_ratio},")
      end

      prev = avg

      n *= increment
    end

  end

end

def main
  SORTING_FUNCTIONS.each do |function_name|
    benchmark_function(function_name, true)
  end

  %w(naive_quick_sort quick_sort).each do |qs_function_name|
    puts qs_function_name
    benchmark_function(qs_function_name, true, true, 'duel_', 12)
  end

  puts "DONE!"
end

test_everything
main