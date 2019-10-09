FIXNUM_MAX = (2**(0.size * 8 -2) -1)
FIXNUM_MIN = -(2**(0.size * 8 -2))

def is_sorted(arr)
  arr.each_cons(2).all? do |left, right|
    left <= right
  end
end

# generate an array with random ints
def gen_arr(n, min = 0, max = 999999999)
  n.times.map do |x|
    rand(min..max)
  end
end

def test_sorting_algorithm(
    function_name:,
    trials: 100,
    array_size: 100,
    min_int: FIXNUM_MIN,
    max_int: FIXNUM_MAX
)
  if function_name.nil?
    puts "No function name passed to test_sorting_algorithm"
    return
  end

  puts "===================="
  puts "Testing #{function_name}"
  puts "--------------------"

  visual_trials = 5
  visual_array_size = 20
  visual_min_int = 0
  visual_max_int = 1000

  puts "Running small, visual trials:"

  1.upto(visual_trials) do |i|
    arr = gen_arr(visual_array_size, visual_min_int, visual_max_int)
    puts "Unsorted array: #{arr.join ", "}"
    sorted_arr = send(function_name, arr)
    puts "Sorted array: #{sorted_arr.join ", "}"

    status_string = is_sorted(sorted_arr) ? "PASSED" : "FAILED.\n Arr: #{sorted_arr}"

    # Trial i: Function PASSED / FAILED
    puts "Trial #{i}: #{function_name} #{status_string}"
    puts #newline
  end

  print "Running trial number: "


  puts "Running large trials:"

  failed = false
  i = 1

  while i <= trials and !failed
    arr = gen_arr(array_size, min_int, max_int)
    sorted_arr = send(function_name, arr)

    if is_sorted(sorted_arr)
      print " #{i} passed.."
    else
      failed = true
      puts "Trial #{i}: #{function_name} FAILED"
      puts "Array: #{sorted_arr.join(", ")}"
    end

    i += 1
  end
  puts # newline

  puts "All large tests passed" unless failed
  puts # newline
  failed # return failed status
end

