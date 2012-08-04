require_relative 'activerecord_common'

def main
  connect_to_database
  benchmark
end

def benchmark
  puts "lists, items per list, notes, realtime"
  [10, 100, 1000].each do |lists_count|
    [0, 1, 10, 100].each do |items_per_list|
      clean_database
      time = Benchmark.realtime { create_many_objects(lists_count, items_per_list) }
      puts "#{lists_count}, #{items_per_list}, list.items.build + list.save, #{time}"
    end
  end
end

def create_many_objects(lists_count, items_per_list)
  lists_count.times do |i|
    list = List.new(title: "list #{i}")
    items_per_list.times do |j|
      list.items.build(title: "item #{i}.#{j}")
    end
    list.save!
  end
end

main
