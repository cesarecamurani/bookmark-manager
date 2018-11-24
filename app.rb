require 'pg'
require 'uri'
require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'
require './database_connection_setup'


class Controller < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.list_all
    erb :bookmarks
  end

  post '/bookmarks' do
    flash[:notice] = "You must submit a valid URL." unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks_update/:id' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :update
  end

  patch '/bookmarks_update/:id' do
    flash[:notice] = "You must submit a valid URL." unless Bookmark.update(id: params[:id],url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end


  run! if app_file == $0
end
