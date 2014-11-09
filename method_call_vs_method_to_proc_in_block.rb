require 'benchmark/ips'

Benchmark.ips do |x|
  def identity(x)
    x
  end

  a = [1]

  x.report('using method call') do
    a.each { |x| identity(x) }
  end

  x.report('using Method#to_proc') do
    a.each(&method(:identity))
  end
end

__END__

ruby 2.1.2p95 (2014-05-08 revision 45877) [x86_64-freebsd10.0]
Calculating -------------------------------------
     using method call     19596 i/100ms
  using Method#to_proc     15695 i/100ms
-------------------------------------------------
     using method call  5791647.3 (±14.2%) i/s -   28002684 in   4.978534s
  using Method#to_proc   862208.8 (±12.6%) i/s -    4221955 in   4.999067s

