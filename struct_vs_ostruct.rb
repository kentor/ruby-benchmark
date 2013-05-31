require 'benchmark/ips'
require 'ostruct'

NAME = "kentor"

S = Struct.new(:name)

s = S.new(NAME)
o = OpenStruct.new(name: NAME)

Benchmark.ips do |x|
  x.report("struct create") do
    S.new(NAME)
  end

  x.report("ostruct create") do
    OpenStruct.new(name: NAME)
  end

  x.report("struct read") do
    s.name
  end

  x.report("ostruct read") do
    o.name
  end
end

__END__

ruby 1.9.3p385 (2013-02-06 revision 39114) [x86_64-darwin12.2.1]
Calculating -------------------------------------
       struct create     53707 i/100ms
      ostruct create      6259 i/100ms
         struct read     76446 i/100ms
        ostruct read     71987 i/100ms
-------------------------------------------------
       struct create  2096763.5 (±11.4%) i/s -   10365451 in   5.013949s
      ostruct create    82734.4 (±5.2%) i/s -     413094 in   5.007091s
         struct read  5561818.0 (±11.9%) i/s -   27367668 in   5.001684s
        ostruct read  3308200.4 (±9.2%) i/s -   16413036 in   5.007614s

ruby 2.0.0p195 (2013-05-14 revision 40734) [x86_64-darwin12.3.0]
Calculating -------------------------------------
       struct create     66763 i/100ms
      ostruct create      8290 i/100ms
         struct read     83040 i/100ms
        ostruct read     74028 i/100ms
-------------------------------------------------
       struct create  2578532.7 (±10.8%) i/s -   12751733 in   5.009619s
      ostruct create    99844.6 (±12.3%) i/s -     497400 in   5.060982s
         struct read  6578572.2 (±10.9%) i/s -   32468640 in   5.004852s
        ostruct read  3512993.4 (±9.6%) i/s -   17396580 in   5.001943s