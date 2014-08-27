require 'benchmark/ips'

def case_permutation(string)
  string = string.downcase
  case_permute(string)
end

def case_permute(string, idx=0, permutations=[])
  string1 = string.dup
  string2 = string.dup
  string2[idx] = string2[idx].upcase

  if idx == string.length - 1
    permutations << string1
    permutations << string2
    return permutations
  end

  case_permute(string1, idx+1, permutations)
  case_permute(string2, idx+1, permutations)
end

def case_permutation_lambda(string)
  string = string.downcase

  permute = lambda do |string, idx=0, permutations=[]|
    string1 = string.dup
    string2 = string.dup
    string2[idx] = string2[idx].upcase

    if idx == string.length - 1
      permutations << string1
      permutations << string2
      return permutations
    end

    permute.call(string1, idx+1, permutations)
    permute.call(string2, idx+1, permutations)
  end

  permute.call(string)
end

Benchmark.ips do |x|
  x.report("method recursion") do
    case_permutation('abc')
  end

  x.report("lambda recursion") do
    case_permutation_lambda('abc')
  end
end

__END__

ruby 2.0.0p451 (2014-02-24) [x86_64-darwin13.1.0]
Calculating -------------------------------------
    method recursion      7766 i/100ms
    lambda recursion      6453 i/100ms
-------------------------------------------------
    method recursion    89392.7 (±4.8%) i/s -     450428 in   5.051368s
    lambda recursion    73153.7 (±3.4%) i/s -     367821 in   5.034219s
