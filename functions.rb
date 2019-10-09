# General merge sort as
# described by the textbook.
def merge_sort(arr)
  # don't sort an array with length = 1
  if arr.length < 2
    return arr
  end

  # grab the middle point
  ind = arr.length / 2
  # recursively call merge_sort
  a1, a2 = merge_sort(arr[0...ind]), merge_sort(arr[ind..-1])

  n_arr = []

  # sort the sub arrays
  while [a1, a2].none? { |a| a.empty? } do
    if a1[0] < a2[0]
      n_arr << a1.shift
    else
      n_arr << a2.shift
    end
  end

  n_arr + a1 + a2
end

# Insertion sort moves each element
# into it's correct spot one at a time
def insertion_sort(arr)
  i = 1
  while i < arr.length
    j = i
    # move j until it's in the correct place
    while j > 0 && arr[j-1] > arr[j]
      arr[j], arr[j-1] = arr[j-1], arr[j]
      j -= 1
    end
    i += 1
  end
  arr
end

# swap each unsorted pair until whole
# array is sorted
def bubble_sort(arr)
  loop do
    swapped = false
    (1..arr.length - 1).each { |i|
      if (arr[i-1] > arr[i])
        arr[i-1], arr[i] = [arr[i], arr[i-1]]
        swapped = true
      end
    }
    break unless swapped
  end

  arr
end

# this quick sort uses three partitions
# it puts each element into the according
# list according to its relation to pivot,
# and then recursively calls itself on each
# of those partitions. it finally merges
# the recursively generated partitions back
# into the sorted array
def quick_sort(arr, naive = false)
  less, equal, greater = [], [], []

  if (arr.length < 1)
    return arr
  end

  rand_index = rand(arr.length - 1)

  if naive
    pivot = arr[0]
  else
    pivot = arr[rand_index]
  end

  # print "Arr: "; p arr
  # puts "Pivot: #{pivot}"

  arr.each do |x|
    if x < pivot
      less << x
    elsif x == pivot
      equal << x
    elsif x > pivot
      greater << x
    end
  end

  less_sorted = quick_sort(less, naive)
  greater_sorted = quick_sort(greater, naive)

  less_sorted + equal + greater_sorted
end

# this just calls quick_sort with
# naive = true
def naive_quick_sort(arr)
  quick_sort(arr, true)
end