#!/usr/bin/ruby

require 'date'
require 'find'

unless ARGV.length > 0
  puts 'This script makes sure each file has the correct license header'
  puts "Usage: %s name" % __FILE__
  exit
end

name = ARGV.join(' ').strip
year = DateTime.now.year.to_s
apache     = File.open('apache.txt').readlines
template   = apache.join

Dir.glob('{Classes/**/*, Tests/**/*}.[m, h]').each do |f|
  file   = File.open(f, 'r+')
  lines  = file.readlines
  header = template % [File.basename(file.path), year, name]

  # compare the beginning of each file
  # ignore substitutions (%)
  rewrite = false
  if lines.length >= apache.length
    apache.each_with_index do |compare, index|
      if compare != lines[index] && !compare.include?('%')
      	rewrite = true
        puts "#{file.path} - adding header"
        break
      end
    end
  else
    rewrite = true
    puts "#{file.path} - adding header"
  end

  # rewrite the header if necessary
  if rewrite
    lines = lines.drop_while { |l| l =~ /^\/\// }
    file.pos = 0
    file.print(header)
    file.print(lines)
    file.truncate(file.pos)
  end
end
