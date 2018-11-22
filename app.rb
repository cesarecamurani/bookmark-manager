require 'sinatra/base'
require './lib/bookmark'
require 'pg'

class Controller < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.list_all
    erb :bookmarks
  end

  # get '/bookmarks/new' do
  #   erb :bookmark_new
  # end

  post '/bookmarks' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end


  run! if app_file == $0
end
