require "benchmark/ips"
require "scrawl"
require "scrolls"
require "logger"
require "securerandom"

puts ""
puts "OS Name: #{`uname -a`}"
puts `sw_vers`
puts "Ruby Version: #{`ruby -v`}"
puts "RubyGems Version: #{`gem -v`}"
puts "RVM Version: #{`rvm -v`}"
puts ""

Benchmark::IPS.options[:format] = :raw

DATA = (1..100).map { |i| { SecureRandom.hex.to_s => SecureRandom.hex.to_s } }.inject(:merge!)

Benchmark.ips do |analysis|
  analysis.time = 5
  analysis.warmup = 2
  analysis.compare!

  analysis.report "scrawl logging to file" do
    scrawl_logger = Logger.new(File.join("tmp", "scrawl.log"))
    scrawl_logger.log(0, Scrawl.new(DATA.dup).inspect)
  end

  analysis.report "scrolls logging to file" do
    Scrolls.stream = File.open(File.join("tmp", "scrolls.log"), "w")
    Scrolls.log(DATA.dup)
  end
end
