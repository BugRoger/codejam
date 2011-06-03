source "http://rubygems.org"

group :test, :development do
  gem "autotest"                    
  gem "autotest-rails"
	gem "cucumber"  
  gem "rspec"
end

if RUBY_PLATFORM =~ /darwin/
 group :osx do
    gem "autotest-growl", :require => false
    gem "autotest-fsevent", :require => false
  end
end

