#!/usr/bin/ruby

str = `curl #{ARGV[0]}`
mp3s = []
str.each_line do |line|
  match = line.match(/<guid .+?>(https?:\/\/.+)<\/guid>/)
  mp3s << match[1] if match
end

mp3s.compact!
puts "found #{mp3s.size} mp3s"
mp3s.each do |mp3|
  filename = mp3.match(/\/([^\/]+?\.mp3)/)[1]
  if File.exist?(filename)
    puts "already downloaded #{filename}"
  else
    `curl #{mp3} > #{filename}` 
  end
end
