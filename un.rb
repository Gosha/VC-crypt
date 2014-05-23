#!/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'docopt'

doc = <<DOCOPT
VC-decoder

usage:
  #{__FILE__} (crypt | decrypt) [TEXT]
  #{__FILE__} (crypt | decrypt)

DOCOPT

$alphabet = "abcdefghijklmnopqrstuvwxyz0123456789 "
$key = "theycallmemisspeacock"

def decrypt(cipher)
  count = 0
  ret = ""
  cipher.each_char do |c|
    begin
      letter = ($alphabet.index(c) - $alphabet.index($key[count])) % $alphabet.length
      ret += $alphabet[letter]
      count = (count + 1) % ($key.length)
    rescue
    end
  end
  ret
end

def crypt(txt)
  count = 0
  ret = ""
  txt.each_char do |c|
    begin
      letter = ($alphabet.index(c) + $alphabet.index($key[count])) % $alphabet.length
      ret += $alphabet[letter]
      count = (count + 1) % ($key.length)
    rescue
    end
  end
  ret
end

begin
  opts = Docopt::docopt(doc)

  #require 'pp'
  #pp opts

  if(opts["TEXT"])
    if(opts["crypt"])
      puts crypt(opts["TEXT"])
    end

    if(opts["decrypt"])
      puts decrypt(opts["TEXT"])
    end
  else
    $stdin.each_line do |line|
      if(opts["crypt"])
        puts crypt(line)
      end

      if(opts["decrypt"])
        puts decrypt(line)
      end
    end
  end

rescue Docopt::Exit => e
  puts e.message
end
