require 'benchmark/ips'

Benchmark.ips do |x|
  x.report("rand") do
    rand(2) == 0 ? :true : :false
  end

  x.report("sample") do
    [:true, :false].sample
  end
end

__END__

ruby 1.9.3p429 (2013-05-15 revision 40747) [x86_64-darwin12.5.0]
Calculating -------------------------------------
                rand     79756 i/100ms
              sample     84526 i/100ms
-------------------------------------------------
                rand  2670909.6 (±3.7%) i/s -   13399008 in   5.024286s
              sample  3603653.2 (±6.1%) i/s -   18004038 in   5.016060s
