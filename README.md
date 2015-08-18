# SpeedReader
Just a small ruby script to help you learn to speed read. It takes a text file and splits it into chunks at the desired rate.

## Usage
```
# ruby ./sr.rb [ words per minute ] [ words at a time ] [ file ]

$ ruby ./sr.rb 300 5 ./alice-in-wonderland.txt
```

## Features
Not a whole lot at the moment, but it works as advertised

## TODO
Maybe I will turn this into a gem, and add features n stuff

* Show the current wpm and percent complete in the top right
* Enable Pause with space bar
* Speed up/down with arrow keys
* Enable quit with q, instead of ctrl + c
* Switch from ARGV to getopt
* Center text
* Read from a pipe or file
* Read from a file using a byte buffer, for exceptionally long texts

## License

I pulled the book from [Project Gutenberg](https://www.gutenberg.org) and it is subject to thier license. The code is up for grabs under the [GPLv3](http://www.gnu.org/licenses/gpl.txt)
