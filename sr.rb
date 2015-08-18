#!/usr/bin/env ruby

$wpm = ARGV.shift.to_i
$chunks = ARGV.shift.to_i
$file = ARGV.shift

$help = <<END
Usage:
  ruby ./sr.rb [ words per minute ] [ word at a time ] [ file ]

Example at a casual pace:
  ruby ./sr.rb 300 5 ./alice-in-wonderland.txt
END

def bail(message, code = 1)
  puts "#{message}\n\n"
  puts $help
  exit code
end

bail 'Please choose a wpm between 60 and 1000' unless (60..1000).include?($wpm)
bail 'Please choose an positive integer word count' unless $chunks.is_a?(Integer) && $chunks > 0
bail 'Please specify a wpm, word count, and file to continue' unless $wpm && $chunks && $file
bail 'File not found', 2 unless File.exist? $file

def hide_cursor
  printf "\e[?25l"
end

def show_cursor
  printf "\e[?25h"
end

def clear_screen
  system 'clear'
end

words_per_second = $wpm/60.0
seconds_per_word = 1.0/words_per_second
timer = seconds_per_word * $chunks

words = File.read($file).split(/\s+/)

begin
  hide_cursor
  until words.empty? do
    clear_screen
    puts words.slice!(0,$chunks).join(' ')
    sleep timer
  end
rescue Interrupt, StandardError => e
  puts e.message
  puts "Exiting..."
ensure
  show_cursor
end

