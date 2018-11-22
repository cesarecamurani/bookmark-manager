require 'sinatra/base'
require './lib/bookmark'
require 'pg'

class Controller < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.list_all
    erb :bookmarks
  end

  post '/data' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  # post '/bookmarks' do
  #   @bookmarks = Bookmark.list_all
  #   Bookmark.delete(url: params[:del_url])
  #   redirect '/bookmarks'
  # end

  run! if app_file == $0
end
