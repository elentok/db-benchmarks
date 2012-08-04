def main
  n_lists = 10000
  n_items = 100

  File.open('lists.csv', 'w') do |lists|
    File.open('items.csv', 'w') do |items|
      #lists.write("id, title\n")
      #items.write("id, list_id, title\n")
      (1..n_lists).each do |i|
        lists.write("#{i}, List #{i}, 2012-08-01, 2012-08-01\n")
        (1..n_items).each do |j|
          items.write("#{i*n_items + j}, Item #{i}.#{j}, #{i}\n")
        end
      end
    end
  end
end

main
