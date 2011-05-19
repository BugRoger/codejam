#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'magicka/runner'
require 'magicka/solver'


abort("usage: magicka file") unless ARGV[0]

runner = Magicka::Runner.new(STDOUT)
runner.solve_file(ARGV[0])
