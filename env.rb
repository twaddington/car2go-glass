Encoding.default_internal = 'UTF-8'
require 'rubygems'
require 'bundler/setup'
require 'yaml'
Bundler.require

module Site
  ROOT = File.dirname __FILE__
  LIB_DIR = File.join ROOT, 'lib'
  APP_FILE = File.join ROOT, 'app'
  CONFIG = ::YAML.load_file File.join ROOT, 'config.yml'
end

# DataMapper::Logger.new($stdout, :debug)
# DataMapper.finalize
# DataMapper.setup :default, Site::CONFIG[:database]

Dir.glob(['lib', 'models'].map! {|d| File.join File.expand_path(File.dirname(__FILE__)), d, '*.rb'}).each {|f| require f}

require_relative './app.rb'
Dir.glob(['controllers'].map! {|d| File.join d, '*.rb'}).each do |f| 
  require_relative f
end

