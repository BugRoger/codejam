require "thor"
require "thor/group"
require 'active_support/inflector'

module CodeJam
  class Generator < ::Thor::Group
    include Thor::Actions

    desc "Creates a Problem Stub"

    argument :name

    def self.source_root
      File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'templates'))
    end

    def create_bin
      inside 'bin' do
        template 'binary.erb', name.underscore
        chmod name.underscore, 0755
      end
    end

    def create_data
      inside 'data' do
        empty_directory name.underscore 
        template 'problem/test.in',  File.join(name.underscore, 'test.in')
        template 'problem/test.out', File.join(name.underscore, 'test.out')
      end
    end

    def create_problem
      inside 'lib/problems' do
        template 'problem.rb.erb', "#{name.underscore}.rb"
      end
    end

    def create_spec
      inside 'spec/problems' do
        template 'problem_spec.rb.erb', "#{name.underscore}_spec.rb"
      end
    end
  end
end
