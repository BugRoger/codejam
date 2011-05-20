require "codejam/support"
require "codejam/runner"
require "codejam/problem"

Dir[File.dirname(__FILE__) + "/codejam/problems/*.rb"].each {|file| require file }
