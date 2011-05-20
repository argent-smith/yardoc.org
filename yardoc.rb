require 'rubygems'
require 'sinatra'

set :root, File.dirname(__FILE__)
set :public, Proc.new { File.join(root, "public") }
set :environment, :production

# This before filter ensures that your pages are only ever served 
# once (per deploy) by Sinatra, and then by Varnish after that
before do
  response.headers['Cache-Control'] = 'public, max-age=300' # 5 min
  #response.headers['Cache-Control'] = 'no-cache' # never cache
end

get '*' do
  begin
    File.read(File.join('public', params[:splat], 'index.html'))
  rescue => detail
    404 if detail.class == Errno::ENOENT
  end
end

#not_found do
#  File.read('public/errors/404.html')
#end
