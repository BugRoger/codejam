# Supporting code can be found at https://github.com/BugRoger/codejam
require "support/logging"

PRECALC = <<PRECALC
0
1
4
9
121
484
10201
12321
14641
40804
44944
1002001
1234321
4008004
100020001
102030201
104060401
121242121
123454321
125686521
400080004
404090404
10000200001
10221412201
12102420121
12345654321
40000800004
1000002000001
1002003002001
1004006004001
1020304030201
1022325232201
1024348434201
1210024200121
1212225222121
1214428244121
1232346432321
1234567654321
4000008000004
4004009004004
100000020000001
100220141022001
102012040210201
102234363432201
121000242000121
121242363242121
123212464212321
123456787654321
400000080000004
10000000200000001
10002000300020001
10004000600040001
10020210401202001
10022212521222001
10024214841242001
10201020402010201
10203040504030201
10205060806050201
10221432623412201
10223454745432201
12100002420000121
12102202520220121
12104402820440121
12122232623222121
12124434743442121
12321024642012321
12323244744232321
12343456865434321
12345678987654321
40000000800000004
40004000900040004
1000000002000000001
1000220014100220001
1002003004003002001
1002223236323222001
1020100204020010201
1020322416142230201
1022123226223212201
1022345658565432201
1210000024200000121
1210242036302420121
1212203226223022121
1212445458545442121
1232100246420012321
1232344458544432321
1234323468643234321
PRECALC

class FairAndSquare 
  include CodeJam::Logging

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      puts "Case ##{i+1}: #{solve(input.shift.chomp)}"
    end
  end

  def solve_slow(input)
    a, b  = input.split.map(&:to_i)
    count = 0
    (a..b).each do |i|
      count += 1 if fair_and_square? i
    end
    count
  end

  def solve(input)
    a, b    = input.split.map(&:to_i)
    precalc = PRECALC.lines.map(&:to_i)

    precalc.select {|i| i >= a && i <= b}.count 
  end
  
  def palindrome?(n)
    n = n.to_s
    return true                  if n.length < 2 
    return palindrome?(n[1..-2]) if n[0] == n[-1]
    false
  end

  def perfect_square?(n)
    h = n & 0xF
    return false if h > 9
    if (h != 2 && h != 3 && h != 5 && h != 6 && h != 7 && h != 8)
      t = (Math.sqrt(n) + 0.5).floor
      return t * t == n 
    end
    false
  end

  def fair_and_square?(n)
    return false unless palindrome?(n)
    return false unless perfect_square?(n)
    return palindrome?(Math.sqrt(n).to_i)
    false
  end
end