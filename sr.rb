#!/usr/bin/env ruby

$wpm = ARGV.shift.to_i
$word_count = ARGV.shift.to_i
$file = ARGV.shift

$help = <<END
./sr.rb [wpm] [word count] [file]

ex) ./sr.rb 300 5 alice-in-wonderland.txt
END

def bail(message, code = 1)
  puts "#{message}\n\n"
  puts $help
  exit code
end

bail 'Please choose a wpm between 60 and 1000' unless (60..1000).include?($wpm)
bail 'Please choose an positive integer word count' unless $word_count.is_a?(Integer) && $word_count > 0
bail 'Please specify a wpm, word count, and file to continue' unless $wpm && $word_count && $file
bail 'File not found', 2 unless File.exist? $file

words_per_second = $wpm/60.0
seconds_per_word = 1.0/words_per_second
timer = seconds_per_word * $word_count

words = File.read($file).split(/\s+/)

begin
  until words.empty? do
    system 'clear'
    puts words.slice!(0,$word_count).join(' ')
    sleep timer
  end
rescue Interrupt, StandardError => e
  puts e.message
  puts "Exiting..."
end

