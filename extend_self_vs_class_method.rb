require 'benchmark/ips'

module M
  extend self

  def a; end
  def self.b; end
end

Benchmark.ips do |x|
  x.report("method on the module") { M.a }
  x.report("method on the metaclass") { M.b }
end

__END__

ruby 2.0.0p195 (2013-05-14 revision 40734) [x86_64-darwin12.3.0]
Calculating -------------------------------------
method on the module    102434 i/100ms
method on the metaclass
                        101531 i/100ms
-------------------------------------------------
method on the module  7280098.3 (±3.4%) i/s -   36364070 in   5.002504s
method on the metaclass
                      7282042.5 (±3.5%) i/s -   36348098 in   4.999297s)
