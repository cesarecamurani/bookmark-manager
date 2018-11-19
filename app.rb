require 'sinatra/base'
require './lib/bookmark'

class Controller < Sinatra::Base

  get '/' do
    "Cesare"
  end

  get '/bookmarks' do
    Bookmark.list_all
    erb :bookmarks
  end

  run! if app_file == $0
end
