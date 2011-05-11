require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "devise_omniauth_engine"
  gem.homepage = "http://github.com/johnmcaliley/devise_omniauth_engine"
  gem.license = "MIT"
  gem.summary = %Q{Shortcut for devise and omniauth}
  gem.description = %Q{devise/omniauth shortcut}
  gem.email = "john.mcaliley@gmail.com"
  gem.authors = ["John McAliley"]
  gem.add_dependency 'devise'
  gem.add_dependency 'omniauth'
  gem.add_dependency 'yettings'
  gem.files.exclude 'test_app'
  gem.files.exclude 'Gemfile.lock'
end
Jeweler::RubygemsDotOrgTasks.new