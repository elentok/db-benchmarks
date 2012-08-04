require_relative 'migrate'
require 'activerecord-import'

def main
  init_database
  benchmark
end

def benchmark

  n_items = 100_000

  items = []

  creation_time = Benchmark.realtime do

    ActiveRecord::Base.transaction do
    
      (1..n_items).each do |id|
        title = "Item #{id}"

        if id % 1000 == 0
          puts "at id = #{id}"
        end

        Item.create!(
          col1: title, col2: title, col3: title, col4: title, col5: title,
          col6: 10, col7: 20, col8: 30, col9: 40, col10: 50,
          col11: "bla bla bla #{id}",
          col12: '2012-11-15',
          col13: '2012-11-15',
          col14: 1.5,
          col15: 4.5)
        
      end

    end

  end

  puts "Creation time: #{creation_time}"

end

main
