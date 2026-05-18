#!/bin/ruby
words = []
for i in ARGV do
  for i in File.read(i).downcase().split(/\s+/) do
    if i.match?(/\A[a-z]+\z/) && i.length > 2 && !words.include?(i)
        words.push i
        puts i
    end
  end
end
words = words.join "\n"
File.open("./output.txt", "w") { |x| x.write(words) }
