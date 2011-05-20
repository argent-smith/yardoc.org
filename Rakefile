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

LANG = case ENV['LANG']
       when /utf-8/i then $&
       when /^(.+)\..*$/ then $1 + '.UTF-8'
       else 'en_US.UTF-8'
       end

SET_CMD = case RUBY_PLATFORM 
	  when /mingw32/ then "set"
	  else "export"
	  end

BOOTSTRAP = case RUBY_PLATFORM
	    when /mingw32/ then "ruby"
	    else ""
	    end

desc 'just generate the site'
task :generate do
  sh "#{SET_CMD} LANG=#{LANG} && #{BOOTSTRAP} #{File.join('scripts','generate')}"
end

desc 'serve locally on rack/sinatra'
task :rackup => :generate do
  sh "#{SET_CMD} LANG=#{LANG} && rackup config.ru"
end

desc 'serve locally on thin/sinatra'
task :thin => :generate do
  sh "#{SET_CMD} LANG=#{LANG} && thin start"
end

desc 'remove all generated content'
task :clean do
  sh "git clean -fx -d"
end
