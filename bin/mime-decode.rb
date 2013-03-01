#!/usr/bin/env ruby
# encoding: utf-8

require 'mail'
require "pry"

filename=ARGV[0]
mail = Mail.new(File.open(filename).read)
puts mail.html_part.decoded
