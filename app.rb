require 'sinatra/base'
require './lib/bookmark'
require 'pg'

class Controller < Sinatra::Base

  get '/' do
    redirect '/bookmarks'
    erb :bookmarks
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.list_all
    erb :bookmarks
  end

  run! if app_file == $0
end
