require "codejam/support"
require "codejam/runner"
require "codejam/splitter"
require "codejam/problem"

Dir[File.dirname(__FILE__) + "/codejam/contests/**/*.rb"].each {|file| require file }
