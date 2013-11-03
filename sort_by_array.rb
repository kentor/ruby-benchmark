require 'benchmark/ips'

Benchmark.ips do |x|
  sort_order = [*1..100].shuffle!
  array = sort_order.shuffle.take(50)

  x.report "sort by hash" do
    order_lookup = Hash[sort_order.map.with_index.to_a]
    array.sort_by { |i| order_lookup[i] }
  end

  x.report "sort by &" do
    sort_order & array
  end
end

__END__

ruby 1.9.3p429 (2013-05-15 revision 40747) [x86_64-darwin12.5.0]
Calculating -------------------------------------
        sort by hash      1514 i/100ms
           sort by &      6404 i/100ms
-------------------------------------------------
        sort by hash    15813.8 (±2.0%) i/s -      80242 in   5.076165s
           sort by &    72207.1 (±2.9%) i/s -     365028 in   5.059631s
