require_relative 'activerecord_common'

def main
  benchmark
  `rm -r tmp`
end

def benchmark
  puts "lists, items per list, notes, realtime"
  [10, 100, 1000].each do |lists_count|
    [0, 1, 10, 100].each do |items_per_list|
      init_database
      time = Benchmark.realtime { create_many_objects_with_bang(lists_count, items_per_list) }
      puts "#{lists_count}, #{items_per_list}, create!, #{time}"
    end
  end
end

def create_many_objects_with_bang(lists_count, items_per_list)
  lists_count.times do |i|
    list = List.create!(title: "list #{i}")
    items_per_list.times do |j|
      Item.create!(title: "item #{i}.#{j}", list: list)
    end
  end
end

main
