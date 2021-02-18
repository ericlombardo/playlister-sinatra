require 'sinatra/base'
require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash
  get '/songs' do 
    @songs = Song.all
    erb :"songs/index" 
  end

  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all

    erb :"songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    erb :"songs/show"
  end

  post '/songs' do
    binding.pry
    artist = Artist.create(params[:artist])
    song = artist.songs.create(params[:song])
    flash[:notice] = "Successfully created song."
    redirect "/songs/#{song.slug}"
  end

end