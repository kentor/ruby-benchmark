require 'benchmark/ips'
require 'ostruct'

stuff = 100.times.map { |i| OpenStruct.new(id: i) }

Benchmark.ips do |x|
  x.report("Hash::[]") do
    Hash[stuff.map { |s| [s.id, s] }]
  end

  x.report("each_with_object") do
    stuff.each_with_object({}) do |s,h|
      h[s.id] = s
    end
  end
end

__END__

ruby 2.0.0p195 (2013-05-14 revision 40734) [x86_64-darwin12.3.0]
Calculating -------------------------------------
            Hash::[]      1408 i/100ms
    each_with_object      1369 i/100ms
-------------------------------------------------
            Hash::[]    14572.8 (±6.4%) i/s -      73216 in   5.046801s
    each_with_object    14230.3 (±6.6%) i/s -      71188 in   5.024550s
