require 'benchmark/ips'
require 'ostruct'
require 'set'

ary = (1..100).step(5).map { |i| OpenStruct.new(ids: [*i..i+10], sent_at: rand) }.shuffle!

set_proc = proc {
  ids = []
  ids_set = Set.new
  ary.sort_by(&:sent_at).each do |o|
    o.ids.each do |id|
      if !ids_set.include?(id)
        ids << id
        ids_set.add(id)
      end
    end
  end
  ids
}

flat_map_uniq_proc = proc {
  ary.sort_by(&:sent_at).flat_map(&:ids).uniq
}

raise unless set_proc.call == flat_map_uniq_proc.call

Benchmark.ips do |x|
  x.report("using set", &set_proc)
  x.report("flat map uniq", &flat_map_uniq_proc)
end

__END__

ruby 1.9.3p385 (2013-02-06 revision 39114) [x86_64-darwin12.2.1]
Calculating -------------------------------------
           using set       841 i/100ms
       flat map uniq      1635 i/100ms
-------------------------------------------------
           using set     8596.1 (±3.2%) i/s -      43732 in   5.092421s
       flat map uniq    17173.5 (±3.6%) i/s -      86655 in   5.052541s
