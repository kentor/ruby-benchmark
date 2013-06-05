require 'benchmark/ips'

Benchmark.ips do |x|
  x.report("explode") { [*1..100] }
  x.report("Range#to_a") { (1..100).to_a }
end

__END__

ruby 1.9.3p385 (2013-02-06 revision 39114) [x86_64-darwin12.2.1]
Calculating -------------------------------------
             explode     12362 i/100ms
          Range#to_a     13995 i/100ms
-------------------------------------------------
             explode   147962.7 (±2.2%) i/s -     741720 in   5.015553s
          Range#to_a   167734.9 (±2.9%) i/s -     839700 in   5.010728s
