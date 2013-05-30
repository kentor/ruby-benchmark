require 'benchmark/ips'
require 'ostruct'

ary = 100.times.map { OpenStruct.new(num: rand(1..10)) }

module Enumerable
  def group_by_default_proc
    h = Hash.new { |h,k| h[k] = [] }
    each do |o|
      key = yield(o)
      h[key] << o
    end
    h
  end

  def group_by_if_else
    h = {}
    each do |o|
      key = yield(o)
      if h.key?(key)
        h[key] << o
      else
        h[key] = [o]
      end
    end
    h
  end
end

Benchmark.ips do |x|
  x.report("using default_proc") do
    ary.group_by_default_proc(&:num)
  end

  x.report("using if/else") do
    ary.group_by_if_else(&:num)
  end
end

__END__

ruby 2.0.0p195 (2013-05-14 revision 40734) [x86_64-darwin12.3.0]
Calculating -------------------------------------
  using default_proc      2361 i/100ms
       using if/else      1982 i/100ms
-------------------------------------------------
  using default_proc    23503.8 (±7.1%) i/s -     118050 in   5.051623s
       using if/else    23129.1 (±2.8%) i/s -     116938 in   5.060224s
