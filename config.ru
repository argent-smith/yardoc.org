# -*- Ruby -*-
$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'bundler'
Bundler.require

require 'rack/rewrite'
require 'translations'
use Rack::Rewrite do
  r301 %r{.*}, 'http://yardoc.org$&', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] !~ /^(yardoc.org)|(localhost)$/
  }
  r301 %r{^/(docs/.*)}, 'http://rubydoc.info/$1'
  r301 %r{^/(.*)}, '/en/$1', :if => Proc.new {|rack_env|
    rack_env['PATH_INFO'] !~ %r{^/#{(TRANSLATIONS.map {|s| '(' + s + ')'}).join '|'}/}
  }
end

require 'yardoc'
run Sinatra::Application
