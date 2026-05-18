#!/usr/bin/env ruby

if ARGV.length < 2
  puts "Usage: #{$0} <file> <length>"
  exit 1
end

wordss = File.read(ARGV[0]).downcase.split("\n").shuffle
@words = wordss.join("\n")

def intoparts(word)
  word.chars.each_cons(3).map(&:join)
end

def ppart(parts)
  parts.max_by { |i| @words.scan(/#{Regexp.escape(i)}/).length }
end

def nextb(part)
  match = @words.match(/#{Regexp.escape(part)}([a-z])/)
  match ? match[1] : ("a".."z").to_a.sample
end

def pseudoword(length, wordss)
  random_word = wordss.sample
  parts = intoparts(random_word)
  
  while parts.empty?
    random_word = wordss.sample
    parts = intoparts(random_word)
  end

  str = ppart(parts)
  
  while str.length < length do
    current_suffix = str[-3..-1]
    str += nextb(current_suffix)
  end
  str
end

srand(Time.now.to_i)
puts pseudoword(ARGV[1].to_i, wordss)
