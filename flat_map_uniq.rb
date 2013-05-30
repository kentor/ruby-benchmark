require 'benchmark/ips'
require 'ostruct'
require 'set'

ary = (1..100).step(5).map { |i| OpenStruct.new(:ids => [*i..i+10], :sent_at => rand) }.shuffle!

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
