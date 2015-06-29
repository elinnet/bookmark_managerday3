require 'sinatra/base'

class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    'Hello BookmarkManager!'
  end

  get '/links' do
    erb :links
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
