# SpeedReader
Just a small ruby script to help you learn to speed read. It takes a text file and splits it into chunks at the desired rate.

## Usage
```
$ ruby ./sr.rb --help
SpeedReader, a cli utility for speed readers

Usage:
  ruby ./sr.rb [ words per minute ] [ word at a time ] [ file ]

Example at a casual pace:
  ruby ./sr.rb 300 5 ./alice-in-wonderland.txt

Menu:
  q: quit
  j: slow down 50 wpm
  k: speed up 50 wpm
```

## Features
Not a whole lot at the moment, but it works as advertised

* Help options: -h, --help, or help
* Progress menu on the right showing current wpm and percent of text completed
* Non-blocking controls, slow/speed up text

## TODO
Maybe I will turn this into a gem, and add features n stuff

* Enable Pause with space bar
* Switch from ARGV to getopt
* Center text
* Read from a pipe or file
* Read from a file using a byte buffer, for exceptionally long texts

## License

I pulled the book from [Project Gutenberg](https://www.gutenberg.org) and it is subject to thier license. The code is up for grabs under the [GPLv3](http://www.gnu.org/licenses/gpl.txt)
