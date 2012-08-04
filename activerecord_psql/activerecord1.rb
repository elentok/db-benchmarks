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
      time = Benchmark.realtime { create_many_objects_with_bang(lists_count, items_per_list) }
      puts "#{lists_count}, #{items_per_list}, create!, #{time}"

      clean_database
      time = Benchmark.realtime { create_many_objects_without_bang(lists_count, items_per_list) }
      puts "#{lists_count}, #{items_per_list}, create, #{time}"
    end
  end
end

def create_many_objects_with_bang(lists_count, items_per_list)
  lists_count.times do |i|
    list = List.create!(title: "list #{i}")
    items_per_list.times do |j|
      list.items.create!(title: "item #{i}.#{j}")
    end
  end
end

def create_many_objects_without_bang(lists_count, items_per_list)
  lists_count.times do |i|
    list = List.create(title: "list #{i}")
    items_per_list.times do |j|
      list.items.create(title: "item #{i}.#{j}")
    end
  end
end

main
