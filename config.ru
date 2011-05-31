# -*- Ruby -*-
$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'bundler'

Bundler.require

require 'rack/rewrite'
use Rack::Rewrite do
  r301 %r{.*}, 'http://yardoc.org$&', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] !~ /^(yardoc.org)|(localhost)$/
  }
  r301 %r{^/(docs/.*)}, 'http://rubydoc.info/$1' 
end

require 'yardoc'
run Sinatra::Application
