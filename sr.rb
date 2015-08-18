#!/usr/bin/env ruby

require 'io/wait'
require 'io/console'

$help = <<END
SpeedReader, a cli utility for speed readers

Usage:
  ruby ./sr.rb [ words per minute ] [ word at a time ] [ file ]

Example at a casual pace:
  ruby ./sr.rb 300 5 ./alice-in-wonderland.txt

Menu:
  q: quit
  j: slow down 50 wpm
  k: speed up 50 wpm
END

def leave
  puts 'Exiting...'
  exit
end

def bail(message = nil, code = 1)
  puts "#{message}\n\n" if message
  puts $help
  exit code
end

bail(nil, 0) if ARGV[0] =~ /-*?h(elp)?/i

$wpm = ARGV.shift.to_i
$chunks = ARGV.shift.to_i
$file = ARGV.shift

bail 'Please choose a wpm between 60 and 1000' unless (60..1000).include?($wpm)
bail 'Please choose an positive integer word count' unless $chunks.is_a?(Integer) && $chunks > 0
bail 'Please specify a wpm, word count, and file to continue' unless $wpm && $chunks && $file
bail 'File not found', 2 unless File.exist? $file

def calculate_timer(wpm)
  wpm = [ wpm , 60 ].max
  $words_per_second = wpm/60.0
  $seconds_per_word = 1.0/$words_per_second
  $timer = $seconds_per_word * $chunks
end

calculate_timer($wpm)
words = File.read($file).split(/\s+/)
$words_length = words.length

def hide_cursor
  printf "\e[?25l"
end

def show_cursor
  printf "\e[?25h"
end

def clear_screen
  system 'clear'
end

def screen_size
  sizes = `stty size`
  sizes.split.last.to_i
end

def char_if_pressed
  begin
    system("stty raw -echo") # turn raw input on
    c = nil
    c = $stdin.getc if $stdin.ready?
    $stdin.iflush
    c.chr if c
  ensure
    system "stty -raw echo" # turn raw input off
  end
end

def controls(input)
  return unless input
  case input
  when 'q'
    leave
  when 'k'
    calculate_timer($wpm = $wpm + 50)
  when 'j'
    calculate_timer($wpm = $wpm - 50)
  end
end

def percent(num,den)
  num.to_f/den * 100
end

def percent_in_words(current)
  "%3.2f" % percent(current, $words_length) + '%'
end

def wpm_in_words
  "%4.0f" % $wpm.to_s + ' wpm'
end

def status(length)
  percent_in_words(length) + ' ' + wpm_in_words
end

begin
  hide_cursor
  until words.empty? do
    clear_screen
    controls(char_if_pressed)
    phrase = words.slice!(0,$chunks).join(' ')
    puts phrase + "%#{(screen_size - phrase.length)}s" % status(words.length)
    sleep $timer
  end
rescue Interrupt, StandardError => e
  puts e.message
  leave
ensure
  show_cursor
end
